# Agent Coordination and Delegation Map

## Organizational Hierarchy

```
                            [Human Developer]
                                  |
                  +---------------+---------------+
                  |               |               |
           product-owner   technical-lead   project-manager
                  |               |               |
         +--------+--------+     |        (coordinates all)
         |        |        |     |
   product-designer  ux-design-lead  app-architecture-specialist
         |        |        |         |                |
      +--+--+     |     +--+--+  +--+--+--+--+--+   |
      |  |  |     |     |     |  |  |  |  |  |  |   |
    feat- app-flow ui-eng mobile-ux  perf-  integra-  qa-lead
    dev   designer            analyst  tion
                                  |
                              +---+---+
                              |       |
                           ios    android  web  desktop
                           spec   spec    spec  spec

   Additional Leads (report to project-manager/directors):
     release-manager         -- Release pipeline, versioning, deployment
     localization-lead       -- i18n, arb files, translation pipeline
     security-engineer       -- Auth patterns, data encryption, secure storage
     accessibility-specialist -- WCAG, screen readers, text scaling

   Platform Specialists (use the SET matching your targets):
     ios-specialist          -- iOS lead: Swift interop, Cupertino widgets
       ios-widgets-specialist        -- iOS-native widgets, CupertinoApp
       ios-signature-specialist       -- Sign in with Apple

     android-specialist      -- Android lead: Material Design, Kotlin interop
       android-material-specialist   -- Material 3, Material widgets
       android-play-specialist        -- Play Store, AAB, submission

     web-specialist          -- Web lead: Web widgets, PWA
       web-pwa-specialist             -- Service workers, manifest, offline
       web-seo-specialist             -- Meta tags, semantic HTML

     desktop-specialist      -- Desktop lead: Win/Mac/Linux
       desktop-linux-specialist       -- Linux builds, GTK
       desktop-windows-specialist     -- Windows builds, Win32
       desktop-macos-specialist       -- macOS builds, AppKit
```

### Legend
```
feat-dev = feature-developer      perf-a  = performance-analyst
app-flow = app-flow-designer      integra = integration-specialist
ui-eng   = ui-engineer            qa-lead = qa-lead
mobile-ux= mobile-ux-specialist   ios    = ios-specialist
ux-lead  = ux-design-lead         android = android-specialist
app-arch = app-architecture-specialist web = web-specialist
prod-des = product-designer       desktop = desktop-specialist
```

## Delegation Rules

### Who Can Delegate to Whom

| From | Can Delegate To |
|------|----------------|
| product-owner | product-designer, ux-design-lead, security-engineer |
| technical-lead | app-architecture-specialist, flutter-specialist, devops-engineer, performance-analyst |
| project-manager | Any agent (task assignment within their domain only) |
| product-designer | feature-developer, app-flow-designer |
| app-architecture-specialist | feature-developer, platform-channel-specialist, integration-specialist |
| ux-design-lead | mobile-ux-specialist, ui-engineer, accessibility-specialist |
| qa-lead | qa-tester |
| release-manager | devops-engineer (release builds), qa-lead (release testing) |
| flutter-specialist | [all platform specialists for Flutter-specific questions] |
| ios-specialist | ios-widgets-specialist, ios-signature-specialist |
| android-specialist | android-material-specialist, android-play-specialist |
| web-specialist | web-pwa-specialist, web-seo-specialist |
| desktop-specialist | desktop-linux-specialist, desktop-windows-specialist, desktop-macos-specialist |
| state-management-specialist | feature-developer (for state architecture decisions) |
| security-engineer | integration-specialist (secure data handling) |
| accessibility-specialist | ui-engineer (accessible implementation), qa-tester (a11y testing) |

### Escalation Paths

| Situation | Escalate To |
|-----------|------------|
| Two designers disagree on a feature | product-designer |
| Feature vs UX conflict | ux-design-lead |
| Feature vs technical feasibility | project-manager (facilitates), then product-owner + technical-lead |
| Architecture disagreement | technical-lead |
| Cross-feature code conflict | app-architecture-specialist, then technical-lead |
| Schedule conflict between departments | project-manager |
| Scope exceeds capacity | project-manager, then product-owner for cuts |
| Quality gate disagreement | qa-lead, then technical-lead |
| Performance budget violation | performance-analyst flags, technical-lead decides |

## Common Workflow Patterns

### Pattern 1: New Feature (Full Pipeline)

```
 1. product-owner        -- Approves feature concept aligns with roadmap
 2. product-designer     -- Creates PRD with full spec
 3. project-manager     -- Schedules work, identifies dependencies
 4. app-architecture-specialist -- Designs Clean Architecture structure
 5. feature-developer   -- Implements the feature (data/domain/presentation)
 6. ui-engineer          -- Implements custom UI (if needed)
 7. integration-specialist -- Implements API integration (if needed)
 8. qa-tester            -- Writes test cases
 9. qa-lead              -- Reviews and approves test coverage
10. app-architecture-specialist -- Code review
11. qa-tester            -- Executes tests
12. project-manager      -- Marks task complete
```

