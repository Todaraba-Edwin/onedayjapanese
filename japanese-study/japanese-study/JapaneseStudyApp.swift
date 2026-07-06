//
//  JapaneseStudyApp.swift
//  japanese-study
//

import SwiftUI
import UIKit

@main
struct JapaneseStudyApp: App {
    init() {
        AppNavigationAppearance.configure()
        configureTabBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    /// 탭 바 — 파도 하늘 톤 (회색 기본값 제거)
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundEffect = nil
        tabBarAppearance.backgroundColor = UIColor(AppColor.waveSkyTop.opacity(0.82))
        tabBarAppearance.shadowColor = UIColor(AppColor.waveNear.opacity(0.10))

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(AppColor.textSecondary)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(AppColor.textSecondary)]
        itemAppearance.selected.iconColor = UIColor(AppColor.waveNear)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(AppColor.waveNear)]
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
