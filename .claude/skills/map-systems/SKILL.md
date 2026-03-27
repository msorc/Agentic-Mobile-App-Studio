---
name: map-systems
description: "Decompose an app concept into individual features, map dependencies, prioritize design order, and create the features index."
argument-hint: "[optional: 'next' to pick highest-priority undesigned feature, or a feature name to hand off to /design-system]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion, TodoWrite
---

When this skill is invoked:

## 1. Parse Arguments

Two modes:

- **No argument**: `/map-systems` — Run the full decomposition workflow (Phases 1-5)
  to create or update the features index.
- **`next`**: `/map-systems next` — Pick the highest-priority undesigned feature
  from the index and hand off to `/design-system` (Phase 6).

---

## 2. Phase 1: Read Concept (Required Context)

Read the app concept and any existing design work. This provides the raw material
for feature decomposition.

**Required:**
- Read `design/app-concept.md` — **fail with a clear message if missing**:
  > "No app concept found at `design/app-concept.md`. Run `/feature-brainstorm` first
  > to create one, then come back to decompose it into features."

**Optional (read if they exist):**
- Read `design/app-pillars.md` — pillars constrain priority and scope
- Read `design/features/index.md` — if exists, **resume** from where it left off
  (update, don't recreate from scratch)
- Glob `design/features/*.md` — check which feature specs already exist

**If the features index already exists:**
- Read it and present current status to the user
- Use `AskUserQuestion` to ask:
  "The features index already exists with [N] features ([M] designed, [K] not started).
  What would you like to do?"
  - Options: "Update the index with new features", "Design the next undesigned feature",
    "Review and revise priorities"

---

## 3. Phase 2: Feature Enumeration (Collaborative)

Extract and identify all features the app needs. This is the creative core of the
skill — it requires human judgment because concept docs rarely enumerate every
feature explicitly.

### Step 2a: Extract Explicit Features

Scan the app concept for directly mentioned features and functionality:
- Core Functionality section (most explicit)
- Core Flow section (implies what features drive each flow)
- Technical Considerations section (offline support, sync, APIs, etc.)
- MVP Definition section (required features = required systems)

### Step 2b: Identify Implicit Features

For each explicit feature, identify the **hidden features** it implies. Apps always
need more features than the concept doc mentions. Use this inference pattern:

- "Authentication" implies: login/logout, session management, token storage,
  password reset, email verification, security measures
- "Data sync" implies: offline storage, conflict resolution, sync status UI,
  background sync, network detection
- "Notifications" implies: push notification handling, local notifications,
  notification preferences, badge management, deep linking
- "Settings" implies: user preferences storage, app configuration, 
  account management, data export/deletion
- "Search" implies: search indexing, filtering, sorting, search history,
  recent searches, suggestions
- "Media handling" implies: camera/gallery access, image compression, upload/download,
  playback controls, offline caching
- "Profiling/social" implies: user accounts, profiles, friend lists, activity feeds,
  sharing, privacy controls

Explain in conversation text why each implicit feature is needed (with examples).

### Step 2c: User Review

Present the enumeration organized by category. For each feature, show:
- Name
- Category
- Brief description (1 sentence)
- Whether it was explicit (from concept) or implicit (inferred)

Then use `AskUserQuestion` to capture feedback:
- "Are there features missing from this list?"
- "Should any of these be combined or split?"
- "Are there features listed that this app does NOT need?"

Iterate until the user approves the enumeration.

---

## 4. Phase 3: Dependency Mapping (Collaborative)

For each feature, determine what it depends on. A feature "depends on" another if
it cannot function without that other feature existing first.

### Step 3a: Map Dependencies

For each feature, list its dependencies. Use these dependency heuristics:
- **Input/output dependencies**: Feature A produces data Feature B needs
- **Structural dependencies**: Feature A provides the framework Feature B plugs into
- **UI dependencies**: Every feature has a corresponding UI that depends on it
  (but UI is designed after the feature logic)

### Step 3b: Sort by Dependency Order

Arrange features into layers:
1. **Foundation**: Features with zero dependencies (designed and built first)
2. **Core**: Features depending only on Foundation features
3. **Feature**: Features depending on Core features
4. **Presentation**: UI and feedback features that wrap core features
5. **Polish**: Analytics, accessibility, notifications, error handling

### Step 3c: Detect Circular Dependencies

Check for cycles in the dependency graph. If found:
- Highlight them to the user
- Propose resolutions (interface abstraction, simultaneous design, breaking the
  cycle by defining a contract between the two features)

### Step 3d: Present to User

Show the dependency map as a layered list. Highlight:
- Any circular dependencies
- Any "bottleneck" features (many others depend on them — these are high-risk)
- Any features with no dependents (leaf nodes — lower risk, can be designed late)

Use `AskUserQuestion` to ask: "Does this dependency ordering look right? Any
dependencies I'm missing or that should be removed?"

---

## 5. Phase 4: Priority Assignment (Collaborative)

Assign each feature to a priority tier based on what milestone it's needed for.

### Step 4a: Auto-Assign Based on Concept

Use these heuristics for initial assignment:
- **MVP**: Features mentioned in the concept's "Required for MVP" section, plus their
  Foundation-layer dependencies
- **Vertical Slice**: Features needed for a complete experience in one flow
- **Alpha**: All remaining core features
- **Full Vision**: Polish, analytics, and nice-to-have features

### Step 4b: User Review

Present the priority assignments in a table. For each tier, explain why features
were placed there.

Use `AskUserQuestion` to ask: "Do these priority assignments match your vision?
Which features should be higher or lower priority?"

Explain reasoning in conversation: "I placed [feature] in MVP because the core flow
requires it — without [feature], users can't complete the primary journey."

### Step 4c: Determine Design Order

Combine dependency sort + priority tier to produce the final design order:
1. MVP Foundation features first
2. MVP Core features second
3. MVP Feature features third
4. Vertical Slice Foundation/Core features
5. ...and so on

This is the order the team should write feature specs in.

---

## 6. Phase 5: Create Features Index (Write)

### Step 5a: Draft the Document

Create the features index with all data from Phases 2-4:
- Fill the enumeration table
- Fill the dependency map
- Fill the recommended design order
- Fill progress tracker (all features "Not Started" initially, unless specs already exist)

### Step 5b: Approval

Present a summary of the document:
- Total features count by category
- MVP feature count
- First 3 features in the design order
- Any high-risk items

Ask: "May I write the features index to `design/features/index.md`?"

Wait for approval. Write the file only after "yes."

### Step 5c: Update Session State

After writing, update `production/session-state/active.md` with:
- Task: Feature decomposition
- Status: Features index created
- File: design/features/index.md
- Next: Design individual feature specs

---

## 7. Phase 6: Design Individual Features (Handoff to /design-system)

This phase is entered when:
- The user says "yes" to designing features after creating the index
- The user invokes `/map-systems [feature-name]`
- The user invokes `/map-systems next`

### Step 6a: Select the Feature

- If a feature name was provided, find it in the features index
- If `next` was used, pick the highest-priority undesigned feature (by design order)
- If the user just finished the index, ask:
  "Would you like to start designing individual features now? The first feature in
  the design order is [name]. Or would you prefer to stop here and come back later?"

Use `AskUserQuestion` for: "Start designing [feature-name] now, pick a different
feature, or stop here?"

### Step 6b: Hand Off to /design-system

Once a feature is selected, invoke the `/design-system [feature-name]` skill.

The `/design-system` skill handles the full feature spec authoring process:
- Gathers context from app concept, features index, and dependency specs
- Creates a file skeleton immediately
- Walks through all required sections one at a time (collaborative, incremental)
- Cross-references existing docs to prevent contradictions
- Routes to specialist agents for domain expertise
- Writes each section to file as soon as it's approved
- Runs `/design-review` when complete
- Updates the features index

**Do not duplicate the /design-system workflow here.** This skill owns the features
*index*; `/design-system` owns individual feature *specs*.

### Step 6c: Loop or Stop

After `/design-system` completes, use `AskUserQuestion`:
- "Continue to the next feature ([next feature name])?"
- "Pick a different feature?"
- "Stop here for this session?"

If continuing, return to Step 6a.

---

## 8. Phase 7: Suggest Next Steps

After the features index is created (or after designing some features), suggest
the appropriate next actions:

- "Run `/design-system [feature-name]` to write the next feature's spec"
- "Run `/design-review [path]` on each completed spec to validate quality"
- "Run `/gate-check` to check if you're ready to start building"
- "Prototype the highest-risk feature with `/app-prototype [feature]`"
- "Plan the first implementation sprint with `/sprint-plan new`"

---

## Collaborative Protocol

This skill follows the collaborative design principle at every phase:

1. **Question -> Options -> Decision -> Draft -> Approval** at every step
2. **AskUserQuestion** at every decision point (Explain -> Capture pattern):
   - Phase 2: "Missing features? Combine or split?"
   - Phase 3: "Dependency ordering correct?"
   - Phase 4: "Priority assignments match your vision?"
   - Phase 5: "May I write the features index?"
   - Phase 6: "Start designing, pick different, or stop?" then hand off to `/design-system`
3. **"May I write to [filepath]?"** before every file write
4. **Incremental writing**: Update the features index after each feature is designed
5. **Handoff**: Individual spec authoring is owned by `/design-system`, which handles
   incremental section writing, cross-referencing, design review, and index updates
6. **Session state updates**: Write to `production/session-state/active.md` after
   each milestone (index created, feature designed, priorities changed)

**Never** auto-generate the full features list and write it without review.
**Never** start designing a feature without user confirmation.
**Always** show the enumeration, dependencies, and priorities for user validation.
