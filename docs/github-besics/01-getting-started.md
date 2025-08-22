---
id: 01-getting-started
title: 🚀 Getting Started
sidebar_position: 4
---

# Getting Started

**Git-Hubcraft** is your hands-on guide to mastering **Git** and **GitHub**.
This page walks you through installing Git and configuring your environment for the first time.

---

## 🛠️ Prerequisites

Before you begin, make sure you have:

* **[Git](https://git-scm.com/downloads)** (v2.30+ recommended)
* A **[GitHub account](https://github.com/join)**
* A code editor (e.g., [VS Code](https://code.visualstudio.com/))
* Basic command-line knowledge (helpful, but not required)

Check your installed Git version:

```bash
git --version
````

---

## ✅ Step 1: Install Git

**Linux (Debian/Ubuntu):**

```bash
sudo apt update && sudo apt install git -y
```

**Arch Linux:**

```bash
sudo pacman -S git
```

**macOS:**

```bash
xcode-select --install   # or via Homebrew
brew install git
```

**Windows:**

```bash
winget install -e --id Git.Git
```

---

## ⚙️ Step 2: Configure Git Identity

Run these once (replace with your details):

```bash
git config --global core.editor nvim     # or "code --wait"
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

👉 Recommended defaults:

```bash
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global push.default simple
```

Check your setup:

```bash
git config --list
```

---

## 🛠️ Git Pager Errors (`less`, nvim, and VS Code)

<details>
<summary>Click to expand</summary>

## ❌ The Problem

You might see:

```
error: cannot run less: No such file or directory
fatal: unable to execute pager 'less'
```

👉 Git is trying to use **`less`** as its pager (for commands like `git log`, `git diff`), but it isn’t installed.

---

## ✅ Solutions

**Option 1: Install `less` (recommended)**

```bash
# Debian/Ubuntu
sudo apt install less

# Arch Linux
sudo pacman -S less

# macOS (Homebrew)
brew install less
```

Windows (Git for Windows) already includes `less.exe`.
If missing, reinstall Git or install via MSYS2.

---

**Option 2: Disable the pager**

```bash
git config --global pager.branch false
git config --global pager.status false
git config --global pager.diff false
git config --global core.pager cat
```

➡️ Git will print plain text directly (no scrolling).

---

**Option 3: Run without pager (one-off)**

```bash
git --no-pager log
```

---

## ℹ️ What is `less`?

`less` is a **terminal pager** that makes long output scrollable.

Example:

```bash
cat /etc/services    # dumps everything
less /etc/services   # scrollable + searchable
```

Inside `less`:

* Arrow keys / PgUp / PgDn → scroll
* `/pattern` → search
* `q` → quit

---

## 🔧 Using Neovim as Pager

```bash
git config --global core.pager "nvim -R"
```

* `-R` opens Neovim in read-only mode.
* Quit with `:q`.

Per-command setup:

```bash
git config --global pager.log "nvim -R"
git config --global pager.diff "nvim -R"
git config --global pager.show "nvim -R"
```

⚠️ Avoid in CI/CD scripts → use `--no-pager`.

---

## 🖊️ VS Code as Editor (recommended)

```bash
git config --global core.editor "code --wait"
```

* Opens commit messages in VS Code
* `--wait` ensures Git pauses until you close the file

---

## 📜 VS Code as Pager (not ideal)

```bash
git config --global core.pager "code --wait -"
```

* Opens diffs/logs in new VS Code tabs
* Disrupts terminal flow, slower than `less`/`nvim`

👉 Best practice:
Use **VS Code as editor**, and **`less`, `nvim -R`, or `delta`** as pager.

---

## 🚀 Recommended Setup

```bash
# Use VS Code as editor
git config --global core.editor "code --wait"

# Use delta as pager (modern + pretty)
git config --global core.pager delta
```

👉 [`delta`](https://github.com/dandavison/delta) = modern Git pager with syntax highlighting and side-by-side diffs.

---

## ✅ TL;DR

* Install **`less`** to fix pager errors
* On Windows → already included with Git
* Alternatives:

  * `nvim -R` → Neovim as pager
  * `delta` → modern diff viewer
* **VS Code** → Best as **editor**, not pager

</details>

---

## 🎨 Git Delta: Modern Git Pager

[**git-delta**](https://github.com/dandavison/delta) (aka **delta**) is a modern, syntax-highlighting pager for Git.
It makes diffs, logs, and blame output easy to read, with colors and side-by-side views.

---

## 🔧 Installation

```bash
# macOS
brew install git-delta

# Ubuntu/Debian
sudo apt install git-delta

# Arch Linux
sudo pacman -S git-delta

# Windows
winget install -e --id dandavison.delta
```

Or grab binaries from the [releases page](https://github.com/dandavison/delta/releases).

---

## ⚙️ Basic Git Config

```bash
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Dracula"
```

---

## 🎨 Example `~/.gitconfig`

```ini
[core]
    editor = nvim             # Use Neovim for commits/rebases
    pager = delta             # Use delta for diff/log output

[user]
    name = "your name         # Your Git username
    email = "your email"      # Your Git email (use noreply for privacy)

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true             # n/N to move between hunks
    line-numbers = true         # Show line numbers
    side-by-side = true         # VS Code-style split diffs
    syntax-theme = "Dracula"    # Other options: OneHalfDark, Solarized, GitHub
    decorations = true
    hyperlinks = true
    dark = true

[merge]
    conflictStyle = zdiff3      # Improved merge conflict markers

[diff]
    colorMoved = default        # Highlight moved lines

[init]
    defaultBranch = main

[color]
    ui = auto

[push]
    default = simple

[pager]
    diff = delta
    log = delta
    reflog = delta
    show = delta
```

---

## 🖥️ Usage

```bash
git diff             # syntax-highlighted diff
git show HEAD~1      # show commit with diff
git log -p           # logs with diffs
git blame -L 10,20 file.py  # blame with color
```

➡️ Delta runs automatically if set as `core.pager`.

---

## ⌨️ Navigation Keys (with `navigate = true`)

| Key   | Action              |
| ----- | ------------------- |
| `n`   | Next diff hunk      |
| `N`   | Previous diff hunk  |
| `q`   | Quit pager          |
| `←/→` | Scroll horizontally |

---

## 🎭 Themes

List all available syntax themes:

```bash
delta --show-syntax-themes
```

Apply a theme temporarily:

```bash
git diff --syntax-theme="Dracula"
```

---

## 🔹 Notes for Editors

* **VS Code** → Delta works inside the integrated terminal
* **Neovim** → Works beautifully with `fugitive` or `lazygit.nvim`

✅ Use **delta for diffs in terminal**, and VS Code/Neovim for editing.

---

👉 With **delta + VS Code/Neovim**, you get the best of both worlds:
**clean diffs in terminal + full editor power when needed.**
