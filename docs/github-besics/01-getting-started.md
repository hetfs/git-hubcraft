---
id: 01-getting-started
title: 🚀 Getting Started
sidebar_position: 4
---

# Getting Started

**Git-Hubcraft** is your hands-on guide to mastering **Git** and **GitHub**.
This page walks you through installing Git, configuring your environment, and fixing common setup issues.

---

## 🛠️ Prerequisites

Before you begin, make sure you have:

* **[Git](https://git-scm.com/downloads)** (v2.30+ recommended)
* A **[GitHub account](https://github.com/join)**
* A code editor (e.g., [VS Code](https://code.visualstudio.com/))
* Basic command-line knowledge (helpful, but not required)

Check your Git version:

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

Check your configuration:

```bash
git config --list
```

---

## 🛠️ Git Pager Errors (`less`, Neovim, VS Code)

<details>
<summary>Click to expand</summary>

### ❌ Problem

You might see:

```
error: cannot run less: No such file or directory
fatal: unable to execute pager 'less'
```

Git defaults to **`less`** as its pager (for commands like `git log`, `git diff`). If `less` is missing, you’ll get errors.

---

### ✅ Solutions

**Option 1: Install `less` (recommended)**

```bash
# Debian/Ubuntu
sudo apt install less

# Arch Linux
sudo pacman -S less

# macOS (Homebrew)
brew install less
```

Windows Git already includes `less.exe`. If missing, reinstall Git or use MSYS2.

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

### ℹ️ What is `less`?

A **terminal pager** that makes long output scrollable.

```bash
cat /etc/services    # dumps everything
less /etc/services   # scrollable + searchable
```

Inside `less`:

* Arrows / PgUp / PgDn → scroll
* `/pattern` → search
* `q` → quit

---

### 🔧 Neovim as Pager

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

⚠️ Avoid in CI/CD → use `--no-pager`.

---

### 🖊️ VS Code as Editor (recommended)

```bash
git config --global core.editor "code --wait"
```

* Opens commit messages in VS Code
* `--wait` makes Git pause until you close the file

---

### 📜 VS Code as Pager (not ideal)

```bash
git config --global core.pager "code --wait -"
```

* Opens diffs/logs in VS Code tabs
* Disrupts terminal flow, slower than `less`/`nvim`

👉 Best practice:
Use **VS Code as editor**, and **`less`, `nvim -R`, or `delta`** as pager.

---

### 🚀 Recommended Setup

```bash
# Use VS Code as editor
git config --global core.editor "code --wait"

# Use delta as pager (modern + pretty)
git config --global core.pager delta
```

👉 [`delta`](https://github.com/dandavison/delta) = modern Git pager with syntax highlighting and side-by-side diffs.

---

### ✅ TL;DR

* Install **`less`** to fix pager errors
* Windows → already included
* Alternatives:

  * `nvim -R` → Neovim as pager
  * `delta` → modern diff viewer
* **VS Code** → best as **editor**, not pager

</details>

---

## 🎨 Git Delta: Modern Pager

[**Delta**](https://github.com/dandavison/delta) is a syntax-highlighting pager for Git.
It makes diffs, logs, and blame output much easier to read.

---

## 🖥️ Common Git Commands with Delta

```bash
git diff
# Shows changes in your working directory that haven't been staged yet
# Delta makes this output syntax-highlighted and easier to read
```

```bash
git show
# Displays details of the most recent commit (or a specific commit if provided)
# Includes commit message + diff, beautifully styled with Delta
```

```bash
git log -p
# Shows commit history along with the patch (diff) for each commit
# Delta highlights changes and makes long logs much more readable
```

```bash
git stash show -p
# Shows what was saved in your most recent stash (the -p includes the diff)
# Delta formats the diff so you can quickly review stashed changes
```

👉 With Delta, all of these commands produce **colorized, syntax-highlighted, and structured diffs** instead of the plain default Git output.

➡️ Works automatically once set as `core.pager`.

---

## ⚡ Temporary Overrides

Disable or adjust options per command with `git -c`.
Example: show a commit without line numbers:

```bash
git -c delta.line-numbers=false show
```

---

## ⚙️ Basic Config

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

## ⌨️ Navigation Keys (with `navigate = true`)

| Key   | Action              |
| ----- | ------------------- |
| `n`   | Next diff hunk      |
| `N`   | Previous diff hunk  |
| `q`   | Quit pager          |
| `←/→` | Scroll horizontally |

---

## 🎭 Themes

List available syntax themes:

```bash
delta --show-syntax-themes
```

Apply one temporarily:

```bash
git diff --syntax-theme="Dracula"
```

---

## 🖥️ Editor Notes

* **VS Code** → Delta works in the integrated terminal
* **Neovim** → Great with `fugitive` or `lazygit.nvim`

👉 Use **Delta for diffs in terminal**, and **VS Code/Neovim for editing**.

---

✅ With **Delta + your favorite editor**, you get the best of both worlds:
**clean diffs in the terminal + powerful editing when needed.**
