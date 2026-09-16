# Game Mechanic Generator

A small desktop tool built with Godot for brainstorming gameplay mechanics.

Game Mechanic Generator helps turn loose gameplay ideas into more structured concepts by combining several design elements:

- **Verb** — what the player does
- **Constraint** — what limits or complicates that action
- **Pressure** — what forces the player to act, adapt, or accept risk
- **Goal** — what the player is trying to accomplish
- **Decision / Tension** — the meaningful choice created by the combination

The goal is not to automatically design a game, but to provide prompts that make it easier to explore interesting gameplay ideas.

---

## Example

A generated combination might look like:

> **The player must move**  
> while **enemies act whenever you act**  
> as **an opponent is actively undoing your progress**  
> in order to **arrange objects correctly**

From there, the designer identifies the resulting decision or tension:

> **How do I advance the puzzle without giving the opponent too many opportunities to undo my progress?**

---

## Features

- Select gameplay **Verbs**
- Select gameplay **Constraints**
- Select gameplay **Pressures**
- Select gameplay **Goals**
- Randomize mechanic combinations
- Keep selected elements while rerolling others
- Manually define the resulting **Decision / Tension**
- Export generated ideas as JSON
- Resizable desktop interface
- Scrollable mechanic libraries

---

## Download

Pre-built Windows versions are available from the repository's **Releases** page.

Download the latest `.exe` and run it directly.

No installation is currently required.

---

## Export Format

Generated ideas can be exported as JSON.

Example:

```json
  {
    "verb": "Rotate",
    "constraint": "Using the ability also hurts you",
    "pressure": "Time is running out",
    "goal": "Deliver an object",
    "decision": "When is rotating worth taking damage?"
  }
```

This makes saved ideas easy to read, edit, archive, or potentially import into future versions of the tool.

---

## Running From Source

This project is built with Godot 4.

To run it locally:

1. Clone the repository.
1. Open the project in Godot.
1. Open project.godot.
1. Run the project.

The main application scene is located in the scenes directory.

## Project Structure

```text
addons/
assets/
scenes/
scripts/

LICENSE.md
README.md
icon.svg
project.godot
```

Exported builds are not tracked in the repository and are instead published through GitHub Releases.

---

## Why I Made This

This tool started as a small exercise for practicing gameplay design.

A simple mechanic such as:

> "The player can only move in one direction"

can be interesting, but it does not necessarily describe a complete gameplay idea.

Adding a goal, pressure, and meaningful decision helps reveal the actual gameplay:

> What is the player trying to accomplish?
> What makes that difficult?
> Why must they act?
> What tradeoff or decision emerges?

Game Mechanic Generator is intended to make that thought process easier to practice.

---

## Development Status

This project is still evolving.

Current versions focus on lightweight mechanic generation and brainstorming rather than automatically evaluating whether an idea is "good."

Possible future improvements may include:

- Additional mechanic categories
- Better idea organization
- Importing previously exported ideas
- Tags and filtering
- Saved/favorite combinations
- Mechanic variation tools

---

## License

This project is licensed under the MIT License.

See [LICENSE.md](LICENSE.md) for details.
