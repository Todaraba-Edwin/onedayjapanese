//
//  HiraganaChapter01View.swift
//  japanese-study
//

import SwiftUI

/// Chapter 01 — 기본 히라가나 (50음도)
struct HiraganaChapter01View: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                ChapterHeaderView(
                    chapterNumber: 1,
                    title: "기본 히라가나",
                    description: "あ행부터 わ행, ん까지 기본 46자를 익힙니다."
                )

                // TODO: 50음도 그리드·학습 카드 추가 예정
                ContentUnavailableView(
                    "학습 콘텐츠 준비 중",
                    systemImage: "character.ja",
                    description: Text("곧 50음도 표와 연습 문제가 추가됩니다.")
                )
                .frame(minHeight: 280)
            }
            .padding(AppSpacing.screenHorizontal)
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
