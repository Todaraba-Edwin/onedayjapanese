//
//  KatakanaHomeView.swift
//  japenese-study
//

import SwiftUI

/// 가타카나 학습 (추후 챕터 확장)
struct KatakanaHomeView: View {
    var body: some View {
        ContentUnavailableView(
            "가타카나",
            systemImage: "textformat.abc.dottedunderline",
            description: Text("히라가나 학습 후 가타카나 챕터가 추가됩니다.")
        )
        .appScreenBackground()
        .navigationTitle("カタカナ")
        .navigationBarTitleDisplayMode(.large)
        .appNavigationStyle()
        .tint(AppColor.primary)
    }
}

#Preview {
    NavigationStack {
        KatakanaHomeView()
    }
}
