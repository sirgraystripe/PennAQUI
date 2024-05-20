//
//  LocationManager.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared: LocationManager = .init()

    @Published var userCoordinates: UserCoordinates?

    private let clLocationManager = CLLocationManager()
    @Published var locationPermissions: LocationPermissionStatus = .unknown

    override init() {
        super.init()
        clLocationManager.delegate = self
        // Save a bit of power
        clLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        AQILogger.Location.debug("Authorization state: \(self.clLocationManager.authorizationStatus.rawValue)")
    }

    func startMonitoringLocationWithRequest() {
        guard locationPermissions.isGranted else {
            AQILogger.Location.error("Unable to get user location: not authorized. Requesting...")
            clLocationManager.requestWhenInUseAuthorization()
            return
        }
        clLocationManager.startUpdatingLocation()
        AQILogger.Location.info("Started monitoring location")
    }

    func startMonitoringLocationIfAuthorized() {
        if locationPermissions.isGranted {
            clLocationManager.startUpdatingLocation()
            AQILogger.Location.info("Started monitoring (already authorized)")
        }
    }

    func stopMonitoringLocation() {
        clLocationManager.stopUpdatingLocation()
        AQILogger.Location.info("Stopped monitoring location")
    }
}

extension LocationManager {
    // MARK: CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        AQILogger.Location.debug("Location auth status changed: \(manager.authorizationStatus.rawValue)")
        locationPermissions = switch clLocationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: .granted
        case .notDetermined: .unknown
        default: .denied
        }

        if locationPermissions.isGranted {
            clLocationManager.startUpdatingLocation()
            AQILogger.Location.info("Authorized. Started monitoring location.")
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            AQILogger.Location.error("Location data not found in update.")
            return
        }
        let latitude = latestLocation.coordinate.latitude
        let longitude = latestLocation.coordinate.longitude
        Task { @MainActor in
            userCoordinates = UserCoordinates(
                latitude: latitude,
                longitude: longitude
            )
        }
    }

    func locationManager(_: CLLocationManager, didFailWithError error: any Error) {
        AQILogger.Location.error("Failed to get location with error: \(error.localizedDescription)")
    }
}

extension LocationManager {
    /// A little abstraction to simplify cases
    enum LocationPermissionStatus: String {
        case granted
        case denied
        case unknown

        var isGranted: Bool {
            self == .granted
        }

        var description: String {
            rawValue.capitalized
        }
    }
}
