# Release v.0.1.5

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.5` |
| **날짜** | 2026-07-07 |
| **브랜치** | `dev-ios` |

## 요약

Alphabet 탭 히라가나·가타카나 카드 간격(16pt)을 기준으로, 히라가나 홈 Ch.01·Ch.02 목록 간격을 동일하게 통일하고 디자인 규칙으로 정립한다.

---

## Changed

### 앱 (iOS)

- **`AppSpacing.menuCardStack`** — 스택형 네비게이션 카드 간격 토큰 추가 (16pt, `medium`과 동일)
- **`NavigationMenuCard`** — Alphabet·챕터 공통 카드 래퍼 (chevron + `appCardStyle`)
- **`AlphabetView`** — `NavigationMenuCard` 적용, 히라가나↔가타카나 카드 간격 `menuCardStack` 명시
- **`HiraganaHomeView`** — `List` inset grouped → `ScrollView` + `VStack(spacing: menuCardStack)` 카드 스택으로 변경 (Ch.01↔Ch.02 간격 Alphabet과 동일)

### 문서

- `docs/design.md` — 스택형 네비게이션 카드 간격 Design Rule 섹션 추가
- `agent.md` — `menuCardStack` 토큰 요약 추가

## Docs

- `Releases/v.0.1/v.0.1.5.md` — 이 문서
- `docs/README.md` — v.0.1.5 기준 인덱스 갱신
- `docs/design.md` — 메뉴·챕터 카드 간격 규칙

## 관련 파일

```
japanese-study/japanese-study/Theme/AppSpacing.swift
japanese-study/japanese-study/Views/Alphabet/AlphabetView.swift
japanese-study/japanese-study/Views/Alphabet/Components/NavigationMenuCard.swift
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaHomeView.swift
docs/design.md
agent.md
Releases/v.0.1/v.0.1.5.md
```

---

## 다음 마일스톤

→ **v.0.1.6** (예정) — Ch.01 50음도 그리드·데이터 모델
