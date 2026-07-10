//
//  HiraganaChapter01Data.swift
//  japanese-study
//

import Foundation

struct HiraganaStrokeMarker {
    let number: Int
    let relativeX: Double
    let relativeY: Double
}

struct HiraganaKanaCharacter {
    let kana: String
    let romaji: String
    let strokeMarkers: [HiraganaStrokeMarker]
}

struct HiraganaKanaGroup {
    let id: String
    let title: String
    let subtitle: String
    let items: [HiraganaKanaCharacter]
}

enum HiraganaDisplayMode: String, CaseIterable, Identifiable {
    case collection
    case single

    var id: String { rawValue }

    var title: String {
        switch self {
        case .collection: return "모아보기"
        case .single: return "개별보기"
        }
    }
}

enum HiraganaChapter01Data {
    static let groups: [HiraganaKanaGroup] = [
        .init(
            id: "a-row",
            title: "아행",
            subtitle: "あ · い · う · え · お",
            items: [
                // あ: 1) 가로선, 2) 세로선, 3) 세로 + 시계방향 원
                .init(
                    kana: "あ",
                    romaji: "a",
                    strokeMarkers: [
                        .init(number: 1, relativeX: 0.16, relativeY: 0.28),
                        .init(number: 2, relativeX: 0.42, relativeY: 0.04),
                        .init(number: 3, relativeX: 0.58, relativeY: 0.46),
                    ]
                ),
                .init(
                    kana: "い",
                    romaji: "i",
                    strokeMarkers: [
                        .init(number: 1, relativeX: 0.3, relativeY: 0.1),
                        .init(number: 2, relativeX: 0.64, relativeY: 0.14),
                    ]
                ),
                .init(
                    kana: "う",
                    romaji: "u",
                    strokeMarkers: [
                        .init(number: 1, relativeX: 0.3, relativeY: 0.18),
                        .init(number: 2, relativeX: 0.18, relativeY: 0.44),
                    ]
                ),
                .init(
                    kana: "え",
                    romaji: "e",
                    strokeMarkers: [
                        .init(number: 1, relativeX: 0.28, relativeY: 0.16),
                        .init(number: 2, relativeX: 0.18, relativeY: 0.4),
                    ]
                ),
                .init(
                    kana: "お",
                    romaji: "o",
                    strokeMarkers: [
                        .init(number: 1, relativeX: 0.16, relativeY: 0.34),
                        .init(number: 2, relativeX: 0.4, relativeY: 0.04),
                        .init(number: 3, relativeX: 0.58, relativeY: 0.14),
                    ]
                ),
            ]
        ),
        .init(
            id: "ka-row",
            title: "카행",
            subtitle: "か · き · く · け · こ",
            items: [
                .init(kana: "か", romaji: "ka", strokeMarkers: markers(3)),
                .init(kana: "き", romaji: "ki", strokeMarkers: markers(4)),
                .init(kana: "く", romaji: "ku", strokeMarkers: markers(1)),
                .init(kana: "け", romaji: "ke", strokeMarkers: markers(3)),
                .init(kana: "こ", romaji: "ko", strokeMarkers: markers(2)),
            ]
        ),
        .init(
            id: "sa-row",
            title: "사행",
            subtitle: "さ · し · す · せ · そ",
            items: [
                .init(kana: "さ", romaji: "sa", strokeMarkers: markers(3)),
                .init(kana: "し", romaji: "shi", strokeMarkers: markers(1)),
                .init(kana: "す", romaji: "su", strokeMarkers: markers(2)),
                .init(kana: "せ", romaji: "se", strokeMarkers: markers(3)),
                .init(kana: "そ", romaji: "so", strokeMarkers: markers(1)),
            ]
        ),
        .init(
            id: "ta-row",
            title: "타행",
            subtitle: "た · ち · つ · て · と",
            items: [
                .init(kana: "た", romaji: "ta", strokeMarkers: markers(4)),
                .init(kana: "ち", romaji: "chi", strokeMarkers: markers(2)),
                .init(kana: "つ", romaji: "tsu", strokeMarkers: markers(1)),
                .init(kana: "て", romaji: "te", strokeMarkers: markers(1)),
                .init(kana: "と", romaji: "to", strokeMarkers: markers(2)),
            ]
        ),
        .init(
            id: "na-row",
            title: "나행",
            subtitle: "な · に · ぬ · ね · の",
            items: [
                .init(kana: "な", romaji: "na", strokeMarkers: markers(4)),
                .init(kana: "に", romaji: "ni", strokeMarkers: markers(3)),
                .init(kana: "ぬ", romaji: "nu", strokeMarkers: markers(2)),
                .init(kana: "ね", romaji: "ne", strokeMarkers: markers(2)),
                .init(kana: "の", romaji: "no", strokeMarkers: markers(1)),
            ]
        ),
    ]

    private static func markers(_ count: Int) -> [HiraganaStrokeMarker] {
        let markerPositions: [(relativeX: Double, relativeY: Double)] = [
            (0.22, 0.20),
            (0.64, 0.30),
            (0.38, 0.62),
            (0.72, 0.72),
        ]

        return (0..<count).map { index in
            let position = markerPositions[min(index, markerPositions.count - 1)]
            return .init(number: index + 1, relativeX: position.relativeX, relativeY: position.relativeY)
        }
    }
}
