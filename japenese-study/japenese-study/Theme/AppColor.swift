//
//  AppColor.swift
//  japenese-study
//

import SwiftUI

/// 디자인 시스템 색상 토큰 (Assets.xcassets)
enum AppColor {
    // MARK: - Brand
    static let primary = Color("Primary")
    static let primaryDark = Color("PrimaryDark")
    static let primaryLight = Color("PrimaryLight")
    static let primaryGradientTop = Color("PrimaryGradientTop")
    static let primaryGradientBottom = Color("PrimaryGradientBottom")

    // MARK: - Surface
    static let background = Color("Background")
    static let surface = Color("Surface")

    // MARK: - Text
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let textOnPrimary = Color("TextOnPrimary")

    // MARK: - Accent
    static let accentGold = Color("AccentGold")
    static let accentHiragana = Color("AccentHiragana")
    static let accentKatakana = Color("AccentKatakana")

    // MARK: - Feedback
    static let success = Color("Success")
    static let error = Color("Error")
    static let divider = Color("Divider")

    // MARK: - Wave (파도 무드)
    static let waveSkyTop = Color(red: 0.93, green: 0.97, blue: 1.00)
    static let waveSkyBottom = Color(red: 0.84, green: 0.93, blue: 0.99)
    static let waveHorizon = Color(red: 0.72, green: 0.88, blue: 0.98)
    static let waveMist = Color(red: 0.90, green: 0.96, blue: 1.00)
    static let waveFar = Color(red: 0.66, green: 0.85, blue: 0.98)
    static let waveMid = Color(red: 0.45, green: 0.74, blue: 0.96)
    static let waveNear = Color(red: 0.23, green: 0.62, blue: 1.00)   // Primary 계열
    static let waveDeep = Color(red: 0.12, green: 0.42, blue: 0.78)
    static let waveFoam = Color(red: 0.97, green: 0.99, blue: 1.00)

    /// Primary 헤더·CTA용 그라데이션
    static let primaryGradient = LinearGradient(
        colors: [primaryGradientTop, primaryGradientBottom],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
