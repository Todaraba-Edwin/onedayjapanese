//
//  HiraganaChapter01View.swift
//  japanese-study
//

import SwiftUI

/// Chapter 01 — 기본 히라가나 (50음도)
struct HiraganaChapter01View: View {
    @State private var selectedGroupIndex = 0
    @State private var selectedDisplayMode: HiraganaDisplayMode = .collection
    @State private var selectedCharacterIndex = 0

    private let kanaGroups = HiraganaChapter01Data.groups

    private var currentGroup: HiraganaKanaGroup {
        kanaGroups[selectedGroupIndex]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                ChapterHeaderView(
                    chapterNumber: 1,
                    title: "기본 히라가나",
                    description: "아행부터 시작해 카·사·타·나행까지 확장하며 기본 46자를 익힙니다."
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.small) {
                        ForEach(Array(kanaGroups.enumerated()), id: \.element.id) { index, group in
                            Button {
                                selectedGroupIndex = index
                                selectedCharacterIndex = 0
                            } label: {
                                VStack(alignment: .leading, spacing: AppSpacing.extraSmall) {
                                    Text(group.title)
                                        .font(.subheadline.bold())
                                    Text(group.subtitle)
                                        .font(.caption)
                                }
                                .foregroundStyle(index == selectedGroupIndex ? AppColor.textOnPrimary : AppColor.textPrimary)
                                .padding(.horizontal, AppSpacing.medium)
                                .padding(.vertical, AppSpacing.small)
                                .background(
                                    RoundedRectangle(cornerRadius: AppSpacing.badgeRadius, style: .continuous)
                                        .fill(index == selectedGroupIndex ? AppColor.waveNear : AppColor.waveFoam.opacity(0.88))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppSpacing.badgeRadius, style: .continuous)
                                        .stroke(AppColor.waveNear.opacity(index == selectedGroupIndex ? 0 : 0.25), lineWidth: 1)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                Picker("보기 옵션", selection: $selectedDisplayMode) {
                    ForEach(HiraganaDisplayMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)

                if selectedDisplayMode == .collection {
                    VStack(spacing: AppSpacing.small) {
                        ForEach(currentGroup.items, id: \.kana) { item in
                            CollectionKanaCard(item: item, cornerRadius: AppSpacing.cardRadius)
                        }
                    }
                } else {
                    IndividualKanaCard(
                        items: currentGroup.items
                    )
                }
            }
            .padding(AppSpacing.screenHorizontal)
            .padding(.vertical, AppSpacing.small)
        }
        .appScreenBackground()
        .navigationTitle("Ch.01")
        .navigationBarTitleDisplayMode(.inline)
        .appNavigationStyle()
        .tint(AppColor.primary)
    }
}

#Preview {
    NavigationStack {
        HiraganaChapter01View()
    }
}
