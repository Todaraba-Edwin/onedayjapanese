//
//  AlphabetView.swift
//  japanese-study
//

import SwiftUI

/// Alphabet 탭 — 히라가나·가타카나 학습 진입점
struct AlphabetView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    AlphabetIntroHeader()

                    VStack(spacing: AppSpacing.menuCardStack) {
                        NavigationLink {
                            HiraganaHomeView()
                        } label: {
                            NavigationMenuCard {
                                AlphabetMenuRow(
                                    japaneseTitle: "ひらがな",
                                    koreanTitle: "히라가나",
                                    subtitle: "기본 음절 · 장음 · 촉음 · 요음",
                                    systemImage: "textformat.abc",
                                    tintColor: AppColor.accentHiragana
                                )
                            }
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            KatakanaHomeView()
                        } label: {
                            NavigationMenuCard {
                                AlphabetMenuRow(
                                    japaneseTitle: "カタカナ",
                                    koreanTitle: "가타카나",
                                    subtitle: "외래어·강조 표기",
                                    systemImage: "textformat.abc.dottedunderline",
                                    tintColor: AppColor.accentKatakana
                                )
                            }
                        }
                        .buttonStyle(.plain)
                    }

                    Text("일본어 문자는 히라가나부터 익히는 것을 권장합니다.")
                        .font(.caption)
                        .foregroundStyle(AppColor.textSecondary)
                        .padding(.horizontal, AppSpacing.extraSmall)
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.vertical, AppSpacing.small)
            }
            .navigationTitle("Alphabet")
            .navigationBarTitleDisplayMode(.large)
        }
        .appScreenBackground()
        .appNavigationStyle()
        .tint(AppColor.primary)
    }
}

#Preview {
    AlphabetView()
}
