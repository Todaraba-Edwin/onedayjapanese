# Design System — japenese-study

레퍼런스 [`reperence/layout_01.png`](../reperence/layout_01.png)를 기준으로, 일본어 학습 앱에 맞게 재해석한 디자인 가이드입니다.

---

## 1. 디자인 방향

### 레퍼런스에서 가져올 요소

| 요소 | 레퍼런스 특징 | 앱 적용 |
|------|---------------|---------|
| **톤** | 밝고 깔끔, 여백 많음 | 학습 집중용 차분한 라이트 UI |
| **Primary** | 선명한 스카이 블루 헤더·CTA | 탭·헤더·주요 버튼·챕터 뱃지 |
| **Surface** | 흰 카드 + 부드러운 그림자 | 문자 카드·챕터·메뉴 행 |
| **형태** | 큰 라운드(필 버튼·카드) | 버튼·입력·학습 카드 |
| **네비게이션** | 하단 탭 바 | Alphabet → Practice → … 확장 |

### 레퍼런스에서 조정할 요소

- e-commerce 상품 그리드 → **문자·챕터 학습 카드**로 치환
- Wishlist/Cart 등 커머스 카피 → **학습 진도·챕터** 용어로 교체
- 히라가나/가타카나 구분은 **Primary 블루 + 보조 액센트**로 표현

### 파도 무드 (Wave Theme)

일본을 연상시키는 **바다·파도(波)** 를 앱 전체 무드로 적용합니다.

| 요소 | 설명 |
|------|------|
| **배경** | `WaveBackgroundView` — 하늘 그라데이션 + 4겹 파도 레이어 |
| **애니메이션** | 10초 주기 잔잔한 위상 이동 (학습 방해 최소) |
| **카드** | 반투명 `waveFoam` 글래스 — 파도 위에 떠 있는 느낌 |
| **네비·탭 바** | `ultraThinMaterial` / 반투명 흰색 |
| **구현** | `Theme/Components/WaveBackgroundView.swift` |

---

## 2. 색상 (Color Palette)

### 2.1 브랜드 컬러

| 토큰 | Hex | SwiftUI (권장) | 용도 |
|------|-----|----------------|------|
| `primary` | `#3B9EFF` | `Color("Primary")` | 헤더 배경, CTA, 활성 탭, Ch 뱃지 |
| `primaryDark` | `#2B7FD9` | `Color("PrimaryDark")` | 눌림 상태, 그라데이션 하단 |
| `primaryLight` | `#E8F4FF` | `Color("PrimaryLight")` | 선택 배경, 섹션 하이라이트 |
| `primaryGradientTop` | `#4A9EFF` | — | 헤더 그라데이션 상단 |
| `primaryGradientBottom` | `#2E8AE6` | — | 헤더 그라데이션 하단 |

> 레퍼런스의 스카이 블루 톤을 기준으로 정의. 구현 시 `Assets.xcassets` Color Set으로 등록.

### 2.2 배경·표면

| 토큰 | Hex | 용도 |
|------|-----|------|
| `background` | `#F5F7FA` | 앱 전체 배경 (순백보다 살짝 회색) |
| `surface` | `#FFFFFF` | 카드·리스트 행·모달 |
| `surfaceElevated` | `#FFFFFF` + shadow | 떠 있는 카드 (문자 타일) |

### 2.3 텍스트

| 토큰 | Hex | 용도 |
|------|-----|------|
| `textPrimary` | `#1C1C1E` | 제목·본문 |
| `textSecondary` | `#8E8E93` | 부제·캡션·placeholder |
| `textOnPrimary` | `#FFFFFF` | 블루 헤더 위 텍스트 |
| `textJapanese` | `#1C1C1E` | ひらがな·カタカナ 대형 표시 |

### 2.4 액센트·피드백

| 토큰 | Hex | 용도 |
|------|-----|------|
| `accentGold` | `#FFB800` | 완료·별점·강조 (레퍼런스 별 색) |
| `accentHiragana` | `#FF6B8A` | 히라가나 메뉴 아이콘·칩 (선택) |
| `accentKatakana` | `#3B9EFF` | 가타카나 — Primary와 동일 계열 |
| `success` | `#34C759` | 정답 |
| `error` | `#FF3B30` | 오답 |
| `divider` | `#E5E5EA` | 구분선 |

### 2.5 다크 모드 (Phase 3)

- Primary 채도 유지, 배경 `#000000` / surface `#1C1C1E`
- 1차 릴리스는 라이트 모드 우선

