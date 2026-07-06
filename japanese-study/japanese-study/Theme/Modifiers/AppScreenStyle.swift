//
//  AppScreenStyle.swift
//  japanese-study
//

import SwiftUI

/// 파도 배경 + 콘텐츠 레이어
struct AppScreenBackgroundModifier: ViewModifier {
    var animatedWaves: Bool = true

    func body(content: Content) -> some View {
        ZStack {
            WaveBackgroundView(animated: animatedWaves)
            content
        }
    }
}

/// 카드형 surface + 파도 위에 떠 있는 느낌의 그림자
struct AppCardStyle: ViewModifier {
    var cornerRadius: CGFloat = AppSpacing.cardRadius

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(AppColor.waveFoam.opacity(0.94))
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: AppColor.waveDeep.opacity(0.14), radius: 10, x: 0, y: 4)
    }
}

/// 리스트 행 — 반투명 유리 카드
struct AppGlassRowBackground: View {
    var cornerRadius: CGFloat = 12

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(AppColor.waveFoam.opacity(0.88))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(AppColor.waveNear.opacity(0.12), lineWidth: 1)
            )
            .shadow(color: AppColor.waveDeep.opacity(0.10), radius: 8, x: 0, y: 3)
    }
}

extension View {
    /// 파도 배경 위에 콘텐츠 배치
    func appScreenBackground(animatedWaves: Bool = true) -> some View {
        modifier(AppScreenBackgroundModifier(animatedWaves: animatedWaves))
    }

    /// 흰 카드 스타일
    func appCardStyle(cornerRadius: CGFloat = AppSpacing.cardRadius) -> some View {
        modifier(AppCardStyle(cornerRadius: cornerRadius))
    }

    /// List 배경 투명 + 파도 노출
    func appListStyle() -> some View {
        self
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
    }

    /// 리스트 행 글래스 배경
    func appGlassRowBackground(cornerRadius: CGFloat = 12) -> some View {
        listRowBackground(AppGlassRowBackground(cornerRadius: cornerRadius))
    }
}
