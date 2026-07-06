# Git Policy — japanese-study

이 문서는 `japanese-study` 저장소의 브랜치, 커밋, 태그, Release 문서 관리 정책을 정의합니다.

---

## 목차

1. [저장소 구조](#1-저장소-구조)
2. [브랜치 정책](#2-브랜치-정책)
3. [버전 번호 규칙 (SemVer)](#3-버전-번호-규칙-semver)
4. [Release 문서 정책](#4-release-문서-정책)
5. [커밋 규칙](#5-커밋-규칙)
6. [태그 & Push 절차](#6-태그--push-절차)
7. [에이전트 협업 시 참고](#7-에이전트-협업-시-참고)

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
│       └── v.0.1.3.md
├── japanese-study/          # Xcode 프로젝트
├── reperence/               # UI 레퍼런스 이미지
└── buildServer.json
```

---

## 2. 브랜치 정책

| 브랜치 | 용도 |
|--------|------|
| `main` | 항상 배포 가능한 안정 버전. 태그는 `main`에만 생성 |
| `feature/*` | 기능 개발 (예: `feature/hiragana-ch01-grid`) |
| `fix/*` | 버그 수정 |

### 규칙

- 기본 브랜치: **`main`**
- `main`에 직접 커밋하거나, PR 머지 후 태그
- 태그된 커밋은 **force push 금지**

---

## 3. 버전 번호 규칙 (SemVer)

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

## 4. Release 문서 정책

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

- 태그 생성 **전** Release 문서를 먼저 작성·커밋
- 태그는 Release 문서가 포함된 커밋에 붙임

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

## 5. 커밋 규칙

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

### 언어

- 커밋 메시지 **요약·본문은 한글**로 작성한다.
- `type` 접두사(`feat`, `fix`, `docs` 등)만 영문 소문자를 유지한다.

### 예시

```
feat: Alphabet 탭 및 히라가나 Ch.01·02 골격 추가

docs: v.0.1.1 릴리스 노트 및 git 정책 수립
```

---

## 6. 태그 & Push 절차

```bash
# 1) Release 문서 + docs/README.md 갱신 후 스테이징
git add Releases/ docs/README.md docs/ ...

# 2) 커밋
git commit -m "docs: v.0.1.1 릴리스 노트 및 기능 스냅샷"

# 3) annotated tag (권장)
git tag -a v.0.1.1 -m "v.0.1.1 — Alphabet 탭, 파도 UI, 문서"

# 4) push
git push origin main
git push origin v.0.1.1
```

### 태그 종류

| 종류 | 명령 | 용도 |
|------|------|------|
| Annotated | `git tag -a v.x.y.z -m "..."` | **권장** — 메시지·날짜 포함 |
| Lightweight | `git tag v.x.y.z` | 간단 참조용 |

---

## 7. 에이전트 협업 시 참고

에이전트에게 버전 작업을 요청할 때:

```
docs/git-Policy.md 정책에 따라
- Releases/v.0.1/v.0.1.4.md 작성
- docs/README.md — Release 표·현재 구현 상태를 v.0.1.4로 갱신
- 커밋 후 annotated tag v.0.1.4 생성
```

루트 `agent.md`에서 문서·Release 명명 규칙을 빠르게 참조할 수 있습니다.

---

*최초 수립: v.0.0.0 (2026-07-06)*
