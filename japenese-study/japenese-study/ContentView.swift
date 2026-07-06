//
//  ContentView.swift
//  japenese-study
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 탭 바 영역까지 파도가 비치도록 루트 배경 유지
            WaveBackgroundView()
            TabView {
                AlphabetView()
                    .tabItem {
                        Label("Alphabet", systemImage: "character.ja")
                    }
            }
        }
        .tint(AppColor.primary)
    }
}

#Preview {
    ContentView()
}
