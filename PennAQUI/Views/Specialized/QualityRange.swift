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

    var barColor: Color {
        guard let value else {
            return .blue
        }
        return switch value {
        case 0 ... 66: .green
        case 67 ... 99: .yellow
        case 100 ... 149: .orange
        case 150 ... 200: .red
        default: .purple
        }
    }

    var body: some View {
        Chart {
            BarMark(
                x: .value("aqi", ""),
                y: .value(
                    "aqi value",
                    value ?? 0
                )
            )
            .foregroundStyle(barColor)
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
        .animation(.snappy, value: value)
    }
}

#Preview {
    HStack {
        ForEach([10, 68, 143, 199, 400], id: \.self) { i in
            QualityRange(value: .constant(i))
                .frame(width: 50, height: 400)
        }
    }
}
