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
    private var isAuthorized: Bool {
        switch clLocationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: true
        default: false
        }
    }

    override init() {
        super.init()
        self.clLocationManager.delegate = self
        AQILogger.Location.info("Authorization state: \(self.clLocationManager.authorizationStatus.rawValue)")
    }

    func getUserLocation() {
        guard isAuthorized else {
            AQILogger.Location.error("Unable to get user location: not authorized. Requesting...")
            clLocationManager.requestWhenInUseAuthorization()
            return
        }
        clLocationManager.startMonitoringVisits()
        AQILogger.Location.info("Started monitoring location")
    }

    func stopMonitoringLocation() {
        clLocationManager.stopMonitoringVisits()
        AQILogger.Location.info("Stopped monitoring location")
    }

    func locationManagerDidPauseLocationUpdates(_: CLLocationManager) {
        AQILogger.Location.info("Did pause location updates")
    }

    // MARK: CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        AQILogger.Location.debug("Location auth status changed: \(manager.authorizationStatus.rawValue)")

        if isAuthorized {
            clLocationManager.startMonitoringVisits()
            AQILogger.Location.info("Started monitoring location after permissions request")
        }
    }

    func locationManager(_: CLLocationManager, didVisit visit: CLVisit) {
        let latitude = visit.coordinate.latitude
        let longitude = visit.coordinate.longitude
        AQILogger.Location.info("User entered (\(latitude), \(longitude)) at \(visit.arrivalDate)")
        Task { @MainActor in
            userCoordinates = UserCoordinates(
                latitude: latitude,
                longitude: longitude
            )
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        AQILogger.Location.info("locations: \(locations)")
    }

    func locationManager(_: CLLocationManager, didFailWithError error: any Error) {
        AQILogger.Location.error("Failed to get location with error: \(error.localizedDescription)")
    }
}
