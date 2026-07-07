//
//  AlphabetIntroHeader.swift
//  japanese-study
//

import SwiftUI

/// Alphabet 탭 상단 — 하단 네비게이션 카드를 안내하는 문구 (선택 UI 아님)
struct AlphabetIntroHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack(spacing: AppSpacing.small) {
                Image(systemName: "water.waves")
                    .font(.title3)
                    .foregroundStyle(AppColor.waveNear)

                Text("문자 선택")
                    .font(.headline)
                    .foregroundStyle(AppColor.waveDeep)
            }

            Text("일본어의 첫걸음, 히라가나부터 차근차근 시작해 보세요.")
                .font(.subheadline)
                .foregroundStyle(AppColor.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack(spacing: AppSpacing.large) {
        AlphabetIntroHeader()

        NavigationMenuCard {
            AlphabetMenuRow(
                japaneseTitle: "ひらがな",
                koreanTitle: "히라가나",
                subtitle: "기본 음절",
                systemImage: "textformat.abc",
                tintColor: AppColor.accentHiragana
            )
        }
    }
    .padding(AppSpacing.screenHorizontal)
    .appScreenBackground()
}
