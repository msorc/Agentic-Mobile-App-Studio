# Hook: pre-commit-code-quality

## Trigger

Runs before any commit that modifies files in `lib/`.

## Purpose

Enforces coding standards before code enters version control. Catches style
violations, missing documentation, overly complex methods, and hardcoded
values that should be data-driven.

## Implementation

```bash
#!/bin/bash
# Pre-commit hook: Code quality checks
# Adapt the specific checks to your language and tooling

CODE_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '^lib/')

EXIT_CODE=0

if [ -n "$CODE_FILES" ]; then
    for file in $CODE_FILES; do
        # Check for hardcoded magic numbers in feature code
        if [[ "$file" == lib/features/* ]]; then
            # Look for numeric literals that are likely configuration values
            # Adjust the pattern for your language
            if grep -nE '(timeout|retry|limit|threshold|max|min)[[:space:]]*[:=][[:space:]]*[0-9]+' "$file"; then
                echo "WARNING: $file may contain hardcoded configuration values. Use data files."
                # Warning only, not blocking
            fi
        fi

        # Check for TODO/FIXME without assignee
        if grep -nE '(TODO|FIXME|HACK)[^(]' "$file"; then
            echo "WARNING: $file has TODO/FIXME without owner tag. Use TODO(name) format."
        fi

        # Run Flutter analyzer
        flutter analyze "$file" || EXIT_CODE=1
    done

    # Run unit tests for modified systems
    # Uncomment and adapt for your test framework
    # flutter test test/unit/ || EXIT_CODE=1
fi

exit $EXIT_CODE
```

## Agent Integration

When this hook fails:
1. For style violations: auto-fix with your formatter or invoke `feature-developer`
2. For hardcoded values: invoke `feature-developer` to externalize the values
3. For test failures: invoke `qa-tester` to diagnose and `feature-developer` to fix
