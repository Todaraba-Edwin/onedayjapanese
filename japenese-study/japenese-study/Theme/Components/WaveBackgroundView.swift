//
//  WaveBackgroundView.swift
//  japenese-study
//

import SwiftUI

/// 일본 바다·파도 무드의 전체 화면 배경
struct WaveBackgroundView: View {
    /// 잔잔한 파도 흔들림 (0이면 정지)
    var animated: Bool = true

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 30)) { timeline in
            let phase = animated
                ? timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 10) / 10
                : 0

            GeometryReader { geometry in
                let height = geometry.size.height
                let width = geometry.size.width

                ZStack {
                    // 하늘 → 수면 그라데이션
                    LinearGradient(
                        colors: [
                            AppColor.waveSkyTop,
                            AppColor.waveSkyBottom,
                            AppColor.waveHorizon,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    // 먼 곳 수평선 안개
                    Circle()
                        .fill(AppColor.waveMist.opacity(0.35))
                        .frame(width: width * 0.9, height: width * 0.5)
                        .blur(radius: 40)
                        .offset(x: width * 0.15, y: -height * 0.28)

                    // 뒤쪽 파도 (연한)
                    WaveShape(
                        phase: CGFloat(phase) * 0.3,
                        amplitude: height * 0.018,
                        baseline: 0.58,
                        frequency: 1.2
                    )
                    .fill(AppColor.waveFar.opacity(0.45))

                    // 중간 파도
                    WaveShape(
                        phase: CGFloat(phase) * 0.5 + 0.15,
                        amplitude: height * 0.024,
                        baseline: 0.66,
                        frequency: 1.5
                    )
                    .fill(AppColor.waveMid.opacity(0.55))

                    // 앞쪽 파도 (진한)
                    WaveShape(
                        phase: CGFloat(phase) * 0.7 + 0.3,
                        amplitude: height * 0.028,
                        baseline: 0.74,
                        frequency: 1.8
                    )
                    .fill(AppColor.waveNear.opacity(0.7))

                    // 수면 아래 깊은 바다
                    WaveShape(
                        phase: CGFloat(phase) * 0.4 + 0.5,
                        amplitude: height * 0.012,
                        baseline: 0.82,
                        frequency: 2.0
                    )
                    .fill(AppColor.waveDeep)

                    // 하단 심해 그라데이션
                    LinearGradient(
                        colors: [
                            AppColor.waveDeep.opacity(0),
                            AppColor.waveDeep.opacity(0.85),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: height * 0.35)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WaveBackgroundView()
}
