# Release v.0.1.9

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.9` |
| **날짜** | 2026-07-10 |
| **브랜치** | `dev-desk` |

## 요약

SwiftLint 식별자 네이밍 규칙을 문서화하고 획순 좌표 프로퍼티를 `relativeX`/`relativeY`로 정리하며, Git Task 워크플로를 5단계(dev-desk → 빌드 → main → dev 동기화 → push)로 확정한다.

---

## Changed

### 앱 (iOS)

- **`HiraganaStrokeMarker`** — `x`/`y` → `relativeX`/`relativeY` (SwiftLint `identifier_name` 준수)
- **`HiraganaChapter01Cards`** — 획순 마커 좌표 참조 동기화

### 문서 · 설정

- **`docs/git-Policy.md`** — Task 워크플로 5단계 정리 (빌드 검증 · main 반영 · dev 동기화 · origin push)
- **`docs/SwiftStudy.md`** — §13 SwiftLint `identifier_name` vs Swift 언어 규칙
- **`docs/README.md`** — 코딩 규칙(변수명 3자 이상) 확정
- **`agent.md`** — 네이밍 규칙 참조 추가
- **`.swiftlint.yml`** — `Identifiable.id` 예외(`excluded`) 등록

## Docs

- `Releases/v.0.1/v.0.1.9.md` — 이 문서
- `docs/README.md` — v.0.1.9 기준 인덱스 갱신

## 관련 파일

```
.swiftlint.yml
docs/git-Policy.md
docs/SwiftStudy.md
docs/README.md
agent.md
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaChapter01Data.swift
japanese-study/japanese-study/Views/Alphabet/Hiragana/HiraganaChapter01Cards.swift
Releases/v.0.1/v.0.1.9.md
```

---

## 다음 마일스톤

→ **v.0.1.10** (예정) — 하행~와행 확장, 획순 좌표 정밀 조정
