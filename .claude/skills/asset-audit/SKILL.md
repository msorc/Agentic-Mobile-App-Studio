---
name: asset-audit
description: "Audits app assets for compliance with naming conventions, file size budgets, format standards, and pipeline requirements. Identifies orphaned assets, missing references, and standard violations."
argument-hint: "[category|all]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

When this skill is invoked:

1. **Read the asset standards** from CLAUDE.md naming conventions.

2. **Scan the target asset directory** using Glob:
   - `assets/images/**/*` for image assets
   - `assets/icons/**/*` for icons
   - `assets/fonts/**/*` for fonts
   - `assets/data/**/*` for data files

3. **Check naming conventions**:
   - Images: `[category]_[name]_[variant]_[size].[ext]`
   - Icons: `[category]_[name]_[size].[ext]`
   - All files must be lowercase with underscores

4. **Check file standards**:
   - Images: Correct format (PNG for UI, compressed for photos), within size budget
   - Icons: SVG preferred, or PNG at correct densities
   - Data: Valid JSON/YAML, schema-compliant

5. **Check for orphaned assets** by searching code for references to each
   asset file.

6. **Check for missing assets** by searching code for asset references and
   verifying the files exist.

7. **Output the audit**:

```markdown
# Asset Audit Report -- [Category] -- [Date]

## Summary
- **Total assets scanned**: [N]
- **Naming violations**: [N]
- **Size violations**: [N]
- **Format violations**: [N]
- **Orphaned assets**: [N]
- **Missing assets**: [N]
- **Overall health**: [CLEAN / MINOR ISSUES / NEEDS ATTENTION]

## Naming Violations
| File | Expected Pattern | Issue |
|------|-----------------|-------|

## Size Violations
| File | Budget | Actual | Overage |
|------|--------|--------|---------|

## Format Violations
| File | Expected Format | Actual Format |
|------|----------------|---------------|

## Orphaned Assets (no code references found)
| File | Last Modified | Size | Recommendation |
|------|-------------|------|---------------|

## Missing Assets (referenced but not found)
| Reference Location | Expected Path |
|-------------------|---------------|

## Recommendations
[Prioritized list of fixes]
```
