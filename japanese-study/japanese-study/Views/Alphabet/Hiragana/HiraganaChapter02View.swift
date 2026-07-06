//
//  HiraganaChapter02View.swift
//  japanese-study
//

import SwiftUI

/// Chapter 02 — 장음·촉음·요음
struct HiraganaChapter02View: View {
    private let specialSoundSections: [(title: String, examples: [String])] = [
        ("장음 (長音)", ["おかあさん", "おとうさん", "すうがく"]),
        ("촉음 (促音)", ["がっこう", "きって", "まって"]),
        ("요음 (拗音)", ["きょう", "しゅう", "りょう"]),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                ChapterHeaderView(
                    chapterNumber: 2,
                    title: "특수음",
                    description: "장음, 촉음, 요음 규칙을 익힙니다."
                )

                ForEach(specialSoundSections, id: \.title) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(section.title)
                            .font(.headline)
                            .foregroundStyle(AppColor.textPrimary)

                        FlowLayout(spacing: AppSpacing.small) {
                            ForEach(section.examples, id: \.self) { example in
                                Text(example)
                                    .font(.title3)
                                    .foregroundStyle(AppColor.textPrimary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, AppSpacing.small)
                                    .background(AppColor.waveFoam.opacity(0.85))
                                    .clipShape(RoundedRectangle(cornerRadius: AppSpacing.chipRadius))
                            }
                        }
                    }
                }

                // TODO: 규칙 설명·연습 문제 추가 예정
                ContentUnavailableView(
                    "학습 콘텐츠 준비 중",
                    systemImage: "waveform",
                    description: Text("곧 발음 규칙과 연습이 추가됩니다.")
                )
                .frame(minHeight: 200)
            }
            .padding(AppSpacing.screenHorizontal)
        }
        .appScreenBackground()
        .navigationTitle("Ch.02")
        .navigationBarTitleDisplayMode(.inline)
        .appNavigationStyle()
        .tint(AppColor.primary)
    }
}

#Preview {
    NavigationStack {
        HiraganaChapter02View()
    }
}
