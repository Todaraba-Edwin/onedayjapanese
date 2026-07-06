//
//  AlphabetChapter.swift
//  japanese-study
//

import Foundation

/// 히라가나·가타카나 챕터 정보
struct AlphabetChapter: Identifiable, Hashable {
    let id: String
    let number: Int
    let title: String
    let subtitle: String

    static let hiraganaChapters: [AlphabetChapter] = [
        AlphabetChapter(
            id: "hiragana-ch01",
            number: 1,
            title: "기본 히라가나",
            subtitle: "あ행 ~ わ행, ん"
        ),
        AlphabetChapter(
            id: "hiragana-ch02",
            number: 2,
            title: "특수음",
            subtitle: "장음 · 촉음 · 요음"
        ),
    ]
}
