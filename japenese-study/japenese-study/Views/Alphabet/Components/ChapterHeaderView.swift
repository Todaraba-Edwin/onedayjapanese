//
//  ChapterHeaderView.swift
//  japenese-study
//

import SwiftUI

/// 챕터 상단 헤더
struct ChapterHeaderView: View {
    let chapterNumber: Int
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.s) {
            Text("Chapter \(chapterNumber)")
                .font(.caption.bold())
                .foregroundStyle(AppColor.waveDeep)

            Text(title)
                .font(.title2.bold())
                .foregroundStyle(AppColor.textPrimary)

            Text(description)
                .font(.subheadline)
                .foregroundStyle(AppColor.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ChapterHeaderView(
        chapterNumber: 1,
        title: "기본 히라가나",
        description: "あ행부터 わ행까지"
    )
    .padding()
    .appScreenBackground()
}
