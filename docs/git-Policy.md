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
main                    ← 최종 안정·배포 기준
├── dev-desk            ← macOS — task/* 생성 · 병합 · 태그
├── dev-ios             ← iPhone(iOS) — task/* 생성 · 병합 · 태그
└── task/*              ← Task 작업 브랜치 (완료 후 작업 환경의 dev-*에 병합)
```

| 브랜치 | 작업 환경 | 용도 |
|--------|-----------|------|
| `main` | — | 최종 안정·배포 기준. `dev-desk` / `dev-ios`에서 검증된 내용을 반영 |
| `dev-desk` | **macOS** | Mac에서 `task/*` 생성 · Task 완료 후 머지·태그·push |
| `dev-ios` | **iPhone (iOS)** | iOS에서 `task/*` 생성 · Task 완료 후 머지·태그·push |
| `task/*` | macOS / iOS | **새 Task** 단위 작업 브랜치 (작업 환경의 `dev-*`에서 생성) |
| `fix/*` | — | 긴급 버그 수정 (필요 시 `task/` 대신 사용) |

### 연속 작업 vs 새 Task

| 구분 | 언제 | 브랜치 |
|------|------|--------|
| **새 Task** | 독립된 목표·릴리스 단위로 **새로 시작**할 때 | 작업 환경의 `dev-desk` / `dev-ios`에서 `task/{주제}` 생성 → 완료 후 **같은 `dev-*`에 병합** |
| **연속 작업** | 같은 Task·같은 버전 범위를 **이어갈** 때 | `dev-desk`(macOS) 또는 `dev-ios`(iOS)에서 계속 |

> **작업 환경에 맞는 `dev-*`에서 `task/*`를 분기**하고, 완료 후 **같은 `dev-*`에 병합·태그**한다.

### 규칙

- **macOS 새 Task** → `dev-desk`에서 `task/{주제}` 생성 → 완료 후 `dev-desk`에 병합 · 태그 · push
- **iOS 새 Task** → `dev-ios`에서 `task/{주제}` 생성 → 완료 후 `dev-ios`에 병합 · 태그 · push
- 버전 태그 (`v.x.y.z`)는 **`dev-desk` 또는 `dev-ios`의 병합 커밋**에만 생성
- 태그된 커밋은 **force push 금지**
- `main`은 안정 스냅샷을 반영할 때만 갱신

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

**새 Task**를 시작할 때 아래 순서를 따른다. **연속 작업**은 해당 환경의 `dev-desk` / `dev-ios`에서 이어간다.

### 절차 요약

```
1. 작업 환경의 dev-* 에서 task/{주제} 브랜치 생성
2. task/* 에서 작업 + Release 문서 작성 (§4·§5)
3. 같은 dev-desk 또는 dev-ios 에 병합 (merge)
4. 병합 커밋에 버전 태그 (v.MAJOR.MINOR.PATCH)
5. origin 에 dev-* · 태그 push
```

| 작업 환경 | Task 생성 · 병합 · 태그 · push |
|-----------|-------------------------------|
| macOS | `dev-desk` |
| iPhone (iOS) | `dev-ios` |

### 1) Task 브랜치 생성

**macOS에서 작업할 때:**

```bash
git checkout dev-desk
git pull origin dev-desk
git checkout -b task/hiragana-ch01-grid
```

**iPhone(iOS)에서 작업할 때:**

```bash
git checkout dev-ios
git pull origin dev-ios
git checkout -b task/hiragana-ch01-grid
```

### 2) 작업 · Release 문서

- 기능·문서 작업을 `task/*` 브랜치에서 커밋
- Task 완료 시 §4 SemVer에 맞는 버전 번호를 정하고, §5 규칙에 따라 Release 문서 작성  
  예: `Releases/v.0.1/v.0.1.7.md` (폴더 `v.0.0` / `v.0.1` … 마이너 단위)
- `docs/README.md` 등 연관 문서 갱신 (§5 참고)
- Release 문서 **브랜치** 항목에는 병합 대상 (`dev-desk` 또는 `dev-ios`) 기록

### 3) `dev-desk` / `dev-ios` 병합

**macOS (dev-desk):**

```bash
git checkout dev-desk
git pull origin dev-desk
git merge --no-ff task/hiragana-ch01-grid -m "merge: task/hiragana-ch01-grid — 히라가나 Ch.01 50음도 그리드"
```

**iPhone iOS (dev-ios):**

```bash
git checkout dev-ios
git pull origin dev-ios
git merge --no-ff task/hiragana-ch01-grid -m "merge: task/hiragana-ch01-grid — 히라가나 Ch.01 50음도 그리드"
```

- **`--no-ff`** 권장 — Task 단위 머지 이력을 남긴다
- 충돌 해결 후 병합 커밋 완료

### 4) 버전 태그 (병합 커밋 HEAD)

```bash
git tag -a v.0.1.7 -m "v.0.1.7 — 히라가나 Ch.01 50음도 그리드"
```

- 태그는 **`dev-desk` 또는 `dev-ios`의 병합 완료 커밋**에 붙인다
- `task/*` 브랜치 HEAD에 직접 태그하지 않는다
- 태그 형식: **`v.MAJOR.MINOR.PATCH`** (§4)

### 5) 원격 push · 정리

**macOS (dev-desk):**

```bash
git push origin dev-desk
git push origin v.0.1.7
```

**iPhone iOS (dev-ios):**

```bash
git push origin dev-ios
git push origin v.0.1.7
```

```bash
# (선택) Task 브랜치 삭제
git branch -d task/hiragana-ch01-grid
git push origin --delete task/hiragana-ch01-grid   # 원격에 올렸을 때만
```

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
- 태그는 Release 문서가 포함된 **`dev-desk` 또는 `dev-ios` 병합 커밋**에 붙임 (§3)

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

### 릴리스 절차 (Task → dev-* → 태그 → push)

§3 Task 워크플로에 따른 최종 단계. `{dev}` 는 작업 환경에 따라 `dev-desk` 또는 `dev-ios`.

```bash
# 0) 새 Task — 작업 환경의 dev-* 에서 분기
git checkout dev-desk && git pull origin dev-desk   # macOS
# git checkout dev-ios && git pull origin dev-ios   # iOS
git checkout -b task/{주제}

# 1) task/* 에서 작업·Release 문서·docs/README.md 갱신 완료

# 2) 같은 dev-* 에 병합
git checkout {dev}          # dev-desk (macOS) 또는 dev-ios (iOS)
git merge --no-ff task/{주제} -m "merge: task/{주제} — {한 줄 요약}"

# 3) annotated tag — {dev} HEAD 에 붙임
git tag -a v.0.1.7 -m "v.0.1.7 — {한 줄 요약}"

# 4) 원격 반영
git push origin {dev}
git push origin v.0.1.7
```

### 원격 push 규칙

- **통합 브랜치**: 릴리스·태그 후 작업 환경에 맞게 push  
  - macOS: `git push origin dev-desk`  
  - iOS: `git push origin dev-ios`
- **태그**: 새 태그 생성 직후 `origin`에 반영한다. 로컬에만 태그를 두지 않는다.
- **전체 태그 동기화**: `git push origin --tags`
- **단일 태그만 올릴 때**: `git push origin v.0.1.7`
- **`main` 반영**: `dev-desk` / `dev-ios` 검증 후 별도 머지·push (배포 시점에 맞춤)
- **확인**: `git ls-remote --tags origin`

> HTTP push 시 `RPC failed; HTTP 400`이 나면 `git config http.postBuffer 524288000` 후 재시도한다.

### 태그 종류

| 종류 | 명령 | 용도 |
|------|------|------|
| Annotated | `git tag -a v.x.y.z -m "..."` | **권장** — 메시지·날짜 포함 |
| Lightweight | `git tag v.x.y.z` | 간단 참조용 |

---

## 8. 에이전트 협업 시 참고

에이전트에게 **새 Task** 작업을 요청할 때 — **작업 환경(macOS / iOS)** 을 명시한다.

**macOS 예시:**

```
docs/git-Policy.md §3 Task 워크플로에 따라 (macOS / dev-desk):
1. dev-desk 기준 task/{주제} 브랜치 생성
2. 작업 후 Releases/v.0.1/v.0.1.{N}.md 작성 (§4·§5)
3. docs/README.md — Release 표·현재 구현 상태 갱신
4. dev-desk 에 merge (--no-ff)
5. dev-desk HEAD 에 annotated tag v.0.1.{N}
6. git push origin dev-desk && git push origin v.0.1.{N}
```

**iPhone iOS 예시:**

```
docs/git-Policy.md §3 Task 워크플로에 따라 (iOS / dev-ios):
1. dev-ios 기준 task/{주제} 브랜치 생성
2. 작업 후 Releases/v.0.1/v.0.1.{N}.md 작성 (§4·§5)
3. docs/README.md — Release 표·현재 구현 상태 갱신
4. dev-ios 에 merge (--no-ff)
5. dev-ios HEAD 에 annotated tag v.0.1.{N}
6. git push origin dev-ios && git push origin v.0.1.{N}
```

**연속 작업**일 때는 해당 환경의 `dev-desk` / `dev-ios`에서 이어가고, Task 완료 시점에만 §3 병합·태그·push를 수행한다.

루트 `agent.md`에서 문서·Release 명명 규칙을 빠르게 참조할 수 있습니다.

---

*최초 수립: v.0.0.0 (2026-07-06)*
