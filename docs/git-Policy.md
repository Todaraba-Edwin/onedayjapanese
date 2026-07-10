# Git Policy — japanese-study

이 문서는 `japanese-study` 저장소의 브랜치, 커밋, 태그, Release 문서 관리 정책을 정의합니다.

---

## 목차

1. [저장소 구조](#1-저장소-구조)
2. [브랜치 정책](#2-브랜치-정책)
3. [Task 워크플로](#3-task-워크플로)
4. [버전 번호 규칙 (SemVer)](#4-버전-번호-규칙-semver)
5. [Release 문서 정책](#5-release-문서-정책)
6. [커밋 규칙](#6-커밋-규칙)
7. [태그 & Push 절차](#7-태그--push-절차)
8. [에이전트 협업 시 참고](#8-에이전트-협업-시-참고)

---

## 1. 저장소 구조

```
japanese-study/              # Git 루트
├── agent.md                 # AI 에이전트 소통 가이드 (루트)
├── docs/                    # 기획·디자인·학습·정책 문서
│   ├── README.md
│   ├── app-desc.md
│   ├── design.md
│   ├── SwiftStudy.md
│   └── git-Policy.md        # 이 문서
├── Releases/                # 버전별 릴리스 노트
│   ├── v.0.0/
│   │   └── v.0.0.0.md
│   └── v.0.1/
│       ├── v.0.1.1.md
│       ├── v.0.1.2.md
│       ├── v.0.1.3.md
│       └── v.0.1.4.md
├── japanese-study/          # Xcode 프로젝트
├── reperence/               # UI 레퍼런스 이미지
└── buildServer.json
```

---

## 2. 브랜치 정책

### 브랜치 구조

```
main                    ← 최종 안정·배포 기준 (dev-desk 빌드 검증 후 반영)
├── dev-desk            ← macOS — task/* 생성 · --no-ff 병합 · 태그 · 빌드 검증
├── dev-ios             ← iPhone(iOS) — main 동기화 대상
└── task/*              ← Task 작업 브랜치 (완료 후 dev-desk 에 --no-ff 병합)
```

| 브랜치 | 작업 환경 | 용도 |
|--------|-----------|------|
| `main` | — | 최종 안정·배포 기준. `dev-desk`에서 빌드 검증 후 반영 |
| `dev-desk` | **macOS** | Mac에서 `task/*` 생성 · Task 완료 후 `--no-ff` 병합 · 태그 |
| `dev-ios` | **iPhone (iOS)** | iOS 작업용 통합 브랜치. `main` 반영 후 동기화 |
| `task/*` | macOS / iOS | **새 Task** 단위 작업 브랜치 (작업 환경의 `dev-*`에서 생성) |
| `fix/*` | — | 긴급 버그 수정 (필요 시 `task/` 대신 사용) |

### 연속 작업 vs 새 Task

| 구분 | 언제 | 브랜치 |
|------|------|--------|
| **새 Task** | 독립된 목표·릴리스 단위로 **새로 시작**할 때 | `dev-desk`에서 `task/{주제}` 생성 → 완료 후 §3 5단계 수행 |
| **연속 작업** | 같은 Task·같은 버전 범위를 **이어갈** 때 | 기존 `task/*` 브랜치에서 계속 |

> **macOS `dev-desk`에서 `task/*`를 분기**하고, 완료 후 **`dev-desk` → 빌드 검증 → `main` → `dev-desk`·`dev-ios` 동기화** 순으로 진행한다.

### 규칙

- **macOS 새 Task** → `dev-desk`에서 `task/{주제}` 생성 → 작업·릴리스 커밋 → `dev-desk`에 `--no-ff` 병합 · 태그
- **iOS 작업** → `dev-ios`에서 `task/{주제}` 생성 가능. macOS Task 완료 후에는 **`main` 기준으로 `dev-ios` 동기화**
- 버전 태그 (`v.x.y.z`)는 **`dev-desk`의 `--no-ff` 병합 커밋** HEAD에 생성
- 태그된 커밋은 **force push 금지**
- `main`은 `dev-desk`에서 **빌드 검증 후**에만 갱신
- `main` 반영 후 **`dev-desk` · `dev-ios`를 `main`과 동기화**한다

### Task 브랜치 명명

```
task/{짧은-주제}
```

| 예 | 의미 |
|----|------|
| `task/hiragana-ch01-grid` | 히라가나 Ch.01 50음도 그리드 |
| `task/app-icon` | 앱 아이콘 반영 |
| `task/git-policy-task-workflow` | Git 정책·Task 워크플로 문서 |

- 소문자, 단어는 **하이픈(`-`)** 구분
- **태그 버전**은 Release 문서·SemVer 규칙(§4)을 따른다

---

## 3. Task 워크플로

**새 Task**를 시작할 때 아래 **5단계**를 따른다. **연속 작업**은 `task/*` 브랜치에서 이어가고, Task 완료 시점에만 2~5단계를 수행한다.

### 절차 요약 (macOS / dev-desk 기준)

```
1. dev-desk 에서 task/{주제} 생성 → 작업 · Release 문서 · 커밋 · 태그 준비
2. dev-desk 에 --no-ff 병합 → 병합 커밋 HEAD 에 annotated tag 생성
3. 빌드 검증 — 문제 없으면 main 에 --no-ff 병합
4. main 결과물을 dev-desk · dev-ios 에 동기화 (--no-ff)
5. main · dev-desk · dev-ios · 태그 를 origin 에 push
```

| 단계 | 브랜치 | 핵심 |
|------|--------|------|
| 1 | `task/*` | 구현 + Release 문서 + 커밋 |
| 2 | `dev-desk` | `--no-ff` 병합 + `v.x.y.z` 태그 |
| 3 | `dev-desk` → `main` | 빌드 통과 후 `main` 병합 |
| 4 | `main` → `dev-desk` · `dev-ios` | 통합 브랜치 동기화 |
| 5 | `origin` | 세 브랜치 + 태그 push |

> iOS 전용 Task는 `dev-ios`에서 `task/*`를 생성할 수 있으나, **릴리스·태그·main 반영 흐름은 macOS `dev-desk` 기준**으로 통일한다. iOS 쪽은 4단계에서 `main`을 `dev-ios`에 병합해 맞춘다.

### 1) Task 브랜치 생성 · 작업 · 릴리스 커밋

**macOS에서 작업할 때:**

```bash
git checkout dev-desk
git pull origin dev-desk
git checkout -b task/hiragana-ch01-grid
```

- 기능·문서 작업을 `task/*` 브랜치에서 진행
- Task 완료 시 §4 SemVer에 맞는 버전 번호를 정하고, §5 규칙에 따라 Release 문서 작성  
  예: `Releases/v.0.1/v.0.1.8.md`
- `docs/README.md` 등 연관 문서 갱신 (§5 참고)
- Release 문서 **브랜치** 항목에는 `dev-desk` 기록
- **한 커밋(또는 논리 단위 커밋)으로 작업·릴리스 문서를 함께 커밋**

```bash
git add .
git commit -m "feat: 히라가나 Ch.01 50음도 그리드 (v.0.1.8)"
```

> 1단계에서는 `task/*` HEAD에 **태그를 붙이지 않는다.** 태그는 2단계 `dev-desk` 병합 커밋 HEAD에 생성한다.

**iPhone(iOS)에서 Task를 시작할 때** (선택):

```bash
git checkout dev-ios
git pull origin dev-ios
git checkout -b task/hiragana-ch01-grid
```

### 2) `dev-desk`에 `--no-ff` 병합 · 태그 생성

```bash
git checkout dev-desk
git pull origin dev-desk
git merge --no-ff task/hiragana-ch01-grid -m "merge: task/hiragana-ch01-grid — 히라가나 Ch.01 50음도 그리드"
git tag -a v.0.1.8 -m "v.0.1.8 — 히라가나 Ch.01 50음도 그리드"
```

- **`--no-ff` 필수** — Task 단위 병합 이력을 남긴다
- 충돌 해결 후 병합 커밋 완료
- 태그는 **`dev-desk`의 병합 완료 커밋 HEAD**에 붙인다 (`task/*` HEAD에 직접 태그하지 않음)
- 태그 형식: **`v.MAJOR.MINOR.PATCH`** (§4)

```bash
# (선택) Task 브랜치 삭제
git branch -d task/hiragana-ch01-grid
```

### 3) 빌드 검증 → `main` 병합

`dev-desk`에서 빌드·기본 동작을 확인한 뒤, **문제가 없을 때만** `main`에 반영한다.

```bash
# 빌드 검증 (macOS / Xcode)
xcodebuild -project japanese-study/japanese-study.xcodeproj \
  -scheme japanese-study \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  build
```

빌드·검증 통과 후:

```bash
git checkout main
git pull origin main
git merge --no-ff dev-desk -m "merge: dev-desk — v.0.1.8 히라가나 Ch.01 50음도 그리드"
```

- 빌드 실패·런타임 이상 시 **`main` 병합을 보류**하고 `dev-desk` / `task/*`에서 수정 후 2단계부터 재진행
- `main` 병합에도 **`--no-ff`** 를 사용한다

### 4) `main` 결과물로 `dev-desk` · `dev-ios` 동기화

`main` 반영 후 통합 브랜치를 `main`과 맞춘다.

```bash
git checkout dev-desk
git merge --no-ff main -m "merge: main — v.0.1.8 동기화"

git checkout dev-ios
git pull origin dev-ios
git merge --no-ff main -m "merge: main — v.0.1.8 동기화"
```

- `dev-desk` · `dev-ios` 모두 **`main` 기준으로 `--no-ff` 병합**하여 동일한 결과물을 유지
- 동기화 후 `git diff main dev-desk`, `git diff main dev-ios`로 차이가 없는지 확인

### 5) `origin`에 push

```bash
git push origin dev-desk
git push origin main
git push origin dev-ios
git push origin v.0.1.8
```

- **`main` · `dev-desk` · `dev-ios` · 태그**를 모두 `origin`에 반영한다
- 로컬에만 태그·브랜치를 두지 않는다
- 원격에 올렸던 `task/*` 브랜치는 정리: `git push origin --delete task/{주제}`

---

## 4. 버전 번호 규칙 (SemVer)

형식: **`v.MAJOR.MINOR.PATCH`** (태그 접두사 `v` 포함)

| 자리 | 의미 | 예 |
|------|------|-----|
| MAJOR | 호환 깨지는 대규모 변경 | v.2.0.0 |
| MINOR | 기능 단위 마일스톤 (폴더 단위) | v.0.1.x |
| PATCH | 버그 수정·소규모 개선 | v.0.1.1 |

### 마이너(0.x) 단위 — Release 폴더와 대응

| 폴더 | 포함 태그 | 의미 |
|------|-----------|------|
| `Releases/v.0.0/` | v.0.0.0 ~ v.0.0.x | 저장소·정책·인프라 초기화 |
| `Releases/v.0.1/` | v.0.1.1 ~ v.0.1.x | Alphabet 탭 · 히라가나 기초 |
| `Releases/v.0.2/` | v.0.2.1 ~ v.0.2.x | (예정) Ch.01 50음도 · 연습 |

> **PATCH는 1부터 시작** (v.0.1.1, v.0.2.1 …). `.0` 패치는 사용하지 않습니다.

---

## 5. Release 문서 정책

### 경로 규칙

```
Releases/v.{MAJOR}.{MINOR}/v.{MAJOR}.{MINOR}.{PATCH}.md
```

예:
- `Releases/v.0.0/v.0.0.0.md`
- `Releases/v.0.1/v.0.1.1.md`

### Release 문서 필수 항목

1. **버전** / **날짜** / **태그**
2. **요약** (한 줄)
3. **Added** — 새 기능
4. **Changed** — 변경
5. **Fixed** — 버그 수정
6. **Docs** — 문서 변경
7. **관련 파일** — 주요 경로

### 작성 시점

- Task **완료 시** Release 문서를 먼저 작성·커밋 (`task/*` 또는 연속 작업 브랜치)
- 버전·폴더는 §4 SemVer에 맞춘다 (`Releases/v.0.0/v.0.0.0.md`, `Releases/v.0.1/v.0.1.1.md` …)
- 태그는 Release 문서가 포함된 **`dev-desk` `--no-ff` 병합 커밋**에 붙임 (§3)

### `docs/README.md` 갱신 (필수)

새 버전 태그를 올릴 때마다 `docs/README.md`도 **같은 커밋**에 반영한다. Release 노트만 추가하고 문서 인덱스를 방치하지 않는다.

| 갱신 대상 | 내용 |
|-----------|------|
| **Release 노트** 표 | 새 버전 행 추가 — `Releases/v.{MAJOR}.{MINOR}/v.{MAJOR}.{MINOR}.{PATCH}.md` 링크 |
| **현재 구현 상태** 절 | 제목의 버전·날짜를 최신 태그로 교체 |
| **현재 구현 상태** 본문 | 해당 릴리스의 Added·Changed·Fixed 요약을 반영 (앱 기능·브랜드·문서 변경 포함) |

작성 순서 권장:

1. `Releases/.../v.x.y.z.md` 작성
2. `docs/README.md` — Release 표 + 현재 구현 상태 갱신
3. (필요 시) `docs/app-desc.md` 등 연관 문서
4. 한 커밋으로 스테이징 후 태그

---

## 6. 커밋 규칙

### 메시지 형식

```
<type>: <한 줄 요약>

[선택] 본문 — 왜 변경했는지
```

| type | 용도 |
|------|------|
| `feat` | 새 기능 |
| `fix` | 버그 수정 |
| `docs` | 문서만 |
| `style` | UI·디자인 (로직 변경 없음) |
| `refactor` | 리팩터링 |
| `chore` | 빌드·설정 |
| `merge` | `dev-desk` / `dev-ios` 병합 커밋 (Task 완료 시) |

### 언어

- 커밋 메시지 **요약·본문은 한글**로 작성한다.
- `type` 접두사(`feat`, `fix`, `docs` 등)만 영문 소문자를 유지한다.

### 예시

```
feat: Alphabet 탭 및 히라가나 Ch.01·02 골격 추가

docs: v.0.1.1 릴리스 노트 및 git 정책 수립

merge: task/hiragana-ch01-grid — 히라가나 Ch.01 50음도 그리드
```

---

## 7. 태그 & Push 절차

### 원격 저장소 (`origin`)

| 항목 | 값 |
|------|-----|
| 호스트 | GitHub |
| URL | `https://github.com/Todaraba-Edwin/onedayjapanese.git` |
| macOS 통합 브랜치 | `dev-desk` |
| iOS 통합 브랜치 | `dev-ios` |
| 배포 기준 브랜치 | `main` |

최초 연결 (원격이 없을 때):

```bash
git remote add origin https://github.com/Todaraba-Edwin/onedayjapanese.git
```

### 릴리스 절차 (Task → dev-desk → main → 동기화 → push)

§3 Task 워크플로 전체 요약:

```bash
# 1) task/* — 작업 · Release 문서 · 커밋
git checkout dev-desk && git pull origin dev-desk
git checkout -b task/{주제}
# ... 작업 · Releases/v.0.1/v.0.1.{N}.md · docs/README.md ...
git commit -m "feat: {요약} (v.0.1.{N})"

# 2) dev-desk — --no-ff 병합 · 태그
git checkout dev-desk
git merge --no-ff task/{주제} -m "merge: task/{주제} — {한 줄 요약}"
git tag -a v.0.1.{N} -m "v.0.1.{N} — {한 줄 요약}"

# 3) 빌드 검증 후 main 병합
xcodebuild -project japanese-study/japanese-study.xcodeproj \
  -scheme japanese-study \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  build
git checkout main && git pull origin main
git merge --no-ff dev-desk -m "merge: dev-desk — v.0.1.{N} {한 줄 요약}"

# 4) dev-desk · dev-ios 동기화
git checkout dev-desk
git merge --no-ff main -m "merge: main — v.0.1.{N} 동기화"
git checkout dev-ios && git pull origin dev-ios
git merge --no-ff main -m "merge: main — v.0.1.{N} 동기화"

# 5) origin push
git push origin dev-desk main dev-ios v.0.1.{N}
```

### 원격 push 규칙

- **릴리스 완료 시** `main` · `dev-desk` · `dev-ios` · **태그**를 모두 `origin`에 push
- **태그**: `dev-desk` 병합 직후 생성하고, 5단계에서 `origin`에 반영
- **전체 태그 동기화**: `git push origin --tags`
- **단일 태그만 올릴 때**: `git push origin v.0.1.8`
- **동기화 확인**: `git diff main dev-desk`, `git diff main dev-ios`, `git ls-remote --tags origin`

> HTTP push 시 `RPC failed; HTTP 400`이 나면 `git config http.postBuffer 524288000` 후 재시도한다.

### 태그 종류

| 종류 | 명령 | 용도 |
|------|------|------|
| Annotated | `git tag -a v.x.y.z -m "..."` | **권장** — 메시지·날짜 포함 |
| Lightweight | `git tag v.x.y.z` | 간단 참조용 |

---

## 8. 에이전트 협업 시 참고

에이전트에게 **새 Task** 작업을 요청할 때 — **작업 환경(macOS / iOS)** 을 명시한다.

**macOS 새 Task 요청 예시:**

```
docs/git-Policy.md §3 Task 워크플로에 따라 (macOS / dev-desk):
1. dev-desk 기준 task/{주제} 브랜치 생성
2. 작업 후 Releases/v.0.1/v.0.1.{N}.md 작성 · docs/README.md 갱신 · task/* 커밋
3. dev-desk 에 --no-ff merge + annotated tag v.0.1.{N}
4. xcodebuild 빌드 검증 후 main 에 --no-ff merge
5. main 을 dev-desk · dev-ios 에 --no-ff 동기화
6. git push origin dev-desk main dev-ios v.0.1.{N}
```

**iPhone iOS 작업 시:**

```
docs/git-Policy.md §3에 따라:
- iOS 전용 작업은 dev-ios 에서 task/* 생성 가능
- 릴리스·태그·main 반영은 macOS dev-desk 흐름을 따름
- main 반영 후 dev-ios 를 main 과 --no-ff 동기화
```

**연속 작업**일 때는 `task/*` 브랜치에서 이어가고, Task 완료 시점에만 §3의 2~5단계를 수행한다.

루트 `agent.md`에서 문서·Release 명명 규칙을 빠르게 참조할 수 있습니다.

---

*최초 수립: v.0.0.0 (2026-07-06) · Task 워크플로 5단계 정리: 2026-07-10*