---

## 3. 타이포그래피

레퍼런스: 모던 산세리프, 굵은 제목 + 가벼운 본문.

### 3.1 폰트

| 용도 | iOS 기본 | 스타일 |
|------|----------|--------|
| 대형 일본어 문자 | SF Pro / 시스템 | `.largeTitle` ~ 48pt, bold |
| 화면 제목 | SF Pro | `.title2` / `.title`, bold |
| 섹션 제목 | SF Pro | `.headline` |
| 본문 | SF Pro | `.body` |
| 캡션·부제 | SF Pro | `.caption` / `.subheadline`, secondary color |
| CTA 버튼 | SF Pro | `.subheadline`, **semibold**, 대문자 허용 (SIGN IN 스타일) |

### 3.2 계층 예시

```
[헤더]  ひらがな          — title2, textOnPrimary
[챕터]  Ch.01 기본 히라가나 — headline + caption
[문자]  あ               — 40~48pt bold
[로마자] a                — subheadline, textSecondary
```

### 3.3 일본어 표기

- 메뉴: **일본어(크게) + 한국어(작게)** 병기 — 현재 `AlphabetMenuRow` 패턴 유지
- 학습 카드: 문자만 크게, 로마자·한글 뜻은 보조

---

## 4. 간격·레이아웃

레퍼런스: 넉넉한 패딩, 2열 그리드, 카드 간 일정 간격.

| 토큰 | 값 | 용도 |
|------|-----|------|
| `spacingXS` | 4pt | 아이콘-텍스트 미세 간격 |
| `spacingS` | 8pt | 칩·태그 간격 |
| `spacingM` | 16pt | 카드 내부 패딩, 리스트 행 |
| `spacingL` | 24pt | 섹션 간격 |
| `spacingXL` | 32pt | 화면 상하 여백 |
| `screenHorizontal` | 20pt | 화면 좌우 기본 마진 |

### 그리드

- **문자 카드**: 2열 (`LazyVGrid`, minimum 150pt), 간격 12~16pt
- **챕터 목록**: 단일 열 리스트, 행 높이 ~72pt
- **예시 단어(Ch.02)**: `FlowLayout`, 칩 간격 8pt

---

## 5. 모양 (Shape & Elevation)

| 요소 | Radius | Shadow |
|------|--------|--------|
| Primary 버튼 (필) | `cornerRadius: 24` (캡슐) | `y: 4, blur: 8, opacity: 0.12` |
| 카드 (문자·챕터) | `16~20pt` | `y: 2, blur: 8, opacity: 0.08` |
| 입력 필드 | `24pt` (필) | border `#E5E5EA` 또는 약한 shadow |
| Ch 뱃지 | `10~12pt` | 없음, `primary` fill |
| 하단 탭 바 | 시스템 기본 | — |

---

## 6. 컴포넌트 스펙

### 6.1 헤더 (레퍼런스: 상단 블루 블록)

```
┌─────────────────────────────┐
│  ▓▓▓ Primary Gradient ▓▓▓  │  높이 ~120pt (large title) 또는 inline
│         ひらがな            │  textOnPrimary, centered or leading
└─────────────────────────────┘
│  surface content...         │
```

- `NavigationStack` large title → 추후 커스텀 헤더 또는 `toolbarBackground(primary)` 로 통일
- 뒤로가기: 시스템 기본 chevron, 흰색/primary tint

### 6.2 하단 탭 바

| 탭 | 아이콘 (SF Symbol) | 라벨 |
|----|-------------------|------|
| Alphabet | `character.ja` | Alphabet |
| Practice (예정) | `checkmark.circle` | Practice |
| Progress (예정) | `chart.bar` | Progress |

- 활성: `primary` + 아이콘 fill
- 비활성: `textSecondary`

### 6.3 Alphabet 메뉴 행 (`AlphabetMenuRow`)

레퍼런스의 리스트/설정 행 → **흰 surface 카드 스타일**로 발전:

```
┌──────────────────────────────────┐
│ [icon]  ひらがな  히라가나    >   │
│         기본 음절 · 장음 · …      │
└──────────────────────────────────┘
```

- 배경: `surface`, radius 16, padding `spacingM`
- 아이콘: 36×36, `accentHiragana` / `accentKatakana`
- List inset grouped 스타일 또는 `ScrollView` + `VStack` 카드

### 6.4 챕터 행 (`ChapterRow`)

