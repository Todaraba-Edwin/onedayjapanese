//
//  AppNavigationStyle.swift
//  japenese-study
//

import SwiftUI
import UIKit

/// 네비게이션 바 전역 스타일 — 파도 하늘 톤 (회색 material 제거)
enum AppNavigationAppearance {
    static func configure() {
        let scrollEdgeAppearance = makeAppearance(backgroundOpacity: 0)
        let standardAppearance = makeAppearance(backgroundOpacity: 0.78)

        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactScrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.tintColor = UIColor(AppColor.waveNear)
    }

    private static func makeAppearance(backgroundOpacity: CGFloat) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = nil
        appearance.shadowColor = UIColor(AppColor.waveNear.opacity(0.12))

        if backgroundOpacity > 0 {
            appearance.backgroundColor = UIColor(AppColor.waveSkyTop.opacity(backgroundOpacity))
        } else {
            appearance.backgroundColor = .clear
        }

        let titleColor = UIColor(AppColor.waveDeep)
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]

        return appearance
    }
}

extension View {
    /// body 파도 배경과 동일한 톤의 네비게이션 바
    func appNavigationStyle() -> some View {
        self
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
    }
}
