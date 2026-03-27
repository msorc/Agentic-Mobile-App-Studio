---
name: launch-checklist
description: "Complete launch readiness validation covering every department: code, content, store, marketing, community, infrastructure, legal, and go/no-go sign-offs."
argument-hint: "[launch-date or 'dry-run']"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

When this skill is invoked:

> **Explicit invocation only**: This skill should only run when the user explicitly requests it with `/launch-checklist`. Do not auto-invoke based on context matching.

1. **Read the argument** for the launch date or `dry-run` mode. Dry-run mode
   generates the checklist without creating sign-off entries.

2. **Gather project context**:
   - Read `CLAUDE.md` for tech stack, target platforms, and team structure
   - Read the latest milestone in `production/milestones/`
   - Read any existing release checklist in `production/releases/`
   - Read the content calendar in `design/live-ops/content-calendar.md` if it exists

3. **Scan codebase health**:
   - Count `TODO`, `FIXME`, `HACK` comments and their locations
   - Check for any `console.log`, `print()`, or debug output left in production code
   - Check for placeholder assets (search for `placeholder`, `temp_`, `WIP_`)
   - Check for hardcoded test/dev values (localhost, test credentials, debug flags)

4. **Generate the launch checklist**:

```markdown
# Launch Checklist: [App Name]
Target Launch: [Date or DRY RUN]
Generated: [Date]

---

## 1. Code Readiness

### Build Health
- [ ] Clean build on all target platforms (iOS, Android, Web, Desktop)
- [ ] Zero compiler warnings
- [ ] All unit tests passing
- [ ] All integration tests passing
- [ ] Performance benchmarks within targets
- [ ] No memory leaks (verified via extended soak test)
- [ ] Build size within platform limits
- [ ] Build version correctly set and tagged in source control

### Code Quality
- [ ] TODO count: [N] (zero required for launch, or documented exceptions)
- [ ] FIXME count: [N] (zero required)
- [ ] HACK count: [N] (each must have documented justification)
- [ ] No debug output in production code
- [ ] No hardcoded dev/test values
- [ ] All feature flags set to production values
- [ ] Error handling covers all critical paths
- [ ] Crash reporting integrated and verified

### Security
- [ ] No exposed API keys or credentials in source
- [ ] Sensitive data encrypted (user data, tokens)
- [ ] Network communication secured (TLS/DTLS)
- [ ] Input validation on all server endpoints
- [ ] Privacy policy compliance verified

---

## 2. Content Readiness

### Assets
- [ ] All placeholder art replaced with final assets
- [ ] No missing or broken asset references
- [ ] Asset naming conventions enforced
- [ ] App icons and splash screens finalized for all platforms

### Text and Localization
- [ ] All user-facing text proofread
- [ ] No hardcoded strings (all externalized for localization)
- [ ] All supported languages translated and verified
- [ ] Text fits UI in all languages (text fitting pass complete)
- [ ] Font coverage verified for all supported languages
- [ ] Credits complete, accurate, and up to date

### App Content
- [ ] All primary user flows complete and tested
- [ ] Onboarding flow complete and tested with new users
- [ ] Settings and preferences working correctly
- [ ] All deep links verified
- [ ] Error states and empty states designed and implemented

---

## 3. Quality Assurance

### Testing
- [ ] Full regression test suite passed
- [ ] Zero S1 (Critical) bugs open
- [ ] Zero S2 (Major) bugs open (or documented exceptions)
- [ ] Soak test passed (8+ hours continuous use)
- [ ] All critical user paths tested on every platform
- [ ] Edge cases tested (full storage, no network, suspend/resume, background/foreground)

### Platform Certification
- [ ] iOS: App Store Review Guidelines compliant
- [ ] Android: Play Store policy compliant
- [ ] Web: WCAG 2.1 accessibility standards met
- [ ] Desktop: Platform-specific requirements met
- [ ] Accessibility: minimum standards met (remapping, text scaling, screen reader)

### Performance
- [ ] Target FPS met on minimum spec hardware
- [ ] Load times within budget on all platforms
- [ ] Memory usage within budget on all platforms
- [ ] No frame hitches in critical user moments
- [ ] Offline functionality verified

---

## 4. Store and Distribution

### Store Pages
- [ ] Store page copy finalized and proofread
- [ ] Screenshots current and per-platform resolution
- [ ] App preview videos current and approved
- [ ] Key art and capsule images finalized
- [ ] System requirements accurate
- [ ] Pricing configured for all regions (if applicable)

### Legal
- [ ] EULA finalized and approved by legal
- [ ] Privacy policy published and linked
- [ ] Third-party license attributions complete
- [ ] GDPR/CCPA compliance verified (data collection, consent, deletion)
- [ ] App permissions justified and documented

---

## 5. Infrastructure

### Backend (if applicable)
- [ ] Production servers provisioned and load-tested
- [ ] Auto-scaling configured and tested
- [ ] Database backups configured
- [ ] CDN configured for content delivery
- [ ] DDoS protection active
- [ ] Monitoring and alerting configured

### Analytics and Monitoring
- [ ] Analytics pipeline verified and receiving data
- [ ] Crash reporting active and dashboard accessible
- [ ] Server monitoring dashboards live
- [ ] Key metrics tracked: DAU, session length, retention, crashes
- [ ] Alerts configured for critical thresholds

---

## 6. Community and Marketing

### Community Readiness
- [ ] Community guidelines published
- [ ] Moderation team briefed and tools ready
- [ ] Support email/ticketing system active

### Marketing
- [ ] App Store optimization complete
- [ ] Press/influencer review keys distributed (if applicable)
- [ ] Social media launch posts scheduled
- [ ] Launch day blog post/update drafted

---

## 7. Operations

### Team Readiness
- [ ] On-call schedule set for first 72 hours post-launch
- [ ] Incident response playbook reviewed by team
- [ ] Rollback plan documented and tested
- [ ] Hotfix pipeline tested (can ship emergency fix within 4 hours)
- [ ] Communication plan for launch issues (who posts, where, how fast)

### Day-One Plan
- [ ] Day-one patch prepared (if needed)
- [ ] Go-live procedure documented
- [ ] Launch monitoring dashboard bookmarked by all leads
- [ ] War room/channel established for launch day

---

## Go / No-Go Decision

**Overall Status**: [READY / NOT READY / CONDITIONAL]

### Blocking Items
[List any items that must be resolved before launch]

### Conditional Items
[List items that have documented workarounds or accepted risk]

### Sign-Offs Required
- [ ] Technical Lead — Technical health and stability
- [ ] QA Lead — Quality and test coverage
- [ ] Project Manager — Schedule and overall readiness
- [ ] Release Manager — Build and deployment readiness
```

5. **Save the checklist** to
   `production/releases/launch-checklist-[date].md`, creating directories as needed.

6. **Output a summary** to the user: total items, blocking items count,
   conditional items count, departments with incomplete sections, and the file path.
