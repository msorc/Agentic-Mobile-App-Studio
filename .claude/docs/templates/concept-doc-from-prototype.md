# [Prototype Name] — Concept Document

---
**Status**: Reverse-Documented from Prototype
**Prototype Path**: `prototypes/[name]/`
**Date**: [YYYY-MM-DD]
**Creator**: [User name]
**Outcome**: [Success | Partial Success | Failed | Needs More Testing]
---

> **⚠️ Reverse-Documentation Notice**
>
> This concept document was created **after** the prototype was built. It captures
> the core feature, learnings, and design insights discovered through prototyping.
> This is a formalization of experimental work, not a pre-planned design.

---

## 1. Prototype Overview

**Original Hypothesis**:
[What question or idea was this prototype testing?]

**Approach**:
[How was the prototype built? Quick and dirty? Focused on one feature?]

**Duration**:
- Time spent: [X hours/days]
- Complexity: [Throwaway | Could be production-ready | Needs full rewrite]

**Outcome** (clarified):
- ✅ **Validated**: [What worked and should move forward]
- ⚠️ **Needs Work**: [What showed promise but needs refinement]
- ❌ **Invalidated**: [What didn't work and should be abandoned]

---

## 2. Core Feature

**What the Prototype Does**:
[Describe the feature or system that was prototyped]

**How It Feels** (user feedback):
- [Feeling 1 — e.g., "Satisfying", "Clunky", "Too complex"]
- [Feeling 2 — e.g., "Intuitive", "Confusing", "Needs tutorial"]
- [Feeling 3 — e.g., "Engaging", "Boring", "Has potential"]

**User Fantasy**:
[What experience does this feature create?]

**Core Loop** (if applicable):
```
[Action 1] → [Result 1] → [Action 2] → [Result 2] → [Repeat or Conclude]
```

**Emergent Behaviors** (unintended but interesting):
- [Behavior 1]: [What users did that wasn't planned]
- [Behavior 2]: [Unexpected usage pattern or interaction]

---

## 3. What Worked

### Feature Successes

✅ **[Success 1]**: [What worked well]
- **Why**: [What made this successful]
- **Keep for Production**: [Should this be preserved?]

✅ **[Success 2]**: [What worked well]
- **Why**: [What made this successful]
- **Keep for Production**: [Should this be preserved?]

### Technical Successes

✅ **[Technical win 1]**: [What technical approach worked]
- **Lesson**: [What we learned]
- **Reusable**: [Can this code/approach be used in production?]

✅ **[Technical win 2]**: [What worked]
- **Lesson**: [What we learned]

---

## 4. What Didn't Work

### Feature Failures

❌ **[Failure 1]**: [What didn't work]
- **Why**: [Root cause]
- **Could It Be Fixed**: [Is it salvageable or fundamentally flawed?]

❌ **[Failure 2]**: [What didn't work]
- **Why**: [Root cause]
- **Could It Be Fixed**: [Yes/No + how]

### Technical Failures

❌ **[Technical issue 1]**: [What caused problems]
- **Lesson**: [What to avoid in production]

❌ **[Technical issue 2]**: [What caused problems]
- **Lesson**: [What to avoid]

---

## 5. What Needs Refinement

⚠️ **[Element 1]**: [What showed promise but needs work]
- **Issue**: [What's wrong with it currently]
- **Path Forward**: [How to improve it]
- **Effort**: [Small | Medium | Large refactor]

⚠️ **[Element 2]**: [What needs refinement]
- **Issue**: [Current problem]
- **Path Forward**: [Improvement approach]
- **Effort**: [Estimate]

---

## 6. Key Learnings

### Design Insights

💡 **[Insight 1]**: [What we learned about app design]
- **Implication**: [How this affects future work]

💡 **[Insight 2]**: [Design learning]
- **Implication**: [How this affects the feature spec or other features]

### Technical Insights

💡 **[Insight 3]**: [Technical learning]
- **Implication**: [Architecture or implementation guidance]

💡 **[Insight 4]**: [Technical learning]
- **Implication**: [Future technical decisions]

### User Psychology Insights

💡 **[Insight 5]**: [What we learned about user behavior]
- **Implication**: [How this affects design philosophy]

---

## 7. Production Readiness Assessment

**Should This Become a Full Feature?**: [Yes | No | Needs More Testing | Pivot to Different Approach]

**If Yes — Production Requirements**:
- [ ] [Requirement 1 — e.g., "Rewrite for performance"]
- [ ] [Requirement 2 — e.g., "Add proper UI"]
- [ ] [Requirement 3 — e.g., "Design 10 more variations"]
- [ ] [Requirement 4 — e.g., "Integrate with user profile system"]

**Estimated Production Effort**: [Small | Medium | Large]
- Prototype reusability: [X%] of code can be kept
- From-scratch effort: [X hours/days to production-ready]

**If No — Why Not?**:
- [Reason 1 — e.g., "Engaging but doesn't fit app pillars"]
- [Reason 2 — e.g., "Too complex for target audience"]
- [Reason 3 — e.g., "Technically infeasible at scale"]

**If Pivot — Suggested Direction**:
- [Alternative approach 1]
- [Alternative approach 2]

---

## 8. Product Pillars Alignment

**How This Relates to App Pillars** (if product pillars are defined):

| Pillar | Alignment | Notes |
|--------|-----------|-------|
| [Pillar 1] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] |
| [Pillar 2] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] |
| [Pillar 3] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] |

**Overall Pillar Fit**: [Does this belong in the app?]

---

## 9. Next Steps

### Immediate (If Moving Forward)
1. **[Task 1]**: [e.g., "Create full feature spec for this system"]
2. **[Task 2]**: [e.g., "Write ADR for technical approach"]
3. **[Task 3]**: [e.g., "Add to backlog for Sprint X"]

### Before Production (If Needs More Work)
1. **[Task 1]**: [e.g., "Build second prototype testing X variation"]
2. **[Task 2]**: [e.g., "User test with 5+ people"]
3. **[Task 3]**: [e.g., "Investigate technical feasibility of Y"]

### If Abandoning
1. **[Task 1]**: [e.g., "Archive prototype with this document"]
2. **[Task 2]**: [e.g., "Extract reusable code/learnings"]
3. **[Task 3]**: [e.g., "Update product pillars if this changed thinking"]

---

## 10. Technical Notes

**Prototype Implementation**:
- Framework: [Flutter / React Native / etc.]
- Architecture: [How it was structured]
- Shortcuts taken: [What was hacky or throwaway]

**Reusable Code** (if any):
- `[file/path 1]`: [What it does, reusability]
- `[file/path 2]`: [What it does, reusability]

**Technical Debt** (if moving to production):
- [Debt 1]: [What needs rewriting]
- [Debt 2]: [What needs proper implementation]

---

## 11. User Testing Feedback

*(If prototype was user tested)*

**Testers**: [N people, internal/external]

**Positive Feedback**:
- "[Quote 1]" — [Tester name/role]
- "[Quote 2]" — [Tester name/role]

**Negative Feedback**:
- "[Quote 1]" — [Tester name/role]
- "[Quote 2]" — [Tester name/role]

**Suggestions**:
- "[Suggestion 1]" — [Tester name]
- "[Suggestion 2]" — [Tester name]

**Themes**:
- [Theme 1]: [What multiple testers agreed on]
- [Theme 2]: [Common feedback]

---

## 12. Related Work

**Inspired By** (apps/features this was influenced by):
- [App 1]: [What feature or feeling]
- [App 2]: [What was borrowed or adapted]

**Differs From** (how this is unique or different):
- [Difference 1]
- [Difference 2]

**Integrates With** (existing app features):
- [Feature 1]: [How they would connect]
- [Feature 2]: [How they would connect]

---

## 13. Open Questions

**Design Questions**:
1. **[Question 1]**: [What's still undecided about the design?]
2. **[Question 2]**: [What needs user testing or iteration?]

**Technical Questions**:
3. **[Question 3]**: [What technical unknowns remain?]
4. **[Question 4]**: [What needs feasibility testing?]

---

## 14. Appendix: Prototype Assets

**Code**:
- Location: `prototypes/[name]/lib/`
- Status: [Archival | Partial reuse | Full reuse]

**Assets** (if any):
- Location: `prototypes/[name]/assets/`
- Status: [Placeholder | Production-ready | Needs replacement]

**Documentation**:
- README: [Exists | Missing]
- Build instructions: [Exists | Missing]

---

## Version History

| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial concept doc from prototype analysis |
| [Date] | [User] | Clarified outcomes, added user feedback |

---

**Final Recommendation**: [GO | NO-GO | PIVOT]

**Rationale**: [1-2 sentence summary of why]

---

*This concept document was generated by `/reverse-document concept prototypes/[name]`*
