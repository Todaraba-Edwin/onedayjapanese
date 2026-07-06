# Release v.0.1.1

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.1` |
| **날짜** | 2026-07-06 |
| **브랜치** | `main` |

## 요약

일본어 학습 앱 1차 기능 스냅샷 — Alphabet 탭, 히라가나 챕터 골격, 파도 무드 UI, 디자인·학습 문서.

---

## Added

### 앱 (iOS / SwiftUI)

- **Alphabet 탭** — 히라가나 · 가타카나 진입
- **히라가나 Ch.01** — 기본 50음 (콘텐츠 준비 중)
- **히라가나 Ch.02** — 장음·촉음·요음 예시
- **가타카나** — 플레이스홀더
- **파도 배경** — `WaveBackgroundView`, `WaveShape`, 잔잔한 애니메이션
- **디자인 시스템** — `AppColor`, Color Set 16종, `AppSpacing`
- **UI Modifier** — `appScreenBackground`, `appCardStyle`, `appGlassRowBackground`, `appNavigationStyle`
- **네비·탭 바** — 파도 하늘 톤 (회색 material 제거)

### 문서

- `docs/app-desc.md` — 앱 컨셉·IA·로드맵
- `docs/design.md` — 레퍼런스 기반 디자인 시스템·파도 무드
- `docs/SwiftStudy.md` — SwiftUI API 학습 노트 (에이전트 소통용)

## Fixed

- `HiraganaHomeView` — `navigationDestination` 위치 문제로 Ch.01/02 진입 실패 → `NavigationLink { }` 클로저 방식으로 수정
- `AlphabetView` — List 불투명 배경으로 파도 미노출 → `ScrollView` + 글래스 카드
- 상단 Navigation Bar — `.ultraThinMaterial` 회색 블러 → 투명 + `waveSkyTop` 틴트

## Docs

- `docs/README.md` — 문서 인덱스
- `docs/git-Policy.md` — Git·Release 정책
- `Releases/v.0.0/v.0.0.0.md` — 정책 수립 릴리스
- `Releases/v.0.1/v.0.1.1.md` — 이 문서

## 관련 파일

```
japanese-study/japanese-study/
├── ContentView.swift
├── Theme/
│   ├── AppColor.swift
│   ├── Components/WaveBackgroundView.swift
│   └── Modifiers/AppNavigationStyle.swift
└── Views/Alphabet/
docs/
Releases/
```

---

## 다음 마일스톤

→ **v.0.1.3** (예정) — Ch.01 50음도 그리드·데이터 모델
