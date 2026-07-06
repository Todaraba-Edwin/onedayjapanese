# Release v.0.1.6

| 항목 | 내용 |
|------|------|
| **태그** | `v.0.1.6` |
| **날짜** | 2026-07-07 |
| **브랜치** | `dev-ios` |

## 요약

앱 아이콘(oneday japanese · 파도 무드)을 iOS `AppIcon` 및 web 메타(apple-touch-icon, OG, PWA manifest)에 반영한다.

---

## Added

### 앱 (iOS)

- **`AppIcon.appiconset`** — 1024×1024 앱 아이콘 등록 (`AppIcon.png`)
- 원본 레퍼런스 — `reperence/app-icon.png`

### Web 메타

- `web/apple-touch-icon.png` — iOS Safari 홈 화면 추가 (180×180)
- `web/favicon-16x16.png` · `web/favicon-32x32.png` — 파비콘
- `web/icon-192.png` · `web/icon-512.png` — PWA 아이콘
- `web/og-image.png` — Open Graph / Twitter Card (1200×630)
- `web/site.webmanifest` — PWA manifest
- `web/index.html` — favicon · apple-touch-icon · OG · Twitter meta 태그

## Docs

- `Releases/v.0.1/v.0.1.6.md` — 이 문서
- `docs/README.md` — v.0.1.6 기준 인덱스 갱신

## 관련 파일

```
japanese-study/japanese-study/Assets.xcassets/AppIcon.appiconset/
reperence/app-icon.png
web/
Releases/v.0.1/v.0.1.6.md
```

---

## 다음 마일스톤

→ **v.0.1.7** (예정) — Ch.01 50음도 그리드·데이터 모델
