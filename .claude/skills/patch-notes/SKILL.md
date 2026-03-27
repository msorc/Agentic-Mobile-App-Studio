---
name: patch-notes
description: "Generate user-facing release notes from git history, sprint data, and internal changelogs. Translates developer language into clear, engaging user communication."
argument-hint: "[version] [--style brief|detailed|full]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash
---

When this skill is invoked:

1. **Parse the arguments**:
   - `version`: the release version to generate notes for (e.g., `1.2.0`)
   - `--style`: output style — `brief` (bullet points), `detailed` (with context),
     `full` (with developer commentary). Default: `detailed`.

2. **Gather change data from multiple sources**:
   - Read the internal changelog at `production/releases/[version]/changelog.md` if it exists
   - Run `git log` between the previous release tag and current tag/HEAD
   - Read sprint retrospectives in `production/sprints/` for context
   - Read bug fix records from QA if available

3. **Categorize all changes** into user-facing categories:
   - **New Features**: new features, screens, capabilities, integrations
   - **Improvements**: feature enhancements, performance gains, UI refinements
   - **Bug Fixes**: grouped by feature area
   - **Known Issues**: transparency about unresolved problems

4. **Translate developer language to user language**:
   - "Refactored authentication token refresh" → "Improved login reliability"
   - "Fixed null reference in data sync" → "Fixed crash when syncing data"
   - "Reduced memory allocations in list rendering" → "Faster list scrolling"
   - Remove purely internal changes that don't affect users
   - Preserve specific numbers for improvements (load time: 3s → 1.5s)

5. **Generate the release notes** using the appropriate style:

### Brief Style
```markdown
# Version [Version] — [Title]

**New**
- [Feature 1]
- [Feature 2]

**Improvements**
- [Improvement with context]

**Fixes**
- [Bug fix 1]
- [Bug fix 2]

**Known Issues**
- [Issue 1]
```

### Detailed Style
```markdown
# Version [Version] — [Title]
*[Date]*

## Highlights
[1-2 sentence summary of the most exciting changes]

## New Features
### [Feature Name]
[2-3 sentences describing the feature and why users should be excited]

## Improvements
### [Area]
- **[Change]**: [explanation of what changed and why]

## Bug Fixes
### [Feature Area]
- Fixed [description of what users experienced]

### [Another Area]
- Fixed [description]

## Performance
- [Improvement users will notice]

## Known Issues
- [Issue and workaround if available]
```

### Full Style
Includes everything from Detailed, plus:
```markdown
## Developer Notes
### [Topic]
> [Developer insight into a major change — why it was made, what was considered,
> what the team learned. Written in first-person team voice.]
```

6. **Review the output** for:
   - No internal jargon (replace technical terms with user-friendly language)
   - No references to internal systems, tickets, or sprint numbers
   - Improvements include measurable impact where possible
   - Bug fixes describe the user experience, not the technical cause
   - Tone matches the app's voice (adjust formality based on app style)

7. **Save the release notes** to `production/releases/[version]/release-notes.md`,
   creating the directory if needed.

8. **Output to the user**: the complete release notes, the file path, a count of
   changes by category, and any internal changes that were excluded (for review).
