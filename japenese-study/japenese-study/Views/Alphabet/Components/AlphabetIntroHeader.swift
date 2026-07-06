//
//  AlphabetIntroHeader.swift
//  japenese-study
//

import SwiftUI

/// Alphabet 탭 상단 — 파도 무드 인트로
struct AlphabetIntroHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.s) {
            HStack(spacing: AppSpacing.s) {
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
        .padding(AppSpacing.m)
        .appCardStyle()
    }
}

#Preview {
    AlphabetIntroHeader()
        .padding()
        .appScreenBackground()
}
