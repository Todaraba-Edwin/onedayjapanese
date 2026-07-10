# Agent Guide — japanese-study

AI 에이전트(Cursor 등)가 이 프로젝트에서 작업할 때 참조하는 **루트 진입 문서**입니다.

---

## 빠른 링크

| 문서 | 경로 | 용도 |
|------|------|------|
| **Git 정책** | [`docs/git-Policy.md`](docs/git-Policy.md) | 브랜치, 커밋, 태그, Release 규칙 |
| **앱 기획** | [`docs/app-desc.md`](docs/app-desc.md) | 컨셉, IA, 챕터, 로드맵 |
| **디자인** | [`docs/design.md`](docs/design.md) | 색상, 파도 무드, 컴포넌트 |
| **Swift 학습** | [`docs/SwiftStudy.md`](docs/SwiftStudy.md) | 사용 API·에이전트 요청 예시 |
| **문서 인덱스** | [`docs/README.md`](docs/README.md) | docs 전체 목록 |

---

## 프로젝트 한 줄

> iOS(SwiftUI) 일본어 문자 학습 앱 — **Alphabet 탭**에서 히라가나·가타카나 단계 학습.

- **Xcode 프로젝트:** `japanese-study/japanese-study/`
- **UI 레퍼런스:** `reperence/layout_01.png`
- **기본 브랜치:** `main`

---

## Release 명명 규칙

### 폴더 (마이너 단위)

```
Releases/v.{MAJOR}.{MINOR}/v.{MAJOR}.{MINOR}.{PATCH}.md
```

| 폴더 | 태그 범위 | 의미 |
|------|-----------|------|
| `Releases/v.0.0/` | v.0.0.0 ~ | 저장소·정책 초기화 |
| `Releases/v.0.1/` | v.0.1.1 ~ | Alphabet · 히라가나 기초 |
| `Releases/v.0.2/` | v.0.2.1 ~ | (예정) 50음도 그리드·연습 |

- PATCH는 **1부터** (v.0.1.1, v.0.2.1 …)
- 태그 형식: **`v.MAJOR.MINOR.PATCH`** (예: `v.0.1.1`)

### 릴리스 작업 요청 템플릿

```
docs/git-Policy.md 정책에 따라:
1. Releases/v.0.1/v.0.1.{N}.md 작성
2. main에 커밋
3. annotated tag v.0.1.{N} 생성
```

---

## docs 명명 규칙

| 파일 | 내용 |
|------|------|
| `app-desc.md` | 앱 설명·기획 (App Description) |
| `design.md` | 디자인 시스템 |
| `SwiftStudy.md` | Swift/SwiftUI API 학습 노트 |
| `git-Policy.md` | Git·Release 정책 |

새 문서는 `docs/` 아래, `kebab-case.md` 또는 `PascalStudy.md` 형태. 인덱스는 `docs/README.md`에 등록.

---

## 코드 구조 (에이전트용)

```
japanese-study/japanese-study/
├── ContentView.swift          # TabView 루트
├── Theme/
│   ├── AppColor.swift
│   ├── Components/            # WaveBackgroundView 등
│   └── Modifiers/             # appScreenBackground, appNavigationStyle
├── Models/
└── Views/Alphabet/
    ├── AlphabetView.swift
    ├── Hiragana/
    └── Katakana/
```

### 자주 쓰는 Modifier

- `.appScreenBackground()` — 파도 배경
- `.appNavigationStyle()` — 네비 바 투명 (회색 material 제거)
- `.appCardStyle()` — 글래스 카드
- `.appListStyle()` — List + 파도 노출

### 알려진 패턴

- 푸시된 화면에서 `NavigationLink { Destination }` 클로저 방식 사용
- `navigationDestination`은 `NavigationStack` **루트**에만 등록
- 변수·프로퍼티명 **3자 이상** (`SwiftLint identifier_name`) — 상세: [`docs/README.md`](docs/README.md) 코딩 규칙

---

## 디자인 토큰 (요약)

| 토큰 | 용도 |
|------|------|
| `AppColor.primary` / `waveNear` | #3B9EFF — CTA, Ch 뱃지 |
| `AppColor.waveSkyTop` | 하늘·네비 틴트 |
| `AppColor.waveDeep` | 심해·타이틀 |
| `AppColor.waveFoam` | 글래스 카드 |
| `AppSpacing.menuCardStack` | 16pt — 스택형 메뉴 카드 간격 (Alphabet·챕터 공통) |

상세: [`docs/design.md`](docs/design.md)

---

## 에이전트 요청 예시

| 목적 | 요청 예 |
|------|---------|
| UI 수정 | "`AlphabetView`에 `appCardStyle` 유지하면서 Ch.01 그리드 추가" |
| 네비 버그 | "`NavigationLink { }` 클로저 방식으로 변경, `navigationDestination` 제거" |
| 릴리스 | "`git-Policy.md` 따라 v.0.1.2 Release 문서 + 태그" |
| 학습 | "`SwiftStudy.md`에 LazyVGrid 섹션 추가" |

---

## 현재 버전

| 태그 | 설명 |
|------|------|
| `v.0.0.0` | Git 정책·Release 체계 수립 |
| `v.0.1.4` | 문서 인덱스·원격 태그 정책 |
| `v.0.1.5` | Alphabet·챕터 카드 간격 통일 (`menuCardStack`) |
| `v.0.1.6` | iOS App Icon · web 메타 아이콘 |

최신 릴리스 노트: [`Releases/v.0.1/v.0.1.6.md`](Releases/v.0.1/v.0.1.6.md)

---

*에이전트는 작업 전 이 파일과 `docs/git-Policy.md`를 먼저 확인하세요.*
