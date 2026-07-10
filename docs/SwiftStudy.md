# SwiftStudy — japanese-study 프로젝트 학습 노트

> AI 코딩을 하더라도 **개념을 알면 에이전트와 더 정확하게 소통**할 수 있습니다.  
> 이 문서는 `japanese-study` 앱을 만들며 실제로 쓴 Swift / SwiftUI / UIKit API를 정리한 공부 노트입니다.

---

## 목차

1. [SwiftUI 앱의 기본 골격](#1-swiftui-앱의-기본-골격)
2. [레이아웃 — 화면을 쌓는 방법](#2-레이아웃--화면을-쌓는-방법)
3. [네비게이션 — 화면 이동](#3-네비게이션--화면-이동)
4. [네비게이션 바 스타일 (핵심 이슈)](#4-네비게이션-바-스타일-핵심-이슈)
5. [탭 바 스타일](#5-탭-바-스타일)
6. [ViewModifier — 재사용 스타일](#6-viewmodifier--재사용-스타일)
7. [Shape & Path — 파도 그리기](#7-shape--path--파도-그리기)
8. [애니메이션 — TimelineView](#8-애니메이션--timelineview)
9. [색상 시스템](#9-색상-시스템)
10. [List vs ScrollView](#10-list-vs-scrollview)
11. [Modifier 적용 순서](#11-modifier-적용-순서)
12. [에이전트와 소통할 때 쓰는 표현](#12-에이전트와-소통할-때-쓰는-표현)
13. [식별자 네이밍 & SwiftLint](#13-식별자-네이밍--swiftlint)

---

## 1. SwiftUI 앱의 기본 골격

### `@main` + `App` 프로토콜

앱의 진입점입니다. `JapaneseStudyApp.swift`에서 앱 전체 초기 설정을 합니다.

```swift
@main
struct JapaneseStudyApp: App {
    init() {
        // 앱 시작 시 1회 실행 — 전역 UI 설정에 적합
        AppNavigationAppearance.configure()
        configureTabBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()   // 첫 화면
        }
    }
}
```

| 개념 | 설명 |
|------|------|
| `@main` | 프로그램 시작점 표시 (예전 `main.swift` 대체) |
| `App` | 앱의 Scene(창) 구조 정의 |
| `WindowGroup` | iOS에서 하나의 윈도우(화면) 제공 |
| `init()` | View 생성 전 전역 설정 — `UINavigationBar.appearance()` 등 |

**프로젝트 파일:** `JapaneseStudyApp.swift`

---

### `View` 프로토콜 + `body`

모든 UI는 `View`입니다. `body`가 실제로 그려지는 내용입니다.

```swift
struct ContentView: View {
    var body: some View {
        TabView { ... }
    }
}
```

| 키워드 | 의미 |
|--------|------|
| `some View` | 어떤 View든 반환하지만, 타입은 컴파일러가 추론 |
| `#Preview` | Xcode Canvas 미리보기 (구 `PreviewProvider`) |

---

## 2. 레이아웃 — 화면을 쌓는 방법

### `ZStack` — 겹쳐 쌓기

뒤에 배경, 앞에 콘텐츠를 올릴 때 사용합니다.

```swift
// ContentView.swift
ZStack {
    WaveBackgroundView()          // 맨 뒤: 파도 배경
    TabView { AlphabetView() }    // 맨 앞: 탭 콘텐츠
}
```

**언제 쓰나:** 배경 이미지/그라데이션 위에 UI를 올릴 때.

---

### `VStack` / `HStack` — 세로·가로 배치

```swift
// AlphabetView.swift
VStack(alignment: .leading, spacing: AppSpacing.l) {
    AlphabetIntroHeader()
    VStack(spacing: AppSpacing.m) { ... }
    Text("일본어 문자는...")
}
```

| 파라미터 | 역할 |
|----------|------|
| `alignment` | 교차축 정렬 (`.leading`, `.center`) |
| `spacing` | 자식 View 사이 간격 |

---

### `ScrollView` — 스크롤 가능한 영역

콘텐츠가 화면보다 길 때 사용합니다.

```swift
ScrollView {
    VStack { ... }
    .padding(.horizontal, AppSpacing.screenHorizontal)
}
```

---

### `GeometryReader` — 부모가 준 크기 읽기

화면 크기에 맞춰 파도 높이·너비를 계산할 때 사용합니다.

```swift
// WaveBackgroundView.swift
GeometryReader { geometry in
    let height = geometry.size.height
    let width = geometry.size.width
    // height * 0.018 같은 비율 계산
}
```

> ⚠️ `GeometryReader`는 가능한 한 필요한 부분에만 씁니다. 최상위에 두면 레이아웃이 불안정해질 수 있습니다.

---

### `Spacer` — 남는 공간 채우기

```swift
HStack {
    AlphabetMenuRow(...)
    Spacer(minLength: AppSpacing.s)   // 오른쪽으로 밀기
    Image(systemName: "chevron.right")
}
```

---

### `.ignoresSafeArea()`

노치·홈 인디케이터 영역까지 배경을 확장합니다.

```swift
WaveBackgroundView()
    .ignoresSafeArea()
```

---

## 3. 네비게이션 — 화면 이동

### `NavigationStack`

iOS 16+ 화면 스택 네비게이션 컨테이너입니다. (구 `NavigationView` 대체)

```swift
NavigationStack {
    ScrollView { ... }
    .navigationTitle("Alphabet")
    .navigationBarTitleDisplayMode(.large)
}
```

| API | 역할 |
|-----|------|
| `.navigationTitle("문자")` | 상단 제목 |
| `.navigationBarTitleDisplayMode(.large)` | 큰 제목 (스크롤 시 작아짐) |
| `.navigationBarTitleDisplayMode(.inline)` | 항상 작은 제목 (Ch.01 등) |

---

### `NavigationLink` — 화면 push

#### ✅ 방식 A: destination 클로저 (프로젝트에서 사용)

```swift
// HiraganaHomeView.swift
NavigationLink {
    HiraganaChapter01View()    // 이동할 화면
} label: {
    ChapterRow(chapter: chapter)   // 보이는 행
}
```

#### ⚠️ 방식 B: value + navigationDestination

```swift
NavigationLink(value: chapter) { ... }
.navigationDestination(for: AlphabetChapter.self) { chapter in ... }
```

> **프로젝트에서 겪은 버그:** `navigationDestination`을 **푸시된 화면**에 붙이면 destination을 찾지 못해 빈 화면·느낌표가 뜹니다.  
> `navigationDestination`은 **`NavigationStack` 루트**에 등록하거나, **방식 A**를 씁니다.

---

### `@ViewBuilder`

조건에 따라 다른 View를 반환할 때 사용합니다.

```swift
@ViewBuilder
private func chapterDestination(for chapter: AlphabetChapter) -> some View {
    switch chapter.id {
    case "hiragana-ch01": HiraganaChapter01View()
    case "hiragana-ch02": HiraganaChapter02View()
    default: ContentUnavailableView(...)
    }
}
```

---

### `TabView` — 하단 탭

```swift
TabView {
    AlphabetView()
        .tabItem {
            Label("Alphabet", systemImage: "character.ja")
        }
}
.tint(AppColor.primary)   // 선택된 탭 색상
```

---

## 4. 네비게이션 바 스타일 (핵심 이슈)

### 문제: body는 파도색인데 상단만 회색

**원인:** `.toolbarBackground(.ultraThinMaterial)` → iOS 기본 **회색 블러** material.

### 해결: SwiftUI + UIKit 이중 적용

#### SwiftUI 측 — `appNavigationStyle()`

```swift
// AppNavigationStyle.swift
func appNavigationStyle() -> some View {
    self
        .toolbarBackground(.hidden, for: .navigationBar)  // 회색 material 제거
        .toolbarColorScheme(.light, for: .navigationBar)
}
```

| API | 역할 |
|-----|------|
| `.toolbarBackground(.hidden, for: .navigationBar)` | 네비 바 배경 숨김 → 뒤 파도 배경 노출 |
| `.toolbarBackground(.ultraThinMaterial, ...)` | ❌ 회색 블러 — 파도 무드와 안 맞음 |
| `.toolbarColorScheme(.light, ...)` | 밝은 배경용 어두운 아이콘/텍스트 |

#### UIKit 측 — `UINavigationBarAppearance`

SwiftUI만으로는 large title 색·스크롤 시 배경 등 세밀 제어가 부족할 때 UIKit 전역 설정을 씁니다.

```swift
// AppNavigationStyle.swift
let appearance = UINavigationBarAppearance()
appearance.configureWithTransparentBackground()
appearance.backgroundEffect = nil                    // 블러 제거
appearance.backgroundColor = .clear                  // 또는 waveSkyTop 틴트
appearance.titleTextAttributes = [.foregroundColor: UIColor(AppColor.waveDeep)]
appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(AppColor.waveDeep)]

UINavigationBar.appearance().scrollEdgeAppearance = appearance  // large title 상태
UINavigationBar.appearance().standardAppearance = appearance  // 스크롤 후 compact
```

| Appearance 종류 | 언제 적용되나 |
|-----------------|---------------|
| `scrollEdgeAppearance` | 콘텐츠가 맨 위 (large title 보일 때) |
| `standardAppearance` | 스크롤해서 title이 작아진 후 |
| `compactAppearance` | iPhone 가로 등 compact 환경 |

**프로젝트 파일:** `Theme/Modifiers/AppNavigationStyle.swift`

---

## 5. 탭 바 스타일

네비게이션 바와 같은 패턴입니다.

```swift
// japanese_studyApp.swift
let tabBarAppearance = UITabBarAppearance()
tabBarAppearance.configureWithTransparentBackground()
tabBarAppearance.backgroundEffect = nil
tabBarAppearance.backgroundColor = UIColor(AppColor.waveSkyTop.opacity(0.82))

let itemAppearance = UITabBarItemAppearance()
itemAppearance.normal.iconColor = UIColor(AppColor.textSecondary)
itemAppearance.selected.iconColor = UIColor(AppColor.waveNear)

UITabBar.appearance().standardAppearance = tabBarAppearance
UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
```

| API | 역할 |
|-----|------|
| `UITabBarAppearance` | 탭 바 전체 스타일 |
| `UITabBarItemAppearance` | 개별 탭 아이콘·텍스트 색 |
| `stackedLayoutAppearance` | 기본 하단 탭 레이아웃 |
| `.appearance()` | 앱 전체에 일괄 적용 |

---

## 6. ViewModifier — 재사용 스타일

같은 스타일을 여러 View에 붙일 때 `ViewModifier` + `extension View` 패턴을 씁니다.

### 구조

```swift
// 1) Modifier 정의
struct AppScreenBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            WaveBackgroundView()
            content
        }
    }
}

// 2) View extension으로 짧은 이름 제공
extension View {
    func appScreenBackground() -> some View {
        modifier(AppScreenBackgroundModifier())
    }
}

// 3) 사용
NavigationStack { ... }
    .appScreenBackground()
    .appNavigationStyle()
```

### 프로젝트 Modifier 목록

| Modifier | 파일 | 역할 |
|----------|------|------|
| `.appScreenBackground()` | `AppScreenStyle.swift` | 파도 배경 + 콘텐츠 ZStack |
| `.appCardStyle()` | `AppScreenStyle.swift` | 흰 카드 + 그림자 |
| `.appGlassRowBackground()` | `AppScreenStyle.swift` | List 행 글래스 배경 |
| `.appListStyle()` | `AppScreenStyle.swift` | insetGrouped + 배경 숨김 |
| `.appNavigationStyle()` | `AppNavigationStyle.swift` | 네비 바 투명 처리 |

---

## 7. Shape & Path — 파도 그리기

### `Shape` 프로토콜

커스텀 도형을 그릴 때 `path(in:)`을 구현합니다.

```swift
// WaveShape.swift
struct WaveShape: Shape {
    var phase: CGFloat       // 위상 — 애니메이션 대상
    var amplitude: CGFloat   // 파도 높이
    var baseline: CGFloat    // 기준선 (0~1)
    var frequency: CGFloat   // 파도 개수

    func path(in rect: CGRect) -> Path {
        var path = Path()
        // sin 곡선으로 x마다 y 계산 → 선 연결 → 하단 닫기
        return path
    }
}
```

사용:

```swift
WaveShape(phase: 0.3, amplitude: 20, baseline: 0.66, frequency: 1.5)
    .fill(AppColor.waveMid.opacity(0.55))
```

### `animatableData` — Shape 애니메이션

```swift
var animatableData: CGFloat {
    get { phase }
    set { phase = newValue }
}
```

SwiftUI가 `phase` 변화를 프레임마다 보간(interpolate)해 부드러운 파도 움직임을 만듭니다.

---

## 8. 애니메이션 — TimelineView

시간에 따라 View를 다시 그릴 때 사용합니다.

```swift
// WaveBackgroundView.swift
TimelineView(.animation(minimumInterval: 1 / 30)) { timeline in
    let phase = timeline.date
        .timeIntervalSinceReferenceDate
        .truncatingRemainder(dividingBy: 10) / 10   // 0~1, 10초 주기

    WaveShape(phase: CGFloat(phase) * 0.3, ...)
}
```

| 개념 | 설명 |
|------|------|
| `TimelineView` | 일정 간격으로 body 재호출 |
| `.animation(minimumInterval:)` | 최소 갱신 주기 (여기선 30fps) |
| `timeline.date` | 현재 시각 — 위상 계산에 사용 |

> 파도 애니메이션은 `withAnimation`이 아니라 **시간 기반 redraw** 방식입니다.

---

## 9. 색상 시스템

### 3가지 색 정의 방식 (프로젝트에서 모두 사용)

#### 1) Assets Color Set

```swift
Color("Primary")   // Assets.xcassets/Primary.colorset
```

다크 모드 대응·디자이너 협업에 유리.

#### 2) 코드 내 RGB

```swift
// AppColor.swift
static let waveSkyTop = Color(red: 0.93, green: 0.97, blue: 1.00)
```

파도 전용 팔레트처럼 SwiftUI 전용 색에 사용.

#### 3) `AppColor` enum — 토큰 중앙 관리

```swift
enum AppColor {
    static let primary = Color("Primary")
    static let waveDeep = Color(red: 0.12, green: 0.42, blue: 0.78)
}
```

View에서 `.pink`, `.blue` 대신 `AppColor.waveNear` 사용 → 디자인 일관성.

### 자주 쓰는 Color API

| API | 예시 | 역할 |
|-----|------|------|
| `.opacity(0.88)` | `waveFoam.opacity(0.88)` | 투명도 |
| `.foregroundStyle()` | `.foregroundStyle(AppColor.textPrimary)` | 텍스트·아이콘 색 (iOS 17+) |
| `.foregroundColor()` | 구 API — `foregroundStyle` 권장 |
| `.tint()` | `.tint(AppColor.primary)` | 링크·버튼·탭 액센트 |
| `.fill()` | `RoundedRectangle().fill(color)` | 도형 채우기 |
| `.stroke()` | `.stroke(color, lineWidth: 1)` | 테두리 |
| `LinearGradient` | `colors: [top, bottom]` | 그라데이션 배경 |

### SwiftUI `Color` → UIKit `UIColor` 변환

UIKit Appearance 설정 시 필요합니다.

```swift
UIColor(AppColor.waveSkyTop.opacity(0.82))
```

---

## 10. List vs ScrollView

| | `List` | `ScrollView` |
|---|--------|--------------|
| 용도 | 설정·목록 (기본 행 스타일) | 자유 레이아웃 |
| 배경 | 시스템 grouped 배경 (회색/흰 블록) | 없음 (투명) |
| 파도 배경 | `.scrollContentBackground(.hidden)` 필요 | 자연스럽게 비침 |
| 프로젝트 사용 | `HiraganaHomeView` 챕터 목록 | `AlphabetView` 메뉴 카드 |

### List에서 파도 보이게 하기

```swift
List { ... }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)   // List 기본 배경 제거
    .appScreenBackground()              // 파도 배경 깔기
```

### List 행 배경 커스텀

```swift
.listRowBackground(AppGlassRowBackground())
// 또는
.appGlassRowBackground()
```

---

## 11. Modifier 적용 순서

Modifier는 **순서가 결과를 바꿉니다.** 바깥쪽 modifier가 나중에 적용됩니다.

```swift
// AlphabetView.swift — 권장 순서
NavigationStack {
    ScrollView { ... }
    .navigationTitle("Alphabet")
}
.appScreenBackground()      // 1) 파도 배경 ZStack
.appNavigationStyle()       // 2) 네비 바 투명
.tint(AppColor.primary)     // 3) 링크·버튼 색
```

| 순서가 중요한 이유 |
|-------------------|
| `appScreenBackground`가 `NavigationStack` **바깥**에 있어야 네비 영역까지 파도가 깔림 |
| `toolbarBackground(.hidden)`은 네비 바만 투명하게 — 뒤에 파도가 있어야 의미 있음 |

---

## 12. 에이전트와 소통할 때 쓰는 표현

개념을 알면 아래처럼 **구체적으로** 요청할 수 있습니다.

### 네비게이션 바

| ❌ 모호한 요청 | ✅ 구체적인 요청 |
|---------------|-----------------|
| "상단 디자인 맞춰줘" | "`toolbarBackground(.ultraThinMaterial)` 제거하고 `.hidden`으로 파도 배경이 비치게 해줘" |
| "회색 없애줘" | "`UINavigationBarAppearance`에서 `backgroundEffect = nil` 설정해줘" |
| "제목 색 바꿔줘" | "`largeTitleTextAttributes`에 `waveDeep` 적용해줘" |

### 배경 / 파도

| ❌ | ✅ |
|----|-----|
| "배경 예쁘게" | "`WaveBackgroundView`를 `ZStack` 맨 뒤에 두고 `ignoresSafeArea` 적용" |
| "카드 느낌" | "`ViewModifier`로 `appCardStyle()` 만들어서 `waveFoam` + shadow 적용" |

### 네비게이션 버그

| ❌ | ✅ |
|----|-----|
| "Ch1 안 들어가져" | "`NavigationLink(value:)` + 푸시된 화면의 `navigationDestination` 조합이 문제. `NavigationLink { Destination }` 클로저 방식으로 바꿔줘" |

### 파일 / 구조

| ❌ | ✅ |
|----|-----|
| "색 정리해줘" | "`AppColor` enum에 토큰 추가하고 `Assets.xcassets` Color Set 생성" |
| "스타일 재사용" | "`ViewModifier` + `extension View`로 `.appXxx()` modifier 만들어줘" |

---

## 13. 식별자 네이밍 & SwiftLint

### Swift 언어 규칙이 아님

`Variable name 'y' should be between 3 and 40 characters long` 메시지는 **Swift 컴파일러 규칙이 아니라** [SwiftLint](https://github.com/realm/SwiftLint)의 **`identifier_name`** 규칙입니다.

| 구분 | 설명 |
|------|------|
| **Swift 언어** | `x`, `y`, `i` 같은 1~2자 이름도 문법상 허용 |
| **SwiftLint (이 프로젝트)** | 루트 `.swiftlint.yml`에서 최소 길이를 검사 |
| **적용 범위** | `japanese-study/japanese-study/` 소스 |

### 프로젝트 설정 (`.swiftlint.yml`)

```yaml
identifier_name:
  min_length:
    warning: 3    # 3자 미만 → warning
    error: 2      # 2자 미만 → error
  allowed_symbols: ["_"]
  excluded:
    - id          # Identifiable 프로토콜 요구 이름
```

| 길이 | 예시 | 결과 |
|------|------|------|
| 1자 | `x`, `y` | **error** |
| 2자 | `id` (제외 목록 외) | warning |
| 3자 이상 | `relativeX`, `kana` | 통과 |

### 프로젝트 네이밍 규칙 (확정)

- **변수·상수·프로퍼티 이름은 3자 이상**을 기본으로 한다.
- 의미가 드러나게 짓는다. (예: `x` → `relativeX`, `y` → `relativeY`)
- **예외**: Swift/SwiftUI 프로토콜이 요구하는 이름 (`Identifiable.id` 등) — `.swiftlint.yml` `excluded`에 등록.

### 실제 사례 — 획순 마커 좌표

```swift
// ❌ SwiftLint 위반
struct HiraganaStrokeMarker {
    let x: Double
    let y: Double
}

// ✅ 프로젝트 규칙 준수
struct HiraganaStrokeMarker {
    let number: Int
    let relativeX: Double   // 글자 영역 기준 0~1 가로 위치
    let relativeY: Double   // 글자 영역 기준 0~1 세로 위치
}
```

> `.position(x:y:)`처럼 **API 파라미터 라벨**의 `x`, `y`는 변수 선언이 아니므로 `identifier_name` 대상이 아닙니다.

### 에이전트 요청 예시

| ❌ | ✅ |
|----|-----|
| "`x`, `y` 좌표 추가" | "`relativeX`, `relativeY` 상대 좌표(0~1)로 `HiraganaStrokeMarker` 정의" |
| "짧은 변수명 OK" | "SwiftLint `identifier_name` — 변수명 3자 이상, `docs/README.md` 코딩 규칙 참고" |

---

## 부록 — 프로젝트 파일 맵

| 주제 | 파일 |
|------|------|
| 앱 진입·전역 설정 | `JapaneseStudyApp.swift` |
| 탭 + 루트 배경 | `ContentView.swift` |
| Alphabet 화면 | `Views/Alphabet/AlphabetView.swift` |
| 네비게이션 바 | `Theme/Modifiers/AppNavigationStyle.swift` |
| 화면·카드 스타일 | `Theme/Modifiers/AppScreenStyle.swift` |
| 파도 배경 | `Theme/Components/WaveBackgroundView.swift` |
| 파도 곡선 | `Theme/Components/WaveShape.swift` |
| 색상 토큰 | `Theme/AppColor.swift` |
| 네비게이션 버그 사례 | `Views/Alphabet/Hiragana/HiraganaHomeView.swift` |

---

## 다음에 공부하면 좋은 주제

- [ ] `@State`, `@Binding`, `@Observable` — 상태 관리
- [ ] `LazyVGrid` — Ch.01 50음도 그리드
- [ ] `AVSpeechSynthesizer` — 히라가나 발음 TTS
- [ ] Dark Mode Color Set variants
- [ ] `NavigationPath` — 타입 안전 딥링크 네비게이션

---

*마지막 업데이트: 2026-07-10 — SwiftLint 식별자 네이밍 규칙 추가*
