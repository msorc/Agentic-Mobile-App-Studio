---
name: perf-profile
description: "Structured performance profiling workflow. Identifies bottlenecks, measures against budgets, and generates optimization recommendations with priority rankings."
argument-hint: "[feature-name or 'full']"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
---
When this skill is invoked:

1. **Determine scope** from the argument:
   - If a feature name: focus profiling on that specific feature
   - If `full`: run a comprehensive profile across all features

2. **Read performance budgets** — Check for existing performance targets in design docs or CLAUDE.md:
   - Target FPS (e.g., 60fps = 16.67ms frame budget)
   - Memory budget (total and per-feature)
   - Load time targets
   - Widget rebuild budgets
   - Network bandwidth limits (if applicable)

3. **Analyze the codebase** for common performance issues:

   **CPU Profiling Targets**:
   - Build methods — list all StatefulWidgets and estimate cost
   - Nested loops over large collections
   - String operations in hot paths
   - Allocation patterns in render loops
   - Expensive calculations in build methods
   - Unoptimized list operations

   **Memory Profiling Targets**:
   - Large data structures and their growth patterns
   - Image/asset memory footprint estimates
   - Object lifecycle (disposal patterns)
   - Leaked references (objects that should be disposed but aren't)
   - Cache sizes and eviction policies

   **Widget Render Targets**:
   - Rebuild frequency of widgets
   - Const constructor usage
   - RepaintBoundary usage
   - ListView.builder vs ListView for large lists
   - Image caching configuration

   **I/O Targets**:
   - Data loading patterns (sync vs async)
   - Network request frequency and size
   - Local storage access patterns

4. **Generate the profiling report**:

   ```markdown
   ## Performance Profile: [Feature or Full]
   Generated: [Date]

   ### Performance Budgets
   | Metric | Budget | Estimated Current | Status |
   |--------|--------|-------------------|--------|
   | Frame time | [16.67ms] | [estimate] | [OK/WARNING/OVER] |
   | Memory | [target] | [estimate] | [OK/WARNING/OVER] |
   | Load time | [target] | [estimate] | [OK/WARNING/OVER] |
   | Widget rebuilds | [target] | [estimate] | [OK/WARNING/OVER] |

   ### Hotspots Identified
   | # | Location | Issue | Estimated Impact | Fix Effort |
   |---|----------|-------|------------------|------------|
   | 1 | [file:line] | [description] | [High/Med/Low] | [S/M/L] |
   | 2 | [file:line] | [description] | [High/Med/Low] | [S/M/L] |

   ### Optimization Recommendations (Priority Order)
   1. **[Title]** — [Description of the optimization]
      - Location: [file:line]
      - Expected gain: [estimate]
      - Risk: [Low/Med/High]
      - Approach: [How to implement]

   ### Quick Wins (< 1 hour each)
   - [Simple optimization 1]
   - [Simple optimization 2]

   ### Requires Investigation
   - [Area that needs actual runtime profiling to determine impact]
   ```

5. **Output the report** with a summary: top 3 hotspots, estimated headroom vs budget, and recommended next action.

### Rules
- Never optimize without measuring first — gut feelings about performance are unreliable
- Recommendations must include estimated impact — "make it faster" is not actionable
- Profile on target hardware, not just development machines
- Distinguish between CPU-bound, memory-bound, and I/O-bound bottlenecks
- Consider worst-case scenarios (maximum items, lowest spec hardware, worst network conditions)
- Static analysis (this skill) identifies candidates; runtime profiling confirms
