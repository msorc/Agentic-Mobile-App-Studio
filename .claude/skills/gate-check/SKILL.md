---
name: gate-check
description: "Validate readiness to advance between development phases. Produces a PASS/CONCERNS/FAIL verdict with specific blockers and required artifacts."
argument-hint: "[target-phase: systems-design | technical-setup | pre-production | production | polish | release]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write
---

# Phase Gate Validation

This skill validates whether the project is ready to advance to the next development
phase. It checks for required artifacts, quality standards, and blockers.

**Distinct from `/project-stage-detect`**: That skill is diagnostic ("where are we?").
This skill is prescriptive ("are we ready to advance?" with a formal verdict).

## Production Stages (6)

The project progresses through these stages:

1. **Concept** — Feature brainstorming, app concept document
2. **Systems Design** — Mapping features, writing specs
3. **Technical Setup** — Flutter/Dart configuration, architecture decisions
4. **Pre-Production** — Prototyping, vertical slice validation
5. **Production** — Feature development (Sprint/Feature/Task tracking active)
6. **Polish** — Performance, bug fixing, hardening
7. **Release** — Launch prep, store certification

**When a gate passes**, write the new stage name to `production/stage.txt`
(single line, e.g. `Production`). This updates the status line immediately.

---

## 1. Parse Arguments

- **With argument**: `/gate-check production` — validate readiness for that specific phase
- **No argument**: Auto-detect current stage using the same heuristics as
  `/project-stage-detect`, then validate the NEXT phase transition

---

## 2. Phase Gate Definitions

### Gate: Concept → Systems Design

**Required Artifacts:**
- [ ] `design/app-concept.md` exists and has content
- [ ] App pillars defined (in concept doc or `design/app-pillars.md`)

**Quality Checks:**
- [ ] App concept has been reviewed (`/design-review` verdict not MAJOR REVISION NEEDED)
- [ ] Core user flow is described and understood
- [ ] Target audience is identified

---

### Gate: Systems Design → Technical Setup

**Required Artifacts:**
- [ ] Features index exists at `design/features/index.md` with at least MVP features enumerated
- [ ] At least 1 feature spec in `design/features/` (beyond app-concept.md and index)

**Quality Checks:**
- [ ] Feature spec(s) pass design review
- [ ] Feature dependencies are mapped in the index
- [ ] MVP priority tier is defined

---

### Gate: Technical Setup → Pre-Production

**Required Artifacts:**
- [ ] Flutter configured (CLAUDE.md Technology Stack is not `[CHOOSE]`)
- [ ] Technical preferences configured (`.claude/docs/technical-preferences.md` populated)
- [ ] At least 1 Architecture Decision Record in `docs/architecture/`
- [ ] Engine reference docs exist in `docs/engine-reference/flutter/`

**Quality Checks:**
- [ ] Architecture decisions cover core systems (state management, data layer, navigation)
- [ ] Technical preferences have naming conventions and performance budgets set

---

### Gate: Pre-Production → Production

**Required Artifacts:**
- [ ] At least 1 prototype in `prototypes/` with a README
- [ ] First sprint plan exists in `production/sprints/`
- [ ] All MVP-tier feature specs from index are complete

**Quality Checks:**
- [ ] Prototype validates the core user flow hypothesis
- [ ] Sprint plan references real work items from feature specs
- [ ] Vertical slice scope is defined

---

### Gate: Production → Polish

**Required Artifacts:**
- [ ] `lib/` has active code organized into feature modules
- [ ] All core features from specs are implemented (cross-reference `design/features/` with `lib/`)
- [ ] Primary user flow is complete end-to-end
- [ ] Test files exist in `test/`
- [ ] At least 1 feature has been user-tested

**Quality Checks:**
- [ ] Tests are passing (run test suite via Bash)
- [ ] No critical/blocker bugs in any bug tracker or known issues
- [ ] Core flow works as designed (compare to spec acceptance criteria)
- [ ] Performance is within budget (check technical-preferences.md targets)

---

### Gate: Polish → Release

**Required Artifacts:**
- [ ] All features from milestone plan are implemented
- [ ] Content is complete (all features, assets, content referenced in design docs exist)
- [ ] Localization strings are externalized (no hardcoded user-facing text in `lib/`)
- [ ] QA test plan exists
- [ ] Release checklist completed (`/release-checklist` or `/launch-checklist` run)
- [ ] Store metadata prepared (if applicable)
- [ ] Changelog drafted

