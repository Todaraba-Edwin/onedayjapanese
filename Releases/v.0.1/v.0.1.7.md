# Release v.0.1.7

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.7` |
| **날짜** | 2026-07-07 |
| **브랜치** | `dev-desk` |

## 요약

Alphabet 인트로 헤더를 네비게이션 카드와 구분하는 안내 문구로 정리하고, Git Task 워크플로(`dev-desk` / `dev-ios` · `task/*`) 정책을 문서화한다.

---

## Changed

### 앱 (iOS)

- **`AlphabetIntroHeader`** — `appCardStyle` 제거, 파도 아이콘·텍스트만 표시 (선택 카드와 시각 구분)
- **`AlphabetView`** — 인트로와 메뉴 카드 스택 레이아웃 정리

### 문서

- **`docs/git-Policy.md`** — §3 Task 워크플로 추가, `dev-desk`(macOS) · `dev-ios`(iOS) · `task/*` 브랜치 정책

## Docs

- `Releases/v.0.1/v.0.1.7.md` — 이 문서
- `docs/README.md` — v.0.1.7 기준 인덱스 갱신

## 관련 파일

```
japanese-study/japanese-study/Views/Alphabet/Components/AlphabetIntroHeader.swift
japanese-study/japanese-study/Views/Alphabet/AlphabetView.swift
docs/git-Policy.md
Releases/v.0.1/v.0.1.7.md
```

---

## 다음 마일스톤

→ **v.0.1.8** — Ch.01 아행~나행 모아보기·개별보기 UI (완료)
