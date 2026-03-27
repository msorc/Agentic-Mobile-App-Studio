---
name: release-checklist
description: "Generates a comprehensive pre-release validation checklist covering build verification, certification requirements, store metadata, and launch readiness."
argument-hint: "[platform: ios|android|web|desktop|all]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

When this skill is invoked:

> **Explicit invocation only**: This skill should only run when the user explicitly requests it with `/release-checklist`. Do not auto-invoke based on context matching.

1. **Read the argument** for the target platform (`ios`, `android`, `web`, `desktop`,
   or `all`). If no platform is specified, default to `all`.

2. **Read CLAUDE.md** for project context, version information, and platform
   targets.

3. **Read the current milestone** from `production/milestones/` to understand
   what features and content should be included in this release.

4. **Scan the codebase** for outstanding issues:
   - Count `TODO` comments
   - Count `FIXME` comments
   - Count `HACK` comments
   - Note their locations and severity

5. **Check for test results** in any test output directories or CI logs if
   available.

6. **Generate the release checklist**:

```markdown
## Release Checklist: [Version] -- [Platform]
Generated: [Date]

### Codebase Health
- TODO count: [N] ([list top 5 if many])
- FIXME count: [N] ([list all -- these are potential blockers])
- HACK count: [N] ([list all -- these need review])

### Build Verification
- [ ] Clean build succeeds on all target platforms
- [ ] No compiler warnings (zero-warning policy)
- [ ] All assets included and loading correctly
- [ ] Build size within budget ([target size])
- [ ] Build version number correctly set ([version])
- [ ] Build is reproducible from tagged commit

### Quality Gates
- [ ] Zero S1 (Critical) bugs
- [ ] Zero S2 (Major) bugs -- or documented exceptions with project-manager approval
- [ ] All critical path features tested and signed off by QA
- [ ] Performance within budgets:
  - [ ] Target FPS met on minimum spec hardware
  - [ ] Memory usage within budget
  - [ ] Load times within budget
  - [ ] No memory leaks over extended usage
- [ ] No regression from previous build
- [ ] Soak test passed (4+ hours continuous use)

### Content Complete
- [ ] All placeholder assets replaced with final versions
- [ ] All TODO/FIXME in content files resolved or documented
- [ ] All user-facing text proofread
- [ ] All text localization-ready (no hardcoded strings)
- [ ] Credits complete and accurate
```

7. **Add platform-specific sections** based on the argument:

For `ios`:
```markdown
### Platform Requirements: iOS
- [ ] App Store Review Guidelines compliance verified
- [ ] All required permissions justified (Camera, Location, Notifications, etc.)
- [ ] Privacy policy linked and accurate
- [ ] App icon and splash screen correct sizes
- [ ] Test on multiple iOS versions and device sizes
- [ ] Test on iPhone and iPad layouts
- [ ] Test with Dynamic Type enabled
- [ ] Test with VoiceOver enabled
- [ ] Test with Reduce Motion enabled
- [ ] In-app purchase flow tested (if applicable)
- [ ] Push notification setup tested (if applicable)
```

For `android`:
```markdown
### Platform Requirements: Android
- [ ] Play Store policy compliance verified
- [ ] All required permissions justified and documented
- [ ] Privacy policy linked and accurate
- [ ] Data safety form completed
- [ ] App icon and splash screen correct sizes
- [ ] Test on multiple Android versions (API 21+)
- [ ] Test on multiple screen sizes and densities
- [ ] Test with TalkBack enabled
- [ ] Test with Reduced Motion enabled
- [ ] In-app purchase flow tested (if applicable)
- [ ] Push notification setup tested (if applicable)
```

For `web`:
```markdown
### Platform Requirements: Web
- [ ] WCAG 2.1 AA accessibility compliance verified
- [ ] Test on Chrome, Firefox, Safari, Edge
- [ ] Responsive layout tested on mobile/tablet/desktop
- [ ] Keyboard navigation tested
- [ ] Screen reader tested (NVDA, VoiceOver)
- [ ] PWA manifest and service worker configured
- [ ] Offline functionality verified (if applicable)
```

For `desktop`:
```markdown
### Platform Requirements: Desktop
- [ ] Windows, macOS, and/or Linux builds tested
- [ ] Keyboard+mouse controls fully functional
- [ ] Controller support tested (if applicable)
- [ ] Resolution scaling tested (1080p, 1440p, 4K)
- [ ] Windowed and fullscreen modes working
- [ ] Auto-update mechanism tested (if applicable)
```

8. **Add store and launch sections**:

```markdown
### Store / Distribution
- [ ] Store page metadata complete and proofread
  - [ ] Short description
  - [ ] Long description
  - [ ] Feature list
  - [ ] System requirements
- [ ] Screenshots up to date and per-platform resolution requirements met
- [ ] App preview videos current (if applicable)
- [ ] Key art and capsule images current
- [ ] Age rating obtained and configured (if applicable)
- [ ] Legal notices, EULA, and privacy policy in place
- [ ] Third-party license attributions complete
- [ ] Pricing configured for all regions (if applicable)

### Launch Readiness
- [ ] Analytics / telemetry verified and receiving data
- [ ] Crash reporting configured and dashboard accessible
- [ ] Day-one patch prepared and tested (if needed)
- [ ] On-call team schedule set for first 72 hours
- [ ] Community launch announcements drafted
- [ ] Support team briefed on known issues and FAQ
- [ ] Rollback plan documented (if critical issues found post-launch)

### Go / No-Go: [READY / NOT READY]

**Rationale:**
[Summary of readiness assessment. List any blocking items that must be
resolved before launch. If NOT READY, list the specific items that need
resolution and estimated time to address them.]

**Sign-offs Required:**
- [ ] QA Lead
- [ ] Technical Lead
- [ ] Project Manager
```

9. **Save the checklist** to
   `production/releases/release-checklist-[version].md`, creating the
   directory if it does not exist.

10. **Output a summary** to the user with: total checklist items, number of
    known blockers (FIXME/HACK counts, known bugs), and the file path.
