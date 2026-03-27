---
name: start
description: "First-time onboarding — asks where you are, then guides you to the right workflow. No assumptions."
argument-hint: "[no arguments]"
user-invocable: true
allowed-tools: Read, Glob, Grep, AskUserQuestion
---

# Guided Onboarding

This skill is the entry point for new users. It does NOT assume you have an app
idea, a framework preference, or any prior experience. It asks first, then routes
you to the right workflow.

---

## Workflow

### 1. Detect Project State (Silent)

Before asking anything, silently gather context so you can tailor your guidance.
Do NOT show these results unprompted — they inform your recommendations, not
the conversation opener.

Check:
- **Flutter configured?** Read `.claude/docs/technical-preferences.md`. If the
  Framework field contains `[TO BE CONFIGURED]`, Flutter is not set.
- **App concept exists?** Check for `design/prd/` or `design/feature specs/`.
- **Source code exists?** Glob for Dart files in `lib/` (`*.dart`).
- **Prototypes exist?** Check for directories in `prototypes/` or feature modules.
- **Design docs exist?** Count markdown files in `design/`.
- **Production artifacts?** Check for files in `production/sprints/` or
  `production/milestones/`.

Store these findings internally. You will use them to validate the user's
self-assessment and to tailor follow-up recommendations.

---

### 2. Ask Where the User Is

This is the first thing the user sees. Present these 4 options clearly:

> **Welcome to Agentic Mobile App Studio!**
>
> Before I suggest anything, I'd like to understand where you're starting from.
> Where are you at with your app idea right now?
>
> **A) No idea yet** — I don't have an app concept at all. I want to explore
> and figure out what to make.
>
> **B) Vague idea** — I have a rough app type, feeling, or category in mind
> (e.g., "something for fitness" or "a productivity app") but nothing concrete.
>
> **C) Clear concept** — I know the core idea — app type, basic features, maybe
> a pitch sentence — but haven't formalized it into documents yet.
>
> **D) Existing work** — I already have design docs, prototypes, code, or
> significant planning done. I want to organize or continue the work.

Wait for the user's answer. Do not proceed until they respond.

---

### 3. Route Based on Answer

#### If A: No idea yet

The user needs creative exploration before anything else. Platform choice,
technical setup — all of that comes later.

1. Acknowledge that starting from zero is completely fine
2. Briefly explain what `/feature-brainstorm` does (guided ideation using
   professional frameworks — user research, use case analysis, platform patterns)
3. Recommend running `/feature-brainstorm open` as the next step
4. Show the recommended path:
   - `/feature-brainstorm` — discover your app concept
   - `/sprint-plan` — plan the first sprint
   - Build initial feature modules

#### If B: Vague idea

The user has a seed but needs help growing it into a concept.

1. Ask them to share their vague idea — even a few words is enough
2. Validate the idea as a starting point (don't judge or redirect)
3. Recommend running `/feature-brainstorm [their hint]` to develop it
4. Show the recommended path:
   - `/feature-brainstorm [hint]` — develop the idea into a full concept
   - `/sprint-plan` — plan the first sprint
   - Build initial feature modules

#### If C: Clear concept

The user knows what they want to make but hasn't documented it.

1. Ask 2-3 follow-up questions to understand their concept:
   - What's the app type and core functionality? (one sentence)
   - Do they have target platforms in mind? (iOS, Android, Web, Desktop)
   - What's the rough scope? (MVP, small project, large project)
2. Based on their answers, offer two paths:
   - **Formalize first**: Run `/feature-brainstorm` to structure the concept into
     a proper product requirements document with use cases, platform targets,
     and scope tiers
   - **Jump to planning**: If they're confident in their concept, go straight
     to `/sprint-plan` and write the PRD manually afterward
3. Show the recommended path (adapted to their choice):
   - `/feature-brainstorm` or `/sprint-plan` (their pick)
   - `/design-review` — validate the concept doc
   - `/architecture-decision` — make first technical decisions
   - `/sprint-plan` — plan the first sprint

#### If D: Existing work

The user has artifacts already. Figure out what exists and what's missing.

1. Share what you found in Step 1 (now it's relevant):
   - "I can see you have [X Dart files / Y design docs / Z prototypes]..."
   - "Your Flutter configuration is [configured as X / not yet configured]..."
2. Recommend running `/project-stage-detect` for a full analysis
3. Show the recommended path:
   - `/project-stage-detect` — full gap analysis
   - `/design-review` — if design docs need validation
   - `/gate-check` — validate readiness for next phase
   - `/sprint-plan` — organize the work

---

### 4. Confirm Before Proceeding

After presenting the recommended path, ask the user which step they'd like
to take first. Never auto-run the next skill.

> "Would you like to start with [recommended first step], or would you prefer
> to do something else first?"

---

### 5. Hand Off

When the user chooses their next step, let them invoke the skill themselves
or offer to run it for them. Either way, the `/start` skill's job is done
once the user has a clear next action.

---

## Edge Cases

- **User picks D but project is empty**: Gently redirect — "It looks like the
  project is a fresh template with no artifacts yet. Would Path A or B be a
  better fit?"
- **User picks A but project has code**: Mention what you found — "I noticed
  there's already code in `lib/`. Did you mean to pick D (existing work)? Or
  would you like to start fresh with a new concept?"
- **User is returning (Flutter configured, concept exists)**: Skip onboarding
  entirely — "It looks like you're already set up! Your Flutter version is [X]
  and you have a feature index at `design/feature-index.md`. Want to pick up
  where you left off? Try `/sprint-plan` or just tell me what you'd like to work on."
- **User doesn't fit any option**: Let them describe their situation in their
  own words and adapt. The 4 options are starting points, not a prison.

---

## Collaborative Protocol

This skill follows the collaborative design principle:

1. **Ask first** — never assume the user's state or intent
2. **Present options** — give clear paths, not mandates
3. **User decides** — they pick the direction
4. **No auto-execution** — recommend the next skill, don't run it without asking
5. **Adapt** — if the user's situation doesn't fit a template, listen and adjust
