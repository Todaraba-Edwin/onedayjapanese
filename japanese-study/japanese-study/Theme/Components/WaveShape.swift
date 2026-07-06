//
//  WaveShape.swift
//  japanese-study
//

import SwiftUI

/// 사인 곡선 기반 파도 실루엣
struct WaveShape: Shape {
    /// 파도 위상 (애니메이션용)
    var phase: CGFloat
    /// 파도 높이
    var amplitude: CGFloat
    /// 파도 기준선 (0~1, rect 높이 비율)
    var baseline: CGFloat
    /// 파도 밀도
    var frequency: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baseY = rect.height * baseline
        let step: CGFloat = 2

        path.move(to: CGPoint(x: 0, y: baseY))

        stride(from: CGFloat(0), through: rect.width, by: step).forEach { positionX in
            let relativeX = positionX / rect.width
            let angle = (relativeX * frequency * .pi * 2) + (phase * .pi * 2)
            let waveY = baseY + sin(angle) * amplitude
            path.addLine(to: CGPoint(x: positionX, y: waveY))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}
