# Coding Standards

- All Dart/Flutter code must include doc comments on public APIs
- Every feature must have a corresponding architecture decision record in `docs/architecture/`
- Feature values must be data-driven (external config), never hardcoded
- All public methods must be unit-testable (dependency injection over singletons)
- Commits must reference the relevant design document or task ID
- **Verification-driven development**: Write tests first when adding features.
  For UI changes, verify with screenshots. Compare expected output to actual output
  before marking work complete. Every implementation should have a way to prove it works.

# Design Document Standards

- All design docs use Markdown
- Each feature has a dedicated document in `design/features/` or `design/prd/`
- Documents must include these required sections:
  1. **Overview** -- one-paragraph summary
  2. **User Experience** -- intended feeling and experience
  3. **Detailed Rules** -- unambiguous behavior
  4. **Formulas** -- all math defined with variables
  5. **Edge Cases** -- unusual situations handled
  6. **Dependencies** -- other features/systems listed
  7. **Tuning Knobs** -- configurable values identified
  8. **Acceptance Criteria** -- testable success conditions
- Balance values must link to their source formula or rationale
