//
//  HiraganaChapter01Cards.swift
//  japanese-study
//

import SwiftUI

struct CollectionKanaCard: View {
    let item: HiraganaKanaCharacter
    let cornerRadius: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let columnSpacing = AppSpacing.small
            let usableWidth = geometry.size.width - (columnSpacing * 2)
            let unitWidth = usableWidth / 5

            HStack(spacing: columnSpacing) {
                // 1.5 비율: 글자 블록 (배경색 + 흰색 글자)
                VStack(spacing: AppSpacing.extraSmall) {
                    VStack(spacing: AppSpacing.extraSmall) {
                        Text(item.kana)
                            .font(.system(size: 50, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    Text("단어")
                        .font(.caption.bold())
                }
                .foregroundStyle(AppColor.textOnPrimary)
                .frame(width: unitWidth * 1.5)
                .frame(maxHeight: .infinity)
                .padding(.vertical, AppSpacing.small)
                .background(
                    RoundedRectangle(cornerRadius: AppSpacing.badgeRadius, style: .continuous)
                        .fill(AppColor.waveNear)
                )

                // 1.5 비율: 발음 블록
                VStack(spacing: AppSpacing.extraSmall) {
                    VStack(spacing: AppSpacing.extraSmall) {
                        Text(koreanPronunciation(for: item.kana))
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(AppColor.textPrimary)
                        Text(item.romaji.uppercased())
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppColor.textSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    Text("발음")
                        .font(.caption)
                        .foregroundStyle(AppColor.textSecondary)
                }
                .frame(width: unitWidth * 1.5)
                .frame(maxHeight: .infinity)
                .padding(.vertical, AppSpacing.small)
                .appCardStyle(cornerRadius: AppSpacing.badgeRadius)

                // 2 비율: 쓰는 순서 블록
                VStack(spacing: AppSpacing.extraSmall) {
                    StrokeAnnotatedKanaView(item: item, fontSize: 57.4, markerScale: 0.84)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    Text("쓰는순서")
                        .font(.caption)
                        .foregroundStyle(AppColor.textSecondary)
                }
                .frame(width: unitWidth * 2)
                .frame(maxHeight: .infinity)
                .padding(.vertical, AppSpacing.small)
                .appCardStyle(cornerRadius: AppSpacing.badgeRadius)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .frame(height: 120)
        .padding(AppSpacing.medium)
        .appCardStyle(cornerRadius: cornerRadius)
    }

    private func koreanPronunciation(for kana: String) -> String {
        switch kana {
        case "あ": return "아"
        case "い": return "이"
        case "う": return "우"
        case "え": return "에"
        case "お": return "오"
        case "か": return "카"
        case "き": return "키"
        case "く": return "쿠"
        case "け": return "케"
        case "こ": return "코"
        case "さ": return "사"
        case "し": return "시"
        case "す": return "스"
        case "せ": return "세"
        case "そ": return "소"
        case "た": return "타"
        case "ち": return "치"
        case "つ": return "츠"
        case "て": return "테"
        case "と": return "토"
        case "な": return "나"
        case "に": return "니"
        case "ぬ": return "누"
        case "ね": return "네"
        case "の": return "노"
        default: return ""
        }
    }
}

struct IndividualKanaCard: View {
    let items: [HiraganaKanaCharacter]

    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width * 0.8
            let sideInset = (geometry.size.width - cardWidth) / 2

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AppSpacing.medium) {
                    ForEach(items, id: \.kana) { item in
                        GeometryReader { cardGeometry in
                            let contentHeight = cardGeometry.size.height - (AppSpacing.medium * 2)
                            let topHeight = contentHeight * (2.0 / 3.0)
                            let bottomHeight = contentHeight * (1.0 / 3.0)

                            VStack(spacing: AppSpacing.medium) {
                                VStack(spacing: AppSpacing.extraSmall) {
                                    Text("글자")
                                        .font(.caption)
                                        .foregroundStyle(AppColor.textSecondary)
                                    StrokeAnnotatedKanaView(item: item, fontSize: 179.2, markerScale: 1.1)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .offset(y: topHeight * 0.1)
                                }
                                .frame(maxWidth: .infinity, minHeight: topHeight, maxHeight: topHeight, alignment: .center)

                                VStack(spacing: AppSpacing.extraSmall) {
                                    Text("발음")
                                        .font(.caption)
                                        .foregroundStyle(AppColor.textSecondary)
                                    HStack(spacing: AppSpacing.small) {
                                        Text(koreanPronunciation(for: item.kana))
                                            .font(.system(size: 28, weight: .bold))
                                            .foregroundStyle(AppColor.textPrimary)
                                        Text(item.romaji.uppercased())
                                            .font(.system(size: 24, weight: .semibold))
                                            .foregroundStyle(AppColor.waveNear)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .frame(maxWidth: .infinity, minHeight: bottomHeight, maxHeight: bottomHeight, alignment: .center)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(AppSpacing.medium)
                            .appCardStyle()
                        }
                        .frame(width: cardWidth)
                        .padding(.vertical, AppSpacing.extraSmall)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content.opacity(phase.isIdentity ? 1.0 : 0.6)
                        }
                    }
                }
                .scrollTargetLayout()
                .padding(.vertical, AppSpacing.small)
                .padding(.horizontal, sideInset)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
        }
        .frame(height: 420)
    }

    private func koreanPronunciation(for kana: String) -> String {
        switch kana {
        case "あ": return "아"
        case "い": return "이"
        case "う": return "우"
        case "え": return "에"
        case "お": return "오"
        case "か": return "카"
        case "き": return "키"
        case "く": return "쿠"
        case "け": return "케"
        case "こ": return "코"
        case "さ": return "사"
        case "し": return "시"
        case "す": return "스"
        case "せ": return "세"
        case "そ": return "소"
        case "た": return "타"
        case "ち": return "치"
        case "つ": return "츠"
        case "て": return "테"
        case "と": return "토"
        case "な": return "나"
        case "に": return "니"
        case "ぬ": return "누"
        case "ね": return "네"
        case "の": return "노"
        default: return ""
        }
    }
}

private struct StrokeAnnotatedKanaView: View {
    let item: HiraganaKanaCharacter
    let fontSize: CGFloat
    let markerScale: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(item.kana)
                    .font(.system(size: fontSize, weight: .bold))
                    .foregroundStyle(AppColor.waveDeep)

                ForEach(item.strokeMarkers, id: \.number) { marker in
                    Text("\(marker.number)")
                        .font(.caption2.bold())
                        .foregroundStyle(AppColor.textOnPrimary)
                        .padding(.horizontal, 5 * markerScale)
                        .padding(.vertical, 2 * markerScale)
                        .background(
                            Capsule(style: .continuous)
                                .fill(AppColor.waveNear.opacity(0.9))
                        )
                        .position(
                            x: geometry.size.width * marker.relativeX,
                            y: geometry.size.height * marker.relativeY
                        )
                }
            }
        }
        .frame(width: fontSize * 1.4, height: fontSize * 1.25)
    }
}
