# Release v.0.1.8

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.8` |
| **날짜** | 2026-07-10 |
| **브랜치** | `dev-desk` |

## 요약

히라가나 Ch.01(아행~나행) 학습 UI를 모아보기·개별보기 모드로 구현하고, 글자·발음·쓰는순서 데이터 모델과 카드 레이아웃을 분리한다.

---

## Added

### 앱 (iOS)

- **`HiraganaChapter01View`** — 행 단위 가로 선택(아·카·사·타·나행), 모아보기/개별보기 세그먼트 전환
- **`HiraganaChapter01Data`** — `HiraganaKanaCharacter` · `HiraganaKanaGroup` · `HiraganaStrokeMarker` · `HiraganaDisplayMode` 데이터 모델, 아행~나행 25자 데이터
- **`HiraganaChapter01Cards`**
  - `CollectionKanaCard` — 1.5 : 1.5 : 2 비율 3열(글자·발음·쓰는순서)
  - `IndividualKanaCard` — 80% 너비 카드 캐러셀, 좌우 카드 peek + 비선택 opacity 60%
  - `StrokeAnnotatedKanaView` — 글자 위 획순 번호 오버레이 (`x`/`y` 상대 좌표)

## Changed

### 앱 (iOS)

- **모아보기** — 글자 블록 파도색 배경·흰 글자, 발음·쓰는순서 중앙 정렬 및 폰트 크기 확대
- **개별보기** — 단일 통합 카드, 글자:발음 세로 2:1 비율·중앙 정렬, 캐러셀 하단 라운드 클리핑 보정(`scrollClipDisabled`)
- **아행 획순** — `あ`·`い`·`う`·`え`·`お` 개별 `strokeMarkers` 좌표 지정

## Docs

- `Releases/v.0.1/v.0.1.8.md` — 이 문서
- `docs/README.md` — v.0.1.8 기준 인덱스·현재 구현 상태 갱신

## 관련 파일

```
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaChapter01View.swift
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaChapter01Data.swift
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaChapter01Cards.swift
Releases/v.0.1/v.0.1.8.md
docs/README.md
```

---

## 다음 마일스톤

→ **v.0.1.9** (예정) — 하행~와행 확장, 획순 좌표 정밀 조정, 단어 예시 연동