### Pattern 2: Bug Fix

```
 1. qa-tester             -- Files bug report with /bug-report
 2. qa-lead               -- Triages severity and priority
 3. project-manager       -- Assigns to sprint (if not S1)
 4. app-architecture-specialist -- Identifies root cause, assigns to developer
 5. feature-developer     -- Fixes the bug
 6. app-architecture-specialist -- Code review
 7. qa-tester             -- Verifies fix and runs regression
 8. qa-lead               -- Closes bug
```

### Pattern 3: Platform-Specific Feature

```
 1. ux-design-lead        -- Defines cross-platform UX requirements
 2. [platform]-specialist -- Implements platform-specific UI/behavior
 3. flutter-specialist    -- Reviews Flutter integration
 4. qa-tester             -- Tests on target platform
 5. qa-lead               -- Platform-specific QA sign-off
```

### Pattern 4: Sprint Cycle

```
 1. project-manager       -- Plans sprint with /sprint-plan new
 2. [All agents]          -- Execute assigned tasks
 3. project-manager       -- Daily status with /sprint-plan status
 4. qa-lead               -- Continuous testing during sprint
 5. app-architecture-specialist -- Continuous code review during sprint
 6. project-manager       -- Sprint retrospective with post-sprint hook
 7. project-manager       -- Plans next sprint incorporating learnings
```

### Pattern 5: Milestone Checkpoint

```
 1. project-manager       -- Runs /milestone-review
 2. product-owner         -- Reviews product progress
 3. technical-lead        -- Reviews technical health
 4. qa-lead               -- Reviews quality metrics
 5. project-manager       -- Facilitates go/no-go discussion
 6. [All leads]           -- Agree on scope adjustments if needed
 7. project-manager       -- Documents decisions and updates plans
```

### Pattern 6: Release Pipeline

```
 1. project-manager       -- Declares release candidate, confirms milestone criteria met
 2. release-manager       -- Cuts release branch, generates /release-checklist
 3. qa-lead               -- Runs full regression, signs off on quality
 4. localization-lead    -- Verifies all strings translated, text fitting passes
 5. performance-analyst  -- Confirms performance benchmarks within targets
 6. devops-engineer      -- Builds release artifacts, runs deployment pipeline
 7. release-manager      -- Generates /changelog, tags release, creates release notes
 8. technical-lead       -- Final sign-off on major releases
 9. release-manager      -- Deploys and monitors for 48 hours
10. project-manager      -- Marks release complete
```

### Pattern 7: Feature Brainstorm

```
 1. product-owner         -- Defines problem statement or opportunity
 2. product-designer      -- Leads /feature-brainstorm session
 3. ux-design-lead        -- Provides UX perspective
 4. technical-lead         -- Provides technical feasibility input
 5. product-designer      -- Synthesizes into PRD draft
 6. product-owner         -- Reviews and approves PRD
 7. project-manager       -- Schedules implementation
```

### Pattern 8: App Prototype

```
 1. product-designer      -- Defines the hypothesis and success criteria
 2. flutter-specialist    -- Scaffolds prototype with /app-prototype
 3. flutter-specialist    -- Builds minimal implementation (hours, not days)
 4. product-designer      -- Evaluates prototype against criteria
 5. flutter-specialist    -- Documents findings report
 6. product-owner         -- Go/no-go decision on proceeding to production
 7. project-manager       -- Schedules production work if approved
```

## Cross-Domain Communication Protocols

### Design Change Notification

When a PRD changes, the product-designer must notify:
- feature-developer (implementation impact)
- qa-lead (test plan update needed)
- project-manager (schedule impact assessment)
- Relevant platform specialists depending on the change

### Architecture Change Notification

When an ADR is created or modified, the technical-lead must notify:
- app-architecture-specialist (code changes needed)
- All affected feature developers
- qa-lead (testing strategy may change)
- project-manager (schedule impact)

### Platform-Specific Change Notification

When a platform-specific implementation changes, the platform specialist must notify:
- flutter-specialist (Flutter integration impact)
- ui-engineer (cross-platform UI consistency)
- qa-lead (testing coverage update)

## Anti-Patterns to Avoid

1. **Bypassing the hierarchy**: A specialist agent should never make decisions
   that belong to their lead without consultation.
2. **Cross-domain implementation**: An agent should never modify files outside
   their designated area without explicit delegation from the relevant owner.
3. **Shadow decisions**: All decisions must be documented. Verbal agreements
   without written records lead to contradictions.
4. **Monolithic tasks**: Every task assigned to an agent should be completable
   in 1-3 days. If it is larger, it must be broken down first.
5. **Assumption-based implementation**: If a spec is ambiguous, the implementer
   must ask the specifier rather than guessing. Wrong guesses are more expensive
   than a question.