```
┌──────────────────────────────────┐
│ [Ch.1]  기본 히라가나         >   │
│         あ행 ~ わ행, ん         │
└──────────────────────────────────┘
```

- Ch 뱃지: 44×44, `primary` 배경, `textOnPrimary`
- 전체를 카드로 감싸 레퍼런스 product row와 유사한 터치 영역 확보

### 6.5 문자 학습 카드 (Ch.01 예정)

레퍼런스 product card 변형:

```
┌─────────────┐
│             │
│      あ     │  40~48pt
│      a      │  caption, secondary
│   [ 🔊 ]    │  optional
└─────────────┘
```

- 2열 그리드, `surface` + shadow
- 탭: `primaryLight` 배경 플래시 또는 scale 애니메이션

### 6.6 Primary CTA 버튼

레퍼런스 `SIGN IN` 스타일:

- 배경: `primary` 또는 상하 그라데이션
- 텍스트: `textOnPrimary`, semibold
- 높이: 48~52pt, horizontal padding 24pt
- 모서리: 완전 캡슐

### 6.7 칩 / 예시 단어 (Ch.02)

- 배경: `#F2F2F7` 또는 `primaryLight`
- radius: 8pt
- 패딩: H 12, V 8
- 폰트: `title3` (일본어 가독성)

---

## 7. 화면별 적용 가이드

### Alphabet 홈

| 요소 | 적용 |
|------|------|
| 배경 | `background` |
| Navigation title | Alphabet, large |
| 섹션 | 카드 2개 (히라가나·가타카나) |
| Footer | `textSecondary` 안내 문구 |

### 히라가나 홈

| 요소 | 적용 |
|------|------|
| Title | ひらがな |
| 목록 | Ch.01 · Ch.02 카드 행 |
| 진행률 (추후) | `accentGold` 또는 progress bar |

### Ch.01 / Ch.02

| 요소 | 적용 |
|------|------|
| Header | `ChapterHeaderView` — 챕터 번호 caption + title2 |
| 본문 | ScrollView, `spacingL` |
| Empty | `ContentUnavailableView` → 추후 커스텀 일러스트 |

---

## 8. 아이콘

- **스타일**: SF Symbols, thin / regular (레퍼런스 line icon에 대응)
- **크기**: 메뉴 `title2`, 탭 `default`

| 의미 | Symbol |
|------|--------|
| Alphabet | `character.ja` |
| 히라가나 | `textformat.abc` |
| 가타카나 | `textformat.abc.dottedunderline` |
| 발음 | `speaker.wave.2` |
| 완료 | `checkmark.circle.fill` |

---

## 9. 모션

| 상호작용 | 스펙 |
|----------|------|
| 화면 전환 | 시스템 push 기본 |
| 버튼 탭 | `scaleEffect(0.97)`, 0.15s ease |
| 카드 탭 | 배경색 0.2s fade |
| 정답 피드백 | 짧은 haptic + `success` flash |

---

## 10. 구현 체크리스트

디자인 문서 → 코드 반영 순서:

- [x] `Assets.xcassets`에 Color Set 추가 (`Primary`, `PrimaryLight`, `Background`, …)
- [x] `AppColor.swift`로 토큰 중앙 관리
- [x] `AccentColor` → `#3B9EFF` 로 업데이트
- [x] `AlphabetMenuRow` / `ChapterRow` 테마 색상 적용
- [ ] Navigation bar / toolbar primary 배경 (선택)
- [ ] Ch.01 문자 카드 그리드 컴포넌트

### SwiftUI Color Set 예시 (Primary)

```json
{
  "colors": [
    {
      "color": {
        "color-space": "srgb",
        "components": {
          "red": "0.231",
          "green": "0.620",
          "blue": "1.000",
          "alpha": "1.000"
        }
      },
      "idiom": "universal"
    }
  ]
}
```

---

## 11. 레퍼런스 대비 매핑 요약

```
layout_01.png          →  japenese-study
─────────────────────────────────────────
Sign In 블루 헤더      →  챕터/문자 화면 헤더
Product 카드 그리드    →  50음도 문자 카드 그리드
Wishlist 하트          →  즐겨찾기 문자 (추후)
Bottom Tab (5)         →  TabView (Alphabet 우선, 확장)
Pill SIGN IN 버튼      →  학습 시작 / 다음 문제 CTA
Star rating gold       →  진도·완료 강조
```

이 문서는 구현이 진행되면서 수치·컴포넌트를 업데이트합니다.