**Quality Checks:**
- [ ] Full QA pass signed off by `qa-lead`
- [ ] All tests passing
- [ ] Performance targets met across all target platforms
- [ ] No known critical, high, or medium-severity bugs
- [ ] Accessibility basics covered (remapping, text scaling if applicable)
- [ ] Localization verified for all target languages
- [ ] Legal requirements met (EULA, privacy policy if applicable)
- [ ] Build compiles and packages cleanly for all platforms

---

## 3. Run the Gate Check

For each item in the target gate:

### Artifact Checks
- Use `Glob` and `Read` to verify files exist and have meaningful content
- Don't just check existence — verify the file has real content (not just a template header)
- For code checks, verify directory structure and file counts

### Quality Checks
- For test checks: Run the test suite via `Bash` if a test runner is configured
- For design review checks: `Read` the feature spec and check for required sections
- For performance checks: `Read` technical-preferences.md and compare against any
  profiling data in `test/performance/` or recent `/perf-profile` output
- For localization checks: `Grep` for hardcoded strings in `lib/`

### Cross-Reference Checks
- Compare `design/features/` documents against `lib/` implementations
- Check that every feature referenced in architecture docs has corresponding code
- Verify sprint plans reference real work items

---

## 4. Collaborative Assessment

For items that can't be automatically verified, **ask the user**:

- "I can't automatically verify that the core flow works well. Has it been user tested?"
- "No user test data found. Has informal testing been done?"
- "Performance profiling data isn't available. Would you like to run `/perf-profile`?"

**Never assume PASS for unverifiable items.** Mark them as MANUAL CHECK NEEDED.

---

## 5. Output the Verdict

```
## Gate Check: [Current Phase] → [Target Phase]

**Date**: [date]
**Checked by**: gate-check skill

### Required Artifacts: [X/Y present]
- [x] design/app-concept.md — exists, 2.4KB
- [ ] docs/architecture/ — MISSING (no ADRs found)
- [x] production/sprints/ — exists, 1 sprint plan

### Quality Checks: [X/Y passing]
- [x] Feature spec has all required sections
- [ ] Tests — FAILED (3 failures in test/unit/)
- [?] Core flow user tested — MANUAL CHECK NEEDED

### Blockers
1. **No Architecture Decision Records** — Run `/architecture-decision` to create one
   covering core system architecture before entering production.
2. **3 test failures** — Fix failing tests in test/unit/ before advancing.

### Recommendations
- [Priority actions to resolve blockers]
- [Optional improvements that aren't blocking]

### Verdict: [PASS / CONCERNS / FAIL]
- **PASS**: All required artifacts present, all quality checks passing
- **CONCERNS**: Minor gaps exist but can be addressed during the next phase
- **FAIL**: Critical blockers must be resolved before advancing
```

---

## 6. Update Stage on PASS

When the verdict is **PASS** and the user confirms they want to advance:

1. Write the new stage name to `production/stage.txt` (single line, no trailing newline)
2. This immediately updates the status line for all future sessions

Example: if passing the "Pre-Production → Production" gate:
```bash
echo -n "Production" > production/stage.txt
```

**Always ask before writing**: "Gate passed. May I update `production/stage.txt` to 'Production'?"

---

## 7. Follow-Up Actions

Based on the verdict, suggest specific next steps:

- **No app concept?** → `/feature-brainstorm` to create one
- **No features index?** → `/map-systems` to decompose the concept into features
- **Missing design docs?** → `/reverse-document` or delegate to `feature-developer`
- **Missing ADRs?** → `/architecture-decision`
- **Tests failing?** → delegate to `qa-tester`
- **No user test data?** → conduct user testing
- **Performance unknown?** → `/perf-profile`
- **Not localized?** → `/localize`
- **Ready for release?** → `/launch-checklist`

---

## Collaborative Protocol

This skill follows the collaborative design principle:

1. **Scan first**: Check all artifacts and quality gates
2. **Ask about unknowns**: Don't assume PASS for things you can't verify
3. **Present findings**: Show the full checklist with status
4. **User decides**: The verdict is a recommendation — the user makes the final call
5. **Get approval**: "May I write this gate check report to production/gate-checks/?"

**Never** block a user from advancing — the verdict is advisory. Document the risks
and let the user decide whether to proceed despite concerns.
