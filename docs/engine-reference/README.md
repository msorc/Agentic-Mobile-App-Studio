# Engine Reference Documentation

This directory contains curated, version-pinned documentation snapshots for the
Flutter SDK and its ecosystem. These files exist because **LLM knowledge
has a cutoff date** and Flutter/Dart update frequently with new features,
breaking changes, and deprecated patterns.

## Why This Exists

Claude's training data has a knowledge cutoff. Flutter SDK releases updates that
introduce breaking API changes, new widget types, and updated best practices.
Without these reference files, agents may suggest outdated code patterns.

## Structure

```
flutter/
├── VERSION.md                  # Pinned version, verification date, knowledge gap window
├── breaking-changes.md         # API changes between Flutter versions
├── deprecated-apis.md          # "Don't use X → Use Y" lookup tables
├── current-best-practices.md   # New practices not in model training data
├── packages.md                 # Popular packages ecosystem reference
└── platform-specific/          # Platform-specific considerations
    ├── ios.md
    ├── android.md
    ├── web.md
    └── desktop.md
```

## How Agents Use These Files

Flutter specialist agents are instructed to:

1. Read `VERSION.md` to confirm the current Flutter version
2. Check `deprecated-apis.md` before suggesting any Flutter/Dart API
3. Consult `breaking-changes.md` for version-specific concerns
4. Read relevant `platform-specific/*.md` for platform-specific work
5. Reference `packages.md` for ecosystem package guidance

## Maintenance

### When to Update

- After upgrading the Flutter SDK version
- When the LLM model is updated (new knowledge cutoff)
- After discovering an API the model gets wrong
- When adding new platform-specific documentation

### How to Update

1. Update `VERSION.md` with the new Flutter version and date
2. Add new entries to `breaking-changes.md` for the version transition
3. Move newly deprecated APIs into `deprecated-apis.md`
4. Update `current-best-practices.md` with new patterns
5. Update relevant `platform-specific/*.md` with platform changes
6. Set "Last verified" dates on all modified files

### Quality Rules

- Every file must have a "Last verified: YYYY-MM-DD" date
- Keep module files under 150 lines (context budget)
- Include code examples showing correct/incorrect patterns
- Link to official documentation URLs for verification
- Only document things that differ from the model's training data
