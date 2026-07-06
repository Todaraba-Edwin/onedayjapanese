# japanese-study 문서

일본어 학습 iOS 앱(`japanese-study`)의 기획·디자인 문서 모음입니다.

## 문서 목록

| 문서 | 설명 |
|------|------|
| [app-desc.md](./app-desc.md) | 앱 컨셉, 목표 사용자, 기능 구조, 로드맵 |
| [design.md](./design.md) | `reperence/layout_01.png` 기반 색상·타이포·컴포넌트 디자인 시스템 |
| [SwiftStudy.md](./SwiftStudy.md) | 프로젝트에서 쓴 Swift/SwiftUI API 학습 노트 (에이전트 소통용) |
| [git-Policy.md](./git-Policy.md) | 브랜치, SemVer, 태그, Release 문서 정책 |

## Release 노트

| 버전 | 경로 |
|------|------|
| v.0.0.0 | [`../Releases/v.0.0/v.0.0.0.md`](../Releases/v.0.0/v.0.0.0.md) |
| v.0.1.1 | [`../Releases/v.0.1/v.0.1.1.md`](../Releases/v.0.1/v.0.1.1.md) |
| v.0.1.2 | [`../Releases/v.0.1/v.0.1.2.md`](../Releases/v.0.1/v.0.1.2.md) |
| v.0.1.3 | [`../Releases/v.0.1/v.0.1.3.md`](../Releases/v.0.1/v.0.1.3.md) |
| v.0.1.4 | [`../Releases/v.0.1/v.0.1.4.md`](../Releases/v.0.1/v.0.1.4.md) |
| v.0.1.5 | [`../Releases/v.0.1/v.0.1.5.md`](../Releases/v.0.1/v.0.1.5.md) |
| v.0.1.6 | [`../Releases/v.0.1/v.0.1.6.md`](../Releases/v.0.1/v.0.1.6.md) |

에이전트 진입 문서: [`../agent.md`](../agent.md)

## 레퍼런스

- UI 레퍼런스: [`../reperence/layout_01.png`](../reperence/layout_01.png)
- Xcode 프로젝트: [`../japanese-study/`](../japanese-study/)

## 현재 구현 상태 (v.0.1.6 — 2026-07-07)

- **앱 브랜드**: 홈 화면 표시 이름 **원데이재페니즈**, 번들 ID `edwin.OneDayJapanese`
- **앱 아이콘**: oneday japanese 파도 무드 — iOS `AppIcon` + `web/` 메타 아이콘
- **Alphabet** 탭: 히라가나 · 가타카나 진입 (`menuCardStack` 16pt 카드 간격)
- **히라가나 홈**: Ch.01 · Ch.02 — Alphabet과 동일한 카드 스택 간격 (`NavigationMenuCard`)
- **히라가나 Ch.01**: 기본 50음 — 콘텐츠 준비 중
- **히라가나 Ch.02**: 장음 · 촉음 · 요음 — 예시·콘텐츠 준비 중
- **가타카나**: 플레이스홀더
- **파도 무드 UI** + 디자인 시스템 적용 완료
- **개발 브랜치**: `dev-ios` (iOS UI 작업)
