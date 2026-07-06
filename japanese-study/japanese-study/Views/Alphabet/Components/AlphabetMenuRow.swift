//
//  AlphabetMenuRow.swift
//  japanese-study
//

import SwiftUI

/// Alphabet 메뉴 목록 행
struct AlphabetMenuRow: View {
    let japaneseTitle: String
    let koreanTitle: String
    let subtitle: String
    let systemImage: String
    let tintColor: Color

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(tintColor)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: AppSpacing.extraSmall) {
                HStack(spacing: AppSpacing.small) {
                    Text(japaneseTitle)
                        .font(.title3)
                        .foregroundStyle(AppColor.textPrimary)
                    Text(koreanTitle)
                        .font(.subheadline)
                        .foregroundStyle(AppColor.textSecondary)
                }

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(AppColor.textSecondary)
            }
        }
        .padding(.vertical, AppSpacing.extraSmall)
    }
}

#Preview {
    List {
        AlphabetMenuRow(
            japaneseTitle: "ひらがな",
            koreanTitle: "히라가나",
            subtitle: "기본 음절",
            systemImage: "textformat.abc",
            tintColor: AppColor.accentHiragana
        )
    }
}
