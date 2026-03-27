---
name: team-polish
description: "Orchestrate the polish team: coordinates performance-analyst, ui-engineer, and qa-tester to optimize, polish, and harden a feature or area for release quality."
argument-hint: "[feature or area to polish]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
When this skill is invoked, orchestrate the polish team through a structured pipeline.

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

## Team Composition
- **performance-analyst** — Profiling, optimization, memory analysis, render performance
- **ui-engineer** — UI polish, animation smoothness, visual quality
- **qa-tester** — Edge case testing, regression testing, soak testing

## How to Delegate

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: performance-analyst` — Profiling, optimization, memory analysis
- `subagent_type: ui-engineer` — UI polish, animation, visual quality
- `subagent_type: qa-tester` — Edge case testing, regression testing, soak testing

Always provide full context in each agent's prompt (target feature/area, performance budgets, known issues). Launch independent agents in parallel where the pipeline allows it (e.g., Phases 3 and 4 can run simultaneously).

## Pipeline

### Phase 1: Assessment
Delegate to **performance-analyst**:
- Profile the target feature/area using `/perf-profile`
- Identify performance bottlenecks (render, computation, memory)
- Measure memory usage and check for leaks
- Benchmark against target hardware specs
- Output: performance report with prioritized optimization list

### Phase 2: Optimization
Delegate to **performance-analyst** (with relevant programmers as needed):
- Fix performance hotspots identified in Phase 1
- Optimize layout rebuilds, reduce overdraw (Flutter)
- Fix memory leaks and reduce allocation pressure
- Verify optimizations don't change feature behavior
- Output: optimized code with before/after metrics

### Phase 3: UI Polish (parallel with Phase 2)
Delegate to **ui-engineer**:
- Review UI for quality and consistency with design system
- Polish animations and transitions
- Ensure graceful degradation on lower-end devices
- Verify responsive layout across screen sizes
- Output: polished UI

### Phase 4: Hardening
Delegate to **qa-tester**:
- Test all edge cases: boundary conditions, rapid inputs, unusual sequences
- Soak test: run the feature for extended periods checking for degradation
- Stress test: maximum data, worst-case scenarios
- Regression test: verify polish changes haven't broken existing functionality
- Test on minimum spec hardware (if available)
- Output: test results with any remaining issues

### Phase 5: Sign-off
- Collect results from all team members
- Compare performance metrics against budgets
- Report: READY FOR RELEASE / NEEDS MORE WORK
- List any remaining issues with severity and recommendations

## Output
A summary report covering: performance before/after metrics, UI polish changes, test results, and release readiness assessment.
