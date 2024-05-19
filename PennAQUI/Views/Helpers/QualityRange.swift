//
//  QualityRange.swift
//  PennAQUI
//
//  Created by Peter Kos on 5/19/24.
//

import Charts
import SwiftUI

struct QualityRange: View {
    @Binding var value: Int?

    var body: some View {
        Chart {
            BarMark(
                x: .value("aqi", ""),
                y: .value(
                    "aqi value",
                    value ?? 0
                )
            )
            .clipShape(.capsule)
        }
        .chartXScale(domain: [""], type: .category)
        .chartYScale(domain: 1 ... 500, type: .symmetricLog(slopeAtZero: 1))
        .chartYAxis {
            AxisMarks(
                position: .leading,
                values: [1, 10, 20, 30, 50, 100, 200, 300, 500]
            )
        }
    }
}

#Preview {
    QualityRange(value: .constant(200))
        .frame(width: 50, height: 400)
}
