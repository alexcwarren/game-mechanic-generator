# Release Checklist

Run this checklist before publishing a new release.

> For platform-specific releases, run the relevant platform checks before publishing.

## Application

- [ ] Application launches successfully
- [ ] Application closes without errors
- [ ] Window resizes correctly
- [ ] UI remains usable at the minimum supported window size

## Mechanic Selection

- [ ] Verb selection works
- [ ] Constraint selection works
- [ ] Pressure selection works
- [ ] Goal selection works
- [ ] Selected values appear correctly in the summary
- [ ] Decision / Tension input accepts text correctly

## Randomization

- [ ] Randomize updates unlocked values
- [ ] Kept Verb remains unchanged
- [ ] Kept Constraint remains unchanged
- [ ] Kept Pressure remains unchanged
- [ ] Kept Goal remains unchanged
- [ ] Multiple Keep options work together

## Export

- [ ] Export button opens the save dialog
- [ ] JSON file saves successfully
- [ ] `.json` extension is applied correctly
- [ ] Exported file contains the correct Verb
- [ ] Exported file contains the correct Constraint
- [ ] Exported file contains the correct Pressure
- [ ] Exported file contains the correct Goal
- [ ] Exported file contains the correct Decision / Tension
- [ ] Cancelling the save dialog does not cause an error

## Repository / Release

- [ ] All intended changes are merged into `main`
- [ ] No build artifacts are tracked in Git
- [ ] README reflects current functionality
- [ ] Version number is correct
- [ ] Release build was created from the intended commit
- [ ] The exact release build was smoke-tested
- [ ] Release notes are prepared
