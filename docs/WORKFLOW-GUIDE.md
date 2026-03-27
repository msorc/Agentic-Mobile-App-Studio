# Agentic Mobile App Studio -- Complete Workflow Guide

> **How to go from zero to a shipped cross-platform mobile app using the Agent Architecture.**
>
> This guide walks you through every phase of Flutter app development using the
> 24-agent system, 28 slash commands, and automated hooks. It assumes you
> have Claude Code installed, Flutter SDK configured, and are working from the project root.

---

## Table of Contents

1. [Phase 0: Setup & Configuration](#phase-0-setup--configuration)
2. [Phase 1: Ideation & Concept](#phase-1-ideation--concept)
3. [Phase 2: Pre-Production & Design](#phase-2-pre-production--design)
4. [Phase 3: Prototyping & Validation](#phase-3-prototyping--validation)
5. [Phase 4: Production Sprint Workflow](#phase-4-production-sprint-workflow)
6. [Phase 5: Implementation Deep-Dive](#phase-5-implementation-deep-dive)
7. [Phase 6: Testing & Quality Assurance](#phase-6-testing--quality-assurance)
8. [Phase 7: Polish & Optimization](#phase-7-polish--optimization)
9. [Phase 8: Localization & Accessibility](#phase-8-localization--accessibility)
10. [Phase 9: Release & Launch](#phase-9-release--launch)
11. [Phase 10: Post-Launch & Live Ops](#phase-10-post-launch--live-ops)
12. [Tips for Getting the Most Out of the System](#tips-for-getting-the-most-out-of-the-system)
13. [Appendix A: Agent Quick-Reference](#appendix-a-agent-quick-reference)
14. [Appendix B: Slash Command Quick-Reference](#appendix-b-slash-command-quick-reference)
15. [Appendix C: Common Workflows](#appendix-c-common-workflows)

---

## Phase 0: Setup & Configuration

### What You Need

Before you start, make sure you have:

- **Claude Code** installed and working
- **Flutter SDK 3.x** installed and configured
- **Git** with Git Bash (Windows) or standard terminal (Mac/Linux)
- **Xcode** (for iOS builds, macOS only)
- **Android Studio** or **VS Code** with Flutter extensions
- **jq** (optional but recommended -- hooks fall back to `grep` if missing)

### Step 0.1: Clone and Configure

Clone the repository and open it in your editor:

```bash
git clone <repo-url> my-app
cd my-app
```

### Step 0.2: Run /start (Recommended for New Users)

If you're new to the project or don't yet know what app you're building:

```
/start
```

This guided onboarding asks where you are (no idea, vague idea, clear concept,
existing work) and routes you to the right phase. Skip this if you already have
an app concept and platform targets.

### Step 0.3: Define Your Target Platforms

Run `/project-stage-detect` to analyze your project and identify what's configured:

```
/project-stage-detect
```

This helps you confirm which platforms you're targeting:
- **iOS** (requires macOS with Xcode)
- **Android** (requires Android SDK)
- **Web** (requires Chrome for debugging)
- **Windows**, **macOS**, **Linux** (desktop targets)

### Step 0.4: Verify Hooks Are Working

Start a new Claude Code session. You should see output from the
`session-start.sh` hook:

```
=== Agentic Mobile App Studio -- Session Context ===
Branch: main
Recent commits:
  abc1234 Initial commit
===================================
```

If you see this, hooks are working. If not, check `.claude/settings.json` to
make sure the hook paths are correct for your OS.

### Step 0.5: Create Your Directory Structure

The directories listed in `CLAUDE.md` don't all exist yet. Create them as
needed -- the system expects this Flutter Clean Architecture layout:

```
lib/
  core/                  # Shared utilities, constants, extensions, themes
    constants/
    extensions/
    utils/
    errors/
  features/              # Feature modules (self-contained)
    auth/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
    profile/
    settings/
    ...
  shared/                # Shared widgets, services, providers
    widgets/
    providers/
    services/
test/                    # Unit and widget tests
  unit/
  widget/
integration_test/        # Integration tests
docs/                    # Technical documentation
  architecture/          # Architecture Decision Records
production/              # Sprint plans, milestones, releases
  sprints/
  milestones/
  releases/
```

> **Tip:** You don't need all of these on day one. Create feature directories as you
> reach the phase that needs them. The important thing is to follow Clean Architecture
> when you do create them, because the **rules system** enforces standards based on
> file paths. Code in `lib/features/` gets feature-module rules, code in `lib/shared/`
> gets reusability rules.

---

## Phase 1: Ideation & Concept

### What Happens in This Phase

You go from "no idea" or "vague idea" to a structured app concept document.
This is where you figure out **what** you're making.

> **Tip:** If you ran `/start` in Phase 0 and chose Path A or B, you're already
> here. `/start` routes you to `/feature-brainstorm` automatically.

### Step 1.1: Brainstorm With `/feature-brainstorm`

This is your starting point if you skipped `/start`. Run the brainstorm skill:

```
/feature-brainstorm
```

Or with a domain hint:

```
/feature-brainstorm social networking
```

**What happens:** The brainstorm skill guides you through a collaborative ideation process:

Agent: "Let's explore app concepts. What domain or theme interests you? (Optional,
       or leave blank for open exploration)"

User: "Fitness tracking"

Agent: "I've generated concept seeds combining fitness tracking with engaging UX patterns.
       Here are the top 3:

       **Concept A: StreakFlow** - Habit tracking with visual streaks and social accountability
       **Concept B: RepCounter Pro** - Workout logging with automatic rep counting via sensors
       **Concept C: RecoveryMap** - Recovery tracking with fatigue monitoring and recommendations

       Which concept(s) would you like me to develop further?"

User: "Concept A sounds promising"

Agent: [Performs feature analysis, audience mapping, competitive analysis,
       showing work at each stage and asking for feedback]

       "Here's the complete analysis. Should I formalize this into a structured
       concept document?"

User: "Yes"

Agent: [Creates structured concept document with top ideas, target audience,
       core flows, and unique value proposition]

### Step 1.2: Document the Winning Concept

Take the brainstorm output and formalize it. Use the **Product Requirements Document** template:

```
Ask Claude to create a PRD using the template at
.claude/docs/templates/product-requirements-doc.md
```

This template includes:
- Elevator pitch (one sentence)
- Target users (demographics, pain points)
- Core features (MVP vs nice-to-have)
- Success metrics
- Comparable apps and differentiation

### Step 1.3: Define Your App Pillars

Before you go further, lock in your **app pillars** -- the 3-5 non-negotiable
design values that guide every decision.

Example pillars:
- **Offline-First**: Core features work without internet
- **Privacy by Design**: Data stays on device unless explicitly shared
- **Accessible by Default**: WCAG AA compliance built in

Also define **anti-pillars** -- things your app intentionally avoids:
- We do NOT pursue: aggressive monetization, dark patterns, data selling

> **When you're happy with your concept and pillars, you're ready for
> Pre-Production.**

---

## Phase 2: Pre-Production & Design

### What Happens in This Phase

You create all the design documents that define how your app works. Nothing
gets coded yet -- this is pure design and architecture.

### Step 2.1: Decompose Your Concept Into Features

Before writing individual specs, enumerate all the features your app needs:

```
/map-systems
```

This creates a feature index document — a master tracking document that:

- Lists every feature your app needs (auth, notifications, settings, etc.)
- Maps dependencies between features
- Assigns priority tiers (MVP, Vertical Slice, Beta, Full Vision)
- Determines design order

Then design each feature in dependency order:

```
/map-systems next
```

This picks the highest-priority undesigned feature and hands off to `/design-system`,
which guides you through creating its spec section by section. Each completed spec
goes through `/design-review` before the next starts.

You can also write a specific feature's spec directly:

```
/design-system auth
```

### Step 2.2: Create Feature Specifications

For each major feature in your app, create a design document. Use the template:

```
Ask Claude to create a feature spec using the template at
.claude/docs/templates/feature-spec.md
```

**Every feature spec should have these sections:**

| # | Section | What Goes Here |
|---|---------|----------------|
| 1 | **Overview** | One-paragraph summary of the feature |
| 2 | **User Flow** | Step-by-step user journey through the feature |
| 3 | **Data Model** | What data the feature owns, creates, or modifies |
| 4 | **API Contracts** | How the feature communicates with backend/services |
| 5 | **State Management** | How UI state is managed (Riverpod, Bloc, etc.) |
| 6 | **Edge Cases** | What happens in weird situations? Explicitly resolved. |
| 7 | **Dependencies** | What other features this connects to (bidirectional) |
| 8 | **Acceptance Criteria** | How do you test that this works? Specific, measurable. |

### Step 2.3: Use the Product Designer Agent for Complex Features

For features that need deep UX thinking, delegate to `product-designer`:

```
Ask the product-designer agent to design a onboarding flow that
converts well without being intrusive. Should feel helpful, not
like a paperwork gauntlet.
```

**What happens:** The `product-designer` agent collaborates with you to create the design:

Agent: "I'll help design the onboarding flow. First, some questions:
       - How many screens is too many? (industry standard is 3-5)
       - What data do you absolutely need vs. what's nice-to-have?
       - Do you need social/login options? Which providers?
       - Should returning users ever see onboarding again?"

User: "Max 4 screens. Need email, name, optional profile photo. Google + Apple login.
      Returning users should never see it again."

Agent: "Based on that, here are three flow approaches:

       **Option A: Linear** - 4 screens, one per piece of data
       Pros: Simple, clear progress
       Cons: Can feel tedious if users just want to get in

       **Option B: Progressive** - Start with minimal (email only), request more later
       Pros: Faster initial entry, builds trust
       Cons: May interrupt users later

       **Option C: Hybrid** - Quick 2-screen core, optional profile setup after first login
       Pros: Fast entry, optional depth
       Cons: More complex to implement

       I recommend Option C -- it respects user time while allowing personalization.
       Which approach fits your vision?"

User: "Option C sounds perfect"

Agent: [Drafts feature spec sections iteratively, showing each and incorporating feedback]

       "Spec draft ready. The acceptance criteria include time-to-complete benchmarks
       and completion rate targets based on industry data.

       May I write this to lib/features/auth/docs/onboarding-spec.md?"

User: "Yes"

Agent: [Writes file]

### Step 2.4: Design Review

Before any spec goes to programmers, run a review:

```
/design-review lib/features/auth/docs/onboarding-spec.md
```

**What happens:** The skill checks the document against the 8-section
standard, verifying:
- Are all sections present and complete?
- Are acceptance criteria testable and measurable?
- Do dependencies list both directions?
- Is the state management approach appropriate?

Fix any issues flagged before proceeding.

### Step 2.5: Technical Architecture

Before coding starts, make key technical decisions:

```
/architecture-decision "Riverpod vs Bloc for state management"
```

**What happens:** The skill guides you through creating an Architecture Decision Record:

Agent: "I'll help document this architectural decision. First, let me understand
       the context. What's driving this decision right now?"

User: "We need to choose state management for a medium-complexity app with
      real-time updates. Team is 2 developers."

Agent: "Given medium complexity with real-time needs and a small team, here's my analysis:

       **Option A: Riverpod**
       Pros: Compile-safe, testable, less boilerplate, excellent for reactive streams
       Cons: Newer ecosystem, smaller community than Bloc

       **Option B: Bloc**
       Pros: Strict pattern, great for complex flows, large community
       Cons: More boilerplate, events/states can be verbose

       **Option C: Cubit (simplified Bloc)**
       Pros: Easier than Bloc, still testable
       Cons: Less structure for complex real-time scenarios

       For a small team with real-time needs, I recommend Riverpod -- it scales
       well and reduces boilerplate without sacrificing testability.

       Should I create an ADR documenting this decision?"

User: "Yes, go with Riverpod"

Agent: [Creates ADR in docs/architecture/ with context, decision drivers,
       all options with pros/cons, chosen option with rationale, and consequences]

**For complex architectural decisions, use the `technical-lead` agent:**

```
Ask the technical-lead agent to evaluate whether we should use
Clean Architecture with repository pattern or a simpler layered
architecture for our app, considering our team size (solo) and
app complexity (10 features).
```

Agent: "Let me analyze the architecture decision for your context:

       [Performs detailed analysis considering team size, app complexity,
       maintainability, testability needs]

       **Recommendation: Clean Architecture with repository pattern**

       Reasoning: [Detailed rationale]

       Shall I create an ADR documenting this decision with full analysis?"

User: "Yes"

Agent: [Creates comprehensive ADR]

### Step 2.6: Milestone Planning

Define your project milestones using the template:

```
Ask Claude to create a milestone definition using the template at
.claude/docs/templates/milestone-definition.md
```

Typical mobile app milestones:
1. **Proof of Concept** -- One feature end-to-end, validates architecture
2. **MVP** -- Core features functional, placeholder UI acceptable
3. **Beta** -- All features in, polishing begins, external testers
4. **Release Candidate** -- Bug fixes only, ready for store submission
5. **Gold** -- Ship it

> **When all your design documents are reviewed and your architecture is
> decided, you're ready to start building.**

---

## Phase 3: Prototyping & Validation

### What Happens in This Phase

Before committing to full production, you validate risky or uncertain
features with throwaway prototypes. This saves weeks of wasted production
effort.

### Step 3.1: Identify What Needs Prototyping

Not everything needs a prototype. Prototype when:
- A UX pattern is novel and you're not sure users will understand it
- A technical approach is risky and you're not sure it's feasible
- Two design options both seem viable and you need to see the difference

### Step 3.2: Run the Prototype Skill

```
/prototype "gesture-based navigation with fluid transitions"
```

**What happens:** The skill collaborates with you to set up the prototype:

Agent: "Let's prototype the gesture navigation. First, let me clarify the
       hypothesis we're testing:

       - Are we testing if swipe gestures feel natural?
       - Or testing technical feasibility of custom transitions?
       - Or comparing different gesture schemes?

       What's the core question this prototype needs to answer?"

User: "Testing if swipe-from-edge navigation feels intuitive vs button taps"

Agent: "Got it. Here's my proposed setup:

       **Hypothesis**: Edge-swipe navigation will feel faster and more natural
       than button taps for users already familiar with mobile conventions

       **Success Criteria**:
       - Users complete navigation tasks 20% faster with gestures
       - Error rate (wrong direction, failed gesture) under 5%
       - Users report preference for gesture over button in feedback

       **Prototype Scope** (1-2 hours max):
       - 3-screen mock app with gesture navigation enabled
       - Identical app with button navigation for comparison
       - No backend, no real data - just UI flow

       Does this match what you want to validate?"

User: "Perfect, but add one more criteria: can we do back-swipe from any edge"

Agent: "Updated success criteria to include universal back-swipe. Should I create
       prototypes/gesture-nav/ and implement this?"

User: "Yes"

Agent: [Creates directory structure, README with hypothesis/criteria/status,
       implements minimal prototype using Flutter Navigator 2.0]

**Key rule:** Prototypes intentionally relax coding standards -- hardcoded values OK,
no tests required, but README with hypothesis and findings is mandatory.

### Step 3.3: Evaluate the Prototype

Test the prototype and answer:
- Does the hypothesis hold? Is it usable / feasible / better?
- What surprised you?
- What would change for production?

Update the prototype README with findings and a **verdict**: Ship It, Rework,
or Kill It.

---

## Phase 4: Production Sprint Workflow

### What Happens in This Phase

This is the core production loop. You work in sprints (typically 1-2 weeks),
implementing features, fixing bugs, and tracking progress. This phase repeats
until your app is feature-complete.

### Step 4.1: Create Your First Sprint

```
/sprint-plan new
```

**What happens:** The skill delegates to `project-manager` to collaborate on sprint planning:

Agent: "Let's plan your sprint. First, what's your primary goal for this sprint?
       (One sentence that defines success)"

User: "Implement authentication flow with email and social login"

Agent: "How much time do you have available this sprint? (hours or days)"

User: "20 hours over 2 weeks"

Agent: "Based on 'authentication flow' I'm breaking this into tasks. Here's my
       proposed structure:

       **Must Have** (sprint fails without these):
       - Email/password sign-up and sign-in
       - Session management (secure token storage)
       - Logout functionality
       - Basic error handling (invalid email, wrong password)

       **Should Have** (important but can slip):
       - Google sign-in
       - Apple sign-in (iOS)
       - Password reset flow
       - Remember me functionality

       **Nice to Have** (if time permits):
       - Biometric authentication
       - Social sharing after sign-up

       **Risks I see**:
       - Platform-specific OAuth requires platform-specialist review
       - Secure storage needs security-engineer sign-off

       Does this task breakdown match your vision? Any tasks to add/remove/reprioritize?"

User: "Move biometric auth to Should Have - it's important for app feel"

Agent: "Updated. Should I create production/sprints/sprint-01.md with this plan?"

User: "Yes"

Agent: [Creates sprint plan with goal, categorized tasks, capacity estimate,
       risk register, and dependencies]

### Step 4.2: The Daily Work Loop

Each session follows this pattern:

```
1. Start a Claude Code session
   (session-start hook shows branch, sprint status, recent commits)

2. Pick a task from the sprint plan
   ("I'm working on the email sign-in flow")

3. Claude identifies the right agent(s) to help
   - feature-developer for implementation
   - ui-engineer for widget implementation
   - platform-specialist for platform-specific code

4. Implement the feature (see Phase 5 for details)

5. Write tests (verification-driven development)

6. Commit your work
   (validate-commit hook checks for hardcoded secrets,
    valid JSON data, no debug prints in production)

7. Repeat until the session's context is getting full (~65-70%)

8. /clear to start fresh, or compact to continue
```

### Step 4.3: Sprint Tracking

Check on sprint progress anytime:

```
/sprint-plan status
```

If scope is growing:

```
/scope-check production/sprints/sprint-03.md
```

This compares current scope against the original plan and flags:
- Tasks added since sprint start
- Scope increase percentage
- Recommendations for what to cut

### Step 4.4: Sprint Review & Retrospective

At the end of a sprint:

```
/retrospective
```

This analyzes:
- What was planned vs. what was completed
- Velocity (tasks/points completed)
- What went well
- What went poorly
- Blockers encountered
- Actionable improvements for next sprint

Then plan the next sprint:

```
/sprint-plan new
```

The new sprint incorporates carry-over tasks, retrospective learnings, and
updated priorities.

### Step 4.5: Milestone Reviews

At milestone checkpoints:

```
/milestone-review "beta"
```

This produces a comprehensive report:
- Feature completeness percentage
- Quality metrics (bug counts, test coverage)
- Risk assessment
- Go/no-go recommendation
- Action items to reach the milestone

---

## Phase 5: Implementation Deep-Dive

### What Happens in This Phase

This is where code gets written. The agent system ensures code quality through
path-specific rules, automated hooks, and structured delegation.

### Step 5.1: Single-Feature Implementation

For a single feature (e.g., "implement the sign-in flow"):

```
Ask the feature-developer agent to implement the email sign-in
feature as specified in lib/features/auth/docs/sign-in-spec.md.
Use Riverpod for state management and follow Clean Architecture.
```

**What happens:** The `feature-developer` agent collaborates on implementation:

Agent: "I've read lib/features/auth/docs/sign-in-spec.md. Before implementing, I need to
       clarify a few details:

       Section 3 shows the user entity structure. Questions:
       - Should we validate email format on the client, server, or both?
       - Where should tokens be stored -- secure storage or shared preferences?
       - Do you want auto-login if a valid token exists?

       Also, I notice the spec doesn't cover error state mapping. Should I
       define error states (network error, invalid credentials, account locked)?"

User: "Validate on both client and server. Use flutter_secure_storage for tokens.
      Yes to auto-login if valid token exists. Define error states too."

Agent: "Got it. Here's my implementation approach:

       **Files to create**:
       - lib/features/auth/data/datasources/auth_remote_datasource.dart
       - lib/features/auth/data/datasources/auth_local_datasource.dart
       - lib/features/auth/data/models/user_model.dart
       - lib/features/auth/data/repositories/auth_repository_impl.dart
       - lib/features/auth/domain/repositories/auth_repository.dart
       - lib/features/auth/domain/entities/user.dart
       - lib/features/auth/presentation/bloc/auth_bloc.dart
       - lib/features/auth/presentation/pages/sign_in_page.dart

       **Architecture**:
       - Clean Architecture layers (data → domain → presentation)
       - Repository pattern (abstract in domain, impl in data)
       - Riverpod for state management
       - flutter_secure_storage for token persistence

       May I proceed with implementation?"

User: "Yes"

Agent: [Implements with automatic rule enforcement -- Clean Architecture layers,
       dependency injection, proper error handling]

       "Implementation complete. Files created:

       lib/features/auth/
         data/
           datasources/auth_remote_datasource.dart
           datasources/auth_local_datasource.dart
           models/user_model.dart
           repositories/auth_repository_impl.dart
         domain/
           entities/user.dart
           repositories/auth_repository.dart
         presentation/
           bloc/auth_bloc.dart
           bloc/auth_event.dart
           bloc/auth_state.dart
           pages/sign_in_page.dart
           widgets/email_input.dart
           widgets/password_input.dart

       Ready for testing. Should I draft unit tests?"

User: "Yes"

Agent: [Writes tests]

### Step 5.2: Multi-Feature Feature (Team Orchestration)

For features that span multiple domains, use a team skill:

```
/team-ui "settings screen with notifications, privacy, and appearance options"
```

**What happens:** The team skill orchestrates collaborative 6-phase development:

**Phase 1 - Design**:
Agent (mobile-ux-specialist): "I'll design the settings screen. Questions:
       - Should settings use grouped sections or a flat list?
       - What notification categories should users control?
       - Appearance options -- theme only, or font size too?
       - How detailed should privacy controls be?"

User: [Answers questions]

Agent: [Creates design spec, shows draft] "Design ready. Approve to proceed to architecture?"

User: "Approved"

**Phase 2 - Architecture**:
Agent (app-architecture-specialist): "Here's my proposed structure:
       - SettingsFeature with sub-features: Notifications, Privacy, Appearance
       - Each sub-feature as its own BLoC/Riverpod provider
       - Shared settings repository for persistence

       This work or want changes?"

User: "Approved"

**Phase 3 - Parallel Implementation**:
Agent (coordinator): "Starting parallel implementation:
       - feature-developer: Notifications settings BLoC + UI
       - feature-developer: Privacy settings BLoC + UI
       - ui-engineer: Appearance settings (theme switching)

       I'll check back when all are complete."

[Each specialist asks clarifying questions and shows their work before finalizing]

**Phase 4 - Integration**:
Agent (feature-developer): "All components ready. Integrating now..."
       [Shows integrated result] "Working in test app. Ready for validation?"

**Phase 5 - Validation**:
Agent (qa-tester): "Testing against acceptance criteria from spec..."
       [Reports results] "Edge case found: theme changes don't persist after app restart.
       Should we fix or defer?"

User: "Fix it"

**Phase 6 - Report**:
Agent (coordinator): "Feature complete. Status:
       ✓ Design, architecture, implementation, integration done
       ✓ Edge case fixed
       Ready to merge."

### Step 5.3: Platform-Specific Work

When you need platform-specific expertise:

```
# For iOS-specific behavior:
Ask the ios-specialist agent to review our push notification
implementation and suggest improvements for APNs integration.

# For a specific subsystem:
Ask the android-specialist agent to implement background
location updates following Android 14+ requirements.
```

Platform specialists know:
- Platform-specific patterns and anti-patterns
- Store guidelines (App Store, Google Play)
- Native API integration
- Platform version compatibility

### Step 5.4: Architecture Decision Records

When you face a significant technical choice during implementation:

```
/architecture-decision "Local database: Drift vs Hive vs ObjectBox"
```

This documents the decision so future-you (or future contributors) understands
*why* things were built this way.

### Step 5.5: Code Review

After implementing a feature:

```
/code-review lib/features/auth/data/repositories/auth_repository_impl.dart
```

**What happens:** The skill performs collaborative architectural review:

Agent: "Reviewing auth_repository_impl.dart...

       **Architectural Compliance**:
       ✓ Clean Architecture (data layer properly isolated)
       ✓ Error handling with Result type

       **SOLID Principles**:
       ✓ Single Responsibility - only handles auth data operations
       ⚠ Warning: Repository depends on multiple datasources - consider facade pattern

       **Testability**:
       ✓ Dependencies injected via constructor
       ✗ Missing unit tests for token refresh logic

       **Security**:
       ✓ Secrets not logged
       ✓ Token cleared on logout

       **Recommendations**:
       1. HIGH: Add unit tests for token refresh
       2. MEDIUM: Consider datasource facade for multiple sources
       3. LOW: Add debug flag for development token inspection

       Should I show you how to fix issue #1 (add unit tests)?"

User: "Yes, show me"

Agent: [Shows test code]

       "These tests cover the happy path and error cases.
       Approve adding these to the test suite?"

User: "Approved"

Agent: [Applies changes] "Code review complete. All high-priority issues resolved."

---

## Phase 6: Testing & Quality Assurance

### What Happens in This Phase

Testing runs throughout production, not just at the end. The system supports
test-driven development with automated enforcement.

### Step 6.1: Write Tests First (Verification-Driven Development)

The project enforces **verification-driven development**: write tests before
or alongside implementation, not after.

```
Ask the qa-tester agent to write test cases for the auth repository
based on the acceptance criteria in lib/features/auth/docs/sign-in-spec.md.
```

**What happens:** The `qa-tester` agent collaborates on test case creation:

Agent: "I've read the acceptance criteria from the sign-in spec. Before
       writing tests, let me confirm the test scope:

       From the acceptance criteria, I see:
       - Valid email/password signs in successfully
       - Invalid email shows validation error
       - Wrong password shows error message
       - Network error shows retry option

       Questions:
       - Should I include integration tests with a mock server or just unit tests?
       - Do you want performance tests (e.g., sign-in completes < X seconds)?
       - Any specific edge cases beyond those in the doc?"

User: "Unit tests with mocked datasources. Performance test - sign-in < 2 seconds.
      Also test what happens with expired token on auto-login."

Agent: "Got it. Here's my test plan:

       **Unit Tests**:
       - test_sign_in_success (valid credentials)
       - test_sign_in_invalid_email (email validation)
       - test_sign_in_wrong_password (error message)
       - test_sign_in_network_error (retry option)
       - test_auto_login_with_valid_token (session persistence)
       - test_auto_login_with_expired_token (graceful fallback)

       **Performance Test**:
       - test_sign_in_completes_under_2_seconds

       Approve this test suite?"

User: "Yes"

Agent: [Writes tests following Flutter testing best practices]

       "Test suite complete. All 7 tests written. Ready to run?"

### Step 6.2: Bug Reporting

When you find a bug:

```
/bug-report "Sign-in button stays disabled after typing valid email"
```

This creates a structured bug report with:
- Severity (Critical / Major / Minor / Cosmetic)
- Priority (P0-P4)
- Steps to reproduce
- Expected vs actual behavior
- System/component affected
- Related spec

### Step 6.3: Test Planning

For milestone validation:

```
Ask the qa-lead agent to create a test plan for the MVP milestone,
covering auth, settings, and core user flows.
```

**What happens:** The `qa-lead` agent collaborates on comprehensive test planning:

Agent: "I'll create a test plan for the MVP milestone. First, let me understand
       the scope:

       From the milestone definition, I see these features are in scope:
       - Authentication (email, Google, Apple)
       - Settings (notifications, privacy, appearance)
       - Core user flows

       Questions:
       - What platforms are we testing? (iOS, Android, Web?)
       - What devices/form factors? (phones, tablets?)
       - What's our target performance? (app launch < 3 seconds?)
       - Timeline - when does testing need to complete?"

User: "iOS and Android. Phones only. App launch under 3 seconds.
      Testing deadline is end of next week."

Agent: "Got it. Here's my proposed test plan structure:

       **Functional Tests** (3 days):
       - Auth: Sign-up, sign-in, logout, password reset, social login
       - Settings: All options save correctly, theme changes apply
       - Core flows: Navigation, data persistence

       **Edge Case Tests** (1 day):
       - Network transitions (wifi → cellular)
       - App backgrounded during auth
       - Token expiry during session

       **Regression Suite** (1 day):
       - Re-run all previous milestone tests

       **Performance Tests** (1 day):
       - Cold start under 3 seconds
       - Memory under 200MB
       - APK/app bundle size under 50MB

       **Platform Tests** (1 day):
       - iOS 16+ (latest)
       - Android 13+ (latest)

       This fits the timeline. Approve or adjust?"

User: "Approved"

Agent: [Creates detailed test plan]

### Step 6.4: Accessibility Testing

After implementing UI:

```
/code-review lib/features/auth/presentation/pages/sign_in_page.dart
```

The code-review skill includes accessibility checks:
- All images have semantic labels
- Touch targets are at least 48x48dp
- Color contrast meets WCAG AA
- Screen reader support with Semantics widgets

---

## Phase 7: Polish & Optimization

### What Happens in This Phase

Your app is feature-complete. Now you make it *good*. This phase focuses on
performance, visual polish, and platform-specific polish.

### Step 7.1: Performance Profiling

```
/perf-profile
```

**What happens:** The skill guides you through structured performance profiling:

Agent: "Starting performance profiling. First, let's establish your targets:
       - Target cold start time?
       - Target memory limit?
       - Target platforms?"

User: "Cold start under 3 seconds. Memory under 200MB. iOS and Android."

Agent: "Running profiler on current build...

       **Current Performance**:
       - Cold start: 4.2s (target: 3s) - OVER BUDGET
       - Memory: 180MB (within target)
       - Widget build time: 16ms average

       **Bottlenecks Identified** (ranked by impact):
       1. Auth initialization: 1.8s (43% of startup) - HIGH PRIORITY
       2. Theme loading: 0.8s (19% of startup) - MEDIUM
       3. Font loading: 0.6s (14% of startup) - MEDIUM

       **Recommendations**:
       1. Auth: Defer initialization until after first frame
       2. Theme: Load from cached preferences instead of disk
       3. Fonts: Use GoogleFonts with caching

       Should I generate detailed optimization tasks for all 3 issues?"

User: "Yes"

Agent: [Generates actionable optimization tasks with code locations and expected gains]

**For deeper analysis, use the `performance-analyst` agent:**

```
Ask the performance-analyst agent to analyze our list scrolling
performance. We're seeing jank when loading images in a long list.
```

Agent: "I'll analyze the list performance. Let me profile with image-heavy content...

       **Analysis Results**:
       - 50 items: Smooth 60fps
       - 100 items: Occasional drops to 45fps
       - 200 items: Consistent jank at 30fps

       **Root Cause**: Images decoded on main thread, no caching.

       **Solution Options**:
       1. Use cached_network_image with preloading
       2. Implement lazy loading with ListView.builder
       3. Add image compression

       I recommend Option 1 + 2: cached_network_image with proper list construction.
       Expected gain: 30fps -> 58fps

       Should I show you the implementation?"

User: "Yes"

Agent: [Shows optimized implementation]

### Step 7.2: Visual Polish

Use the team polish skill for comprehensive polishing:

```
/team-polish "sign-in screen"
```

**What happens:** The team polish skill coordinates collaborative polish passes:

Agent (coordinator): "Starting polish pass for sign-in screen. Let me assess
       current state and identify polish priorities...

       **Current State Analysis**:
       - Functionality: Complete
       - Visual polish: Basic Material widgets, no custom styling
       - Accessibility: Missing some labels
       - Error states: Functional but generic

       I'll coordinate 3 specialists. First, let me get your polish
       priorities - rank these:
       - Visual polish (custom styling, animations)
       - Accessibility (labels, contrast, touch targets)
       - Error handling (helpful messages, recovery options)"
       - Performance (startup time, responsiveness)

User: "Accessibility #1, then visual polish, then error handling"

**Phase 1 - Accessibility** (accessibility-specialist):
Agent: "Auditing sign-in screen for accessibility...
       - Missing semantic labels on icons
       - Password field needs a11y guide
       - Error messages should use both color AND icon

       Fixing now..."

**Phase 2 - Visual Polish** (ui-engineer):
Agent: "Adding custom styling to match brand guidelines.
       - Custom text styles
       - Branded button styling
       - Subtle animations on focus

       Testing feel..."

**Phase 3 - Error Handling** (feature-developer):
Agent: "Improving error messages to be more helpful.
       - 'Invalid email' -> 'Please enter a valid email address'
       - Network error shows illustration + retry button

       Testing..."

Agent (coordinator): "Polish pass complete:
       ✓ Accessibility: All WCAG AA criteria met
       ✓ Visual: Branded styling with smooth animations
       ✓ Errors: Helpful messages with recovery options
       Ready to merge."

### Step 7.3: Platform-Specific Polish

For platform-specific polish (iOS notch, Android edge-to-edge, etc.):

```
Ask the ios-specialist agent to audit our app for iOS-specific
polish: notch handling, safe area compliance, and iOS-native feel.
```

Agent: "I'll audit for iOS polish. Key checks:
       - SafeArea widget used correctly
       - Notch/Dynamic Island handled
       - iOS-style navigation transitions
       - Native-feeling scroll physics

       Findings:
       ⚠ SafeArea not applied to root scaffold
       ⚠ Using default Material transitions instead of iOS-style
       ✓ Scroll physics correct

       Should I fix these issues?"

User: "Yes"

Agent: [Applies iOS-specific polish fixes]

### Step 7.4: Technical Debt

Before release, assess your tech debt:

```
/tech-debt
```

This scans the codebase for:
- TODO/FIXME/HACK comments
- Code duplication
- Overly complex functions
- Missing tests
- Outdated dependencies

Each debt item gets categorized and prioritized. You decide what to fix
before release vs. what to defer.

---

## Phase 8: Localization & Accessibility

### Step 8.1: Localization Scan

```
/localize lib/
```

This scans for:
- Hardcoded strings that should be externalized
- String concatenation that breaks translation
- Text that doesn't account for expansion (German text is ~30% longer)
- Missing locale files
- Pluralization issues

### Step 8.2: Accessibility Review

```
Ask the accessibility-specialist agent to audit our app for
WCAG compliance, screen reader compatibility, and input accessibility.
```

The `ui-code` rule already enforces some accessibility:
- Localization-ready strings (no hardcoded text)
- Semantic labels on interactive elements
- Touch targets at least 48x48dp
- Color contrast considerations

The `accessibility-specialist` goes deeper:
- Screen reader compatibility (TalkBack, VoiceOver)
- Motion sensitivity (reduce motion support)
- Text scaling support (text respects system font size)
- Focus management for keyboard navigation

---

## Phase 9: Release & Launch

### What Happens in This Phase

Your app is polished, tested, and ready. Now you ship it to the app stores.

### Step 9.1: Release Checklist

```
/release-checklist v1.0.0
```

This generates a comprehensive pre-release checklist covering:
- Build verification (all platforms compile and run)
- Store certification requirements (App Store, Google Play)
- Store metadata (descriptions, screenshots, keywords)
- Legal compliance (privacy policy, terms of service)
- Accessibility documentation

### Step 9.2: Launch Readiness (Full Validation)

```
/launch-checklist
```

This is the complete cross-department validation:

| Department | What's Checked |
|-----------|---------------|
| **Engineering** | Build stability, crash rates, memory leaks, load times |
| **Design** | Feature completeness, UI consistency, brand compliance |
| **QA** | Open bug count by severity, regression suite pass rate |
| **Platform** | iOS/Android/Web store compliance |
| **Accessibility** | WCAG AA compliance, assistive feature testing |
| **Localization** | All strings translated, no truncation, locale testing |
| **Legal** | Privacy policy, terms of service, store-specific requirements |
| **Store** | Metadata complete, screenshots approved, pricing set |

Each item gets a **Go / No-Go** status. All must be Go to ship.

### Step 9.3: Generate Release Content

```
/patch-notes v1.0.0
```

Generates user-friendly release notes from git history and internal data.
Translates developer language ("refactored auth module") into user
language ("improved sign-in reliability").

```
/changelog v1.0.0
```

Generates an internal changelog (more technical, for the team).

### Step 9.4: Coordinate the Release

```
/team-release
```

**What happens:** The team release skill coordinates all departments for launch:

**Phase 1 - Pre-Release Validation** (release-manager):
Agent: "Starting release coordination for v1.0.0. First, status check across
       all departments...

       Reviewing launch checklist results:
       ✓ Engineering: All green
       ✓ QA: 2 minor bugs open (non-blocking)
       ✓ Accessibility: Complete
       ✓ Localization: 3 languages ready, 1 pending
       ⚠ Store: App Store screenshots pending approval
       ⚠ Play Store: Privacy policy URL not verified

       Two items need attention. Timeline impact?"

User: "Screenshots approved this morning. Privacy policy will be ready today."

Agent: "Got it. Updated timeline: Release tomorrow pending policy completion.
       Should I proceed with build preparation?"

User: "Yes"

**Phase 2 - Build Management** (release-manager):
Agent: "Creating release builds v1.0.0...
       - iOS: ✓ Built for App Store, 45MB
       - Android: ✓ Built for Play Store, 38MB
       - Web: ✓ Built, deployed to staging
       - Checksums generated
       - Version manifest created

       All builds ready for deployment."

**Phase 3 - Final QA Sign-Off** (qa-lead):
Agent: "Running final regression suite on release builds...
       - All critical tests: ✓ Pass
       - All major tests: ✓ Pass (2 minor edge cases documented)
       - Performance benchmarks: ✓ Met

       **QA Sign-Off: APPROVED**

       Ready for store submission."

**Phase 4 - Store Submission** (release-manager):
Agent: "Submitting to stores...
       - App Store Connect: Submitted ✓
       - Google Play Console: Submitted ✓

       **Status**: Under review by both stores.
       Typical review times: 24-48 hours (App Store), 2-7 days (Play Store).

       I'll monitor for any issues and alert you on review completion."

---

## Phase 10: Post-Launch & Live Ops

### What Happens in This Phase

Your app is live. Now you monitor, iterate, and maintain it. This phase runs
indefinitely after launch, covering analytics, bug fixes, store management,
and feature updates.

### Step 10.1: Monitor Crash Reporting and Analytics

Set up automated monitoring:

```
Ask the analytics-engineer agent to review our crash reporting setup
and verify we have alerts configured for critical crash thresholds.
```

**What to monitor daily:**
- Crash rate (target: < 1% for all users, < 0.1% for Fabric/crashlytics severity)
- ANR rate (Android Application Not Responding, target: < 0.1%)
- Session duration trends
- Feature adoption funnels
- User retention curves (Day 1, Day 7, Day 30)

**What to do weekly:**
- Review top crash signatures
- Check for regressions from new releases
- Monitor app store rating trends

### Step 10.2: Hotfix Workflow

For critical bugs that need immediate fixing:

```
/hotfix
```

**What happens:** The hotfix skill bypasses normal sprint processes:

Agent: "Hotfix workflow started. First, what's the critical issue?"

User: "Users are stuck in infinite login loop after updating to v1.0.1"

Agent: "Critical severity confirmed. Let me create a hotfix branch and track approvals:

       **Hotfix Branch**: hotfix/login-loop-fix
       **Issue**: Users stuck in infinite login loop (v1.0.1 regression)
       **Severity**: Critical (users can't access app)
       **Risk**: Low (auth-only change)

       Should I proceed with the fix?"

User: "Yes"

Agent: "Creating hotfix branch from v1.0.0 tag...
       Investigating root cause..."

Agent: "Found the issue: token refresh logic was removed in the v1.0.1 refactor.
       Fix is to re-add the refresh logic. Shall I implement?"

User: "Yes"

Agent: [Implements fix, creates PR, requests expedited review]
       "Hotfix complete. Branch: hotfix/login-loop-fix
       Ready for testing and merge."

**What makes a good hotfix candidate:**
- Critical user-facing bug (crash, data loss, login failure)
- Clear root cause identified
- Fix is isolated and low-risk
- Does NOT include new features or scope creep

### Step 10.3: Bug Fix Releases

For non-critical bugs that accumulate:

```
1. /bug-report for each known issue
2. /milestone-review "v1.0.2" to see all open bugs
3. /sprint-plan new (focus sprint on bug fixes)
4. Release when bug count is at acceptable threshold
```

**Typical release cadence:**
- **Hotfixes**: Within 24-48 hours for critical bugs
- **Patch releases** (v1.0.x): Every 2-4 weeks for minor fixes
- **Minor releases** (v1.x.0): Monthly for new features
- **Major releases** (x.0.0): Quarterly for major overhauls

### Step 10.4: Store Listing Maintenance

Keep your store presence fresh:

**App Store (iOS):**
- Update screenshots when you add major features
- Refresh app preview videos quarterly
- Respond to user reviews (at least weekly)
- A/B test icons and descriptions using App Store Connect

**Google Play:**
- Update graphics when features change
- Maintain a chnaglog in the Play Console
- Respond to reviews
- Use Play Console experiments for store listing A/B testing

```
Ask the release-manager agent to audit our store listings
and identify outdated screenshots or copy that needs refreshing.
```

### Step 10.5: User Review Monitoring and Response

Set up a weekly review ritual:

```
Ask the project-manager agent to summarize our user reviews
from the past week across App Store and Google Play.
```

This should cover:
- Average rating trend
- Common praise points (learn what users love)
- Common complaints (prioritize fixes)
- Feature requests (add to backlog)
- Response rate (aim for 100% on 1-star reviews, >50% overall)

### Step 10.6: Feature Releases Post-Launch

When adding significant features after launch:

```
1. /milestone-review to assess current state
2. /sprint-plan new for the feature sprint
3. Implement with full workflow (design → review → code-review → test)
4. Beta testing via TestFlight (iOS) / Internal Testing (Android)
5. Staged rollout (start at 10%, monitor crash rate, scale up)
6. Full release with /patch-notes
```

**Staged rollout strategy:**
```
Day 1:  10% of users  → monitor crash rate, basic analytics
Day 2:  25% of users  → check performance, user feedback
Day 3:  50% of users  → verify no regressions
Day 4:  100% of users → full release
```

### Step 10.7: Analytics-Driven Iteration

Use data to guide your roadmap:

```
Ask the analytics-engineer agent to analyze our user retention
cohorts and identify where users are dropping off.
```

**Key metrics to review monthly:**
- **Retention**: Day 1, Day 7, Day 30, Day 90
- **Engagement**: DAU/MAU ratio (target: > 20%)
- **Conversion**: If free → paid, track funnel
- **Feature adoption**: Which features users use most/least
- **Session length**: Average and distribution

**Example analysis output:**
```
Retention Analysis (Last 30 days):
- Day 1 retention: 45% (below 50% benchmark - concerning)
- Day 7 retention: 22% (needs improvement)
- Day 30 retention: 8% (industry average for productivity apps)

Drop-off Points:
- 60% of users abandon at the onboarding survey (screen 3)
- 40% of users who complete onboarding don't return Day 2

Recommendations:
1. HIGH: Simplify onboarding to 2 screens
2. MEDIUM: Add "resume where you left off" for returning users
3. LOW: Consider push reminder for Day 1 dormant users
```

### Step 10.8: Community Management

If your app has an active user community:

**What to monitor:**
- App store reviews and ratings
- Social media mentions
- Support ticket volume and themes
- Community forums or Discord (if applicable)

**Response guidelines:**
- 1-star reviews: Always respond within 24 hours, apologize, offer resolution
- 2-3 star reviews: Respond within 48 hours, acknowledge feedback
- 4-5 star reviews: Respond warmly, encourage sharing

### Step 10.9: Accessibility Updates Post-Launch

Maintain accessibility as you iterate:

```
/code-review lib/features/settings/presentation/pages/settings_page.dart
```

- Every new feature needs accessibility review
- When you update UI, re-verify touch targets, contrast, and labels
- Test with screen readers quarterly on both platforms

### Step 10.10: Deprecation and Migration

When you need to remove features or change APIs:

```
1. Announce deprecation at least 30 days before removal
2. /localize lib/ to find all hardcoded strings referencing the feature
3. Update all references before the removal release
4. In the removal release, add migration logic to handle old data
5. Document the migration path in the patch notes
```

---

## Tips for Getting the Most Out of the System

### Start with `/start`

If you're new to the project or unsure where to begin, run `/start`. It asks
a few questions about your current situation and routes you directly to the
right workflow. No assumptions, no guesswork.

### Write Design Docs Before Code

The biggest mistake new users make is jumping straight into code. Every hour
spent on a feature spec saves three hours of rework. Use `/design-system`
and `/design-review` to get the design right before implementation starts.

### Use the Right Agent for the Job

Agents have defined domains. A `flutter-specialist` will give better Flutter
advice than a general prompt. A `security-engineer` will catch things a
`feature-developer` misses. Check the Agent Quick-Reference and pick the
right specialist.

### Break Big Features Into Small PRs

Small, focused pull requests get better reviews and merge faster. One
feature should typically be:
- 1-3 agents involved maximum
- Reviewable in under 30 minutes
- Deployable independently

If a feature takes more than one sprint to implement, consider splitting it.

### Run `/code-review` Before Merging

Every non-trivial change benefits from a code review. Run `/code-review` on
your changed files before committing. It catches architectural issues, security
problems, and testability concerns before they reach production.

### Don't Skip Testing

The `qa-tester` and `qa-lead` agents exist for a reason. Write tests alongside
your code (verification-driven development), not after. A feature without tests
isn't done.

### Keep Context Fresh

Claude Code sessions have context limits. When context gets full (~65-70%):
- Commit your work with clear, descriptive messages
- Run `/clear` to start fresh
- Pick up where you left off in the next session

The `session-stop.sh` hook logs accomplishments to help you resume.

### Use Team Skills for Cross-Domain Features

When a feature touches multiple areas (UI + backend + platform-specific),
don't try to coordinate everything yourself. Use `/team-ui`,
`/team-release`, or `/team-polish` to orchestrate multiple specialists
working in parallel.

### Monitor Post-Launch

Your work isn't done when the app ships. Set up weekly rituals:
- Check crash rates and analytics (`/milestone-review`)
- Respond to user reviews
- Run `/tech-debt` monthly to keep debt manageable
- Update store listings when features change

### Respect Platform Conventions

iOS and Android have different design languages, review processes, and
technical constraints. Don't fight them:
- Use `ios-specialist` for App Store-specific questions
- Use `android-specialist` for Play Store and Android-specific questions
- Use `web-specialist` for PWA and web-specific questions

### Use Phases as a Guide, Not a Straitjacket

The 10 phases are a recommended path, not a rigid sequence. You might:
- Start with `/prototype` before committing to `/design-system`
- Discover during implementation that you need more design work
- Skip phases entirely for small features

Use your judgment. The phases exist to prevent common mistakes, not to
create bureaucracy.

### Keep Your Sprint Plans Updated

Out-of-date sprint plans are worse than no plans. Every time you complete
a task, add it to the sprint log. When priorities shift, update the plan.
`/sprint-plan status` should always reflect reality.

### Lean on the Agents for Routine Decisions

Agents are good at routine work: writing tests, updating docs, generating
changelogs, creating bug reports. Don't waste brain cycles on things that
don't need your judgment. Delegate routine tasks and focus on decisions
that actually need human input.

---

## Appendix A: Agent Quick-Reference

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `flutter-specialist` | Flutter core | General Flutter questions, widget selection |
| `ios-specialist` | iOS platform | iOS-specific behavior, Swift integration |
| `android-specialist` | Android platform | Android-specific behavior, Play Services |
| `web-specialist` | Web platform | PWA, responsive design, web APIs |
| `desktop-specialist` | Desktop platforms | Windows/macOS/Linux native integration |
| `state-management-specialist` | State management | Riverpod, Bloc, Provider architecture |
| `feature-developer` | Feature implementation | Implementing features end-to-end |
| `app-flow-designer` | App navigation | Navigation architecture, deep linking |
| `mobile-ux-specialist` | UX design | User flows, wireframes, usability |
| `ui-engineer` | UI implementation | Custom widgets, animations, styling |
| `app-architecture-specialist` | Architecture | Clean Architecture, dependency injection |
| `security-engineer` | Security | Secure storage, authentication, data protection |
| `qa-lead` | QA planning | Test planning, milestone validation |
| `qa-tester` | QA execution | Writing tests, bug investigation |
| `performance-analyst` | Performance | Profiling, optimization, memory analysis |
| `release-manager` | Release coordination | Store submission, build management |
| `project-manager` | Project planning | Sprint planning, capacity, milestones |
| `product-designer` | Product design | Feature specs, user research, PRD |
| `technical-lead` | Technical leadership | Architecture decisions, technical strategy |
| `integration-specialist` | Integrations | Backend APIs, third-party services |
| `accessibility-specialist` | Accessibility | WCAG compliance, assistive technology |
| `localization-lead` | Localization | i18n, translation workflow |
| `devops-engineer` | DevOps | CI/CD, automated builds, deployment |
| `analytics-engineer` | Analytics | Analytics integration, event tracking |

---

## Appendix B: Slash Command Quick-Reference

**Reviews & Analysis**
- `/code-review` - Architectural and quality code review
- `/design-review` - Feature spec completeness review
- `/scope-check` - Sprint/feature scope creep analysis
- `/perf-profile` - Performance profiling workflow
- `/tech-debt` - Technical debt scan and register
- `/asset-audit` - Asset compliance and naming validation

**Production**
- `/sprint-plan` - Create or update sprint plans
- `/milestone-review` - Milestone progress review
- `/estimate` - Task effort estimation
- `/retrospective` - Sprint/milestone retrospective
- `/bug-report` - Structured bug report creation

**Project Management**
- `/start` - Guided onboarding workflow
- `/project-stage-detect` - Analyze project state and gaps
- `/reverse-document` - Generate docs from existing code
- `/gate-check` - Phase readiness validation
- `/map-systems` - Feature decomposition and dependency mapping
- `/design-system` - Guided feature spec authoring

**Release**
- `/release-checklist` - Pre-release validation checklist
- `/launch-checklist` - Full cross-department launch readiness
- `/changelog` - Auto-generate changelog from git
- `/patch-notes` - Player/user-facing release notes
- `/hotfix` - Emergency fix workflow

**Creative**
- `/feature-brainstorm` - Guided feature ideation
- `/prototype` - Rapid prototyping workflow
- `/onboard` - Contributor/agent onboarding document
- `/localize` - Localization scan and string extraction

**Team Orchestration**
- `/team-ui` - Coordinate UI development
- `/team-release` - Coordinate release activities
- `/team-polish` - Coordinate polish pass

---

## Appendix C: Common Workflows

### New Feature: From Idea to Implementation

```
1. /feature-brainstorm "feature domain"
2. /design-system feature-name
3. /design-review lib/features/.../feature-spec.md
4. /sprint-plan new  (add feature to sprint)
5. Implement with feature-developer agent
6. /code-review lib/features/.../
7. Commit
```

### Fix a Bug

```
1. /bug-report "description"
2. Investigate with qa-tester agent
3. Fix with feature-developer agent
4. /code-review <fixed files>
5. Add regression test
6. Commit with bug reference
```

### Performance Optimization

```
1. /perf-profile
2. Analyze bottlenecks with performance-analyst
3. Implement optimizations
4. Re-profile to verify improvement
5. /tech-debt (if optimization requires tradeoffs)
```

### Prepare for Release

```
1. /milestone-review <current milestone>
2. /scope-check <current sprint>
3. /tech-debt
4. /localize lib/
5. /accessibility-specialist audit
6. /release-checklist v1.0.0
7. /team-release
```
