//
//  HiraganaHomeView.swift
//  japanese-study
//

import SwiftUI

/// 히라가나 챕터 목록
struct HiraganaHomeView: View {
    var body: some View {
        List(AlphabetChapter.hiraganaChapters) { chapter in
            // navigationDestination은 NavigationStack 루트에 있어야 해서
            // 푸시된 화면에서는 NavigationLink(destination:) 방식을 사용
            NavigationLink {
                chapterDestination(for: chapter)
            } label: {
                ChapterRow(chapter: chapter)
            }
            .appGlassRowBackground()
        }
        .appListStyle()
        .appScreenBackground()
        .navigationTitle("ひらがな")
        .navigationBarTitleDisplayMode(.large)
        .appNavigationStyle()
        .tint(AppColor.primary)
    }

    @ViewBuilder
    private func chapterDestination(for chapter: AlphabetChapter) -> some View {
        switch chapter.id {
        case "hiragana-ch01":
            HiraganaChapter01View()
        case "hiragana-ch02":
            HiraganaChapter02View()
        default:
            ContentUnavailableView(
                "준비 중",
                systemImage: "exclamationmark.triangle",
                description: Text("이 챕터는 아직 준비되지 않았습니다.")
            )
        }
    }
}

#Preview {
    NavigationStack {
        HiraganaHomeView()
    }
}
