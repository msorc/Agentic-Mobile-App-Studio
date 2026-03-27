# Release Checklist: [Version] -- [Platform]

**Release Date**: [Target Date]
**Release Manager**: [Name]
**Status**: [ ] GO / [ ] NO-GO

---

## Build Verification

- [ ] Clean build succeeds on all target platforms
- [ ] No compiler warnings (zero-warning policy)
- [ ] Build version number set correctly: `[version]`
- [ ] Build is reproducible from tagged commit: `[commit hash]`
- [ ] App size within budget: [actual] / [budget] MB
- [ ] All assets included and loading correctly
- [ ] No debug/development features enabled in release build

---

## Quality Gates

### Critical Bugs
- [ ] Zero S1 (Critical) bugs open
- [ ] Zero S2 (Major) bugs -- or documented exceptions below:

| Bug ID | Description | Exception Rationale | Approved By |
| ---- | ---- | ---- | ---- |
| | | | |

### Test Coverage
- [ ] All critical path features tested and signed off
- [ ] Full regression suite passed: [pass rate]%
- [ ] Soak test passed (4+ hours continuous use)
- [ ] Edge case testing complete

### Performance
- [ ] Target FPS met on minimum spec device: [actual] / [target] FPS
- [ ] Memory usage within budget: [actual] / [budget] MB
- [ ] App launch time within budget: [actual] / [target] seconds
- [ ] No memory leaks over extended use (soak test)
- [ ] No frame drops below [threshold] in normal usage

---

## Content Complete

- [ ] All placeholder assets replaced with final versions
- [ ] All user-facing text proofread
- [ ] All text localization-ready (no hardcoded strings)
- [ ] Localization complete for: [list locales]
- [ ] In-app purchases tested and finalized
- [ ] Legal notices and third-party attributions complete

---

## Platform: iOS

- [ ] App Store Connect metadata complete
- [ ] Screenshots meet App Store requirements (all sizes)
- [ ] App preview videos (if applicable)
- [ ] Age rating configured: [rating]
- [ ] Privacy policy URL configured
- [ ] TestFlight beta testing complete
- [ ] Bundle ID correct: `[bundle.id]`
- [ ] Capabilities configured: [list]
- [ ] Push notification certificates valid
- [ ] In-app purchase sandbox tested

## Platform: Android

- [ ] Play Console metadata complete
- [ ] Screenshots meet Play Store requirements
- [ ] Feature graphic and icon meet requirements
- [ ] Age rating configured: [rating]
- [ ] Privacy policy URL configured
- [ ] Internal testing track complete
- [ ] Package name correct: `[package.name]`
- [ ] Signing keys secured
- [ ] ProGuard/R8 rules configured
- [ ] In-app billing sandbox tested

## Platform: Web

- [ ] Production build successful
- [ ] CDN deployment verified
- [ ] Service worker registered and working
- [ ] Offline fallback tested
- [ ] Responsive layout verified on all breakpoints
- [ ] PWA manifest verified

## Platform: Desktop

- [ ] Minimum and recommended specs documented
- [ ] Installer created and tested: [Windows/macOS/Linux]
- [ ] Auto-update mechanism tested
- [ ] App data persistence verified

---

## Store and Distribution

### App Store (iOS)
- [ ] App Store page metadata complete and proofread
- [ ] Keywords optimized for discovery
- [ ] Marketing contact configured
- [ ] Pricing configured for all regions
- [ ] Review notes submitted (if applicable)

### Google Play (Android)
- [ ] Play Store listing complete and proofread
- [ ] Graphics meet Play Store requirements
- [ ] Content rating questionnaire completed
- [ ] Pricing configured for all regions
- [ ] Testing tracks completed

### Web/Desktop
- [ ] Landing page ready
- [ ] Download/install mechanism tested

---

## Launch Readiness

- [ ] Analytics/telemetry verified and receiving data
- [ ] Crash reporting configured: [service name]
- [ ] Day-one patch prepared (if needed)
- [ ] On-call team schedule set for first 72 hours
- [ ] User announcements drafted
- [ ] Support team briefed on known issues
- [ ] Rollback plan documented and tested
- [ ] Customer support documentation updated

---

## Sign-offs

| Role | Name | Status | Date |
| ---- | ---- | ---- | ---- |
| QA Lead | | [ ] Approved | |
| Technical Lead | | [ ] Approved | |
| Project Manager | | [ ] Approved | |
| Product Designer | | [ ] Approved | |

---

## Final Decision

**GO / NO-GO**: ____________

**Rationale**: [Summary of readiness. If NO-GO, list specific blocking items and estimated time to resolve.]

**Notes**: [Any additional context, known risks accepted, or conditions on the release.]
