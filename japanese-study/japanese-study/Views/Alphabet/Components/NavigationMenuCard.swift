//
//  NavigationMenuCard.swift
//  japanese-study
//

import SwiftUI

/// Alphabet·챕터 등 네비게이션 메뉴 카드 공통 래퍼
/// - 카드 간 간격: `AppSpacing.menuCardStack` (16pt)
/// - 카드 내부 패딩: `AppSpacing.medium` (16pt)
struct NavigationMenuCard<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            content()

            Spacer(minLength: AppSpacing.small)

            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundStyle(AppColor.waveNear.opacity(0.55))
        }
        .padding(AppSpacing.medium)
        .appCardStyle()
    }
}

#Preview {
    VStack(spacing: AppSpacing.menuCardStack) {
        NavigationMenuCard {
            AlphabetMenuRow(
                japaneseTitle: "ひらがな",
                koreanTitle: "히라가나",
                subtitle: "기본 음절",
                systemImage: "textformat.abc",
                tintColor: AppColor.accentHiragana
            )
        }

        NavigationMenuCard {
            ChapterRow(chapter: AlphabetChapter.hiraganaChapters[0])
        }
    }
    .padding(AppSpacing.screenHorizontal)
    .appScreenBackground()
}
