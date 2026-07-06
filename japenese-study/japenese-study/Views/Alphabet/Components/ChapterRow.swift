//
//  ChapterRow.swift
//  japenese-study
//

import SwiftUI

/// 챕터 목록 행
struct ChapterRow: View {
    let chapter: AlphabetChapter

    var body: some View {
        HStack(spacing: AppSpacing.m) {
            Text("Ch.\(chapter.number)")
                .font(.caption.bold())
                .foregroundStyle(AppColor.textOnPrimary)
                .frame(width: 44, height: 44)
                .background(
                    LinearGradient(
                        colors: [AppColor.waveNear, AppColor.waveDeep],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    in: RoundedRectangle(cornerRadius: AppSpacing.badgeRadius)
                )

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(chapter.title)
                    .font(.headline)
                    .foregroundStyle(AppColor.textPrimary)
                Text(chapter.subtitle)
                    .font(.caption)
                    .foregroundStyle(AppColor.textSecondary)
            }
        }
        .padding(.vertical, AppSpacing.xs)
    }
}

#Preview {
    List {
        ChapterRow(chapter: AlphabetChapter.hiraganaChapters[0])
    }
}
