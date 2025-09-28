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
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global core.editor nvim     # or "code --wait" for VS Code
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

### 📌 Pager Error Example

If `less` is missing, Git shows:

```
error: cannot run less: No such file or directory
fatal: unable to execute pager 'less'
```

Git defaults to **`less`** for commands like `git log` and `git diff`.

---

## 📜 Common Pagers

A **pager** lets you view long command output one screen at a time.
Git, `man`, and other tools rely on pagers for readability.

Here are the most common pagers (with **Delta recommended** for Git):

---

### 🔹 **less**

* The **standard pager**, used by Git, `man`, and most Unix tools.
* Supports **scrolling forward/backward** and **searching** (`/pattern`).
* Lightweight, fast, and available almost everywhere.
* Likely the pager you’re already using.

👉 Best for: reliable, general-purpose paging with search.

<details>
<summary>less configuration</summary>

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

</details>

---

### 🔹 **more**

* The **oldest and simplest pager**.
* Only allows **forward scrolling**, one page at a time.
* No search or backward navigation.
* Very lightweight but limited.

👉 Best for: minimal systems with only basic paging needs.

**Install `more`:**

```bash
# Debian/Ubuntu
sudo apt install more

# Arch Linux
sudo pacman -S util-linux

# macOS
# Already included with macOS
```

---

### 🔹 **most**

* An **enhanced `more`** with extras.
* Adds **backscrolling**, **color support**, and better multi-file handling.
* Less common but available on many Linux distros.

👉 Best for: users who want colors + backscroll without the full complexity of `less`.

**Install `most`:**

```bash
# Debian/Ubuntu
sudo apt install most

# Arch Linux
sudo pacman -S most

# macOS (Homebrew)
brew install most
```

---

### 🔹 **bat**

* A **pager + syntax highlighter**.
* Shows files/diffs with **highlighting, line numbers, and Git integration**.
* Popular as a modern `cat` replacement.
* Great for previewing code directly in the terminal.

👉 Best for: developers who want clean, highlighted file/diff previews.

🔗 [bat on GitHub](https://github.com/sharkdp/bat)

**Install `bat`:**

```bash
# Debian/Ubuntu
sudo apt install bat

# Arch Linux
sudo pacman -S bat

# macOS (Homebrew)
brew install bat
```

Note: On Debian/Ubuntu, `bat` may install as `batcat`.

---

### 🔹 **delta**

[**Delta**](https://github.com/dandavison/delta) is a **modern pager built for Git**.
It makes diffs, logs, and blame output much easier to read.

* Adds **syntax highlighting**, **line numbers**, and **side-by-side diffs**.
* Great for `git diff` and `git log -p`.
* Highly configurable — navigate hunks with `n` / `N`.

👉 Best for: developers who live in Git and want beautiful, readable diffs.

**Install `delta`:**

```bash
# Debian/Ubuntu
sudo apt install git-delta

# Arch Linux
sudo pacman -S git-delta

# macOS (Homebrew)
brew install git-delta
```

---

## ⚙️ Delta Config

```bash
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Dracula"
```

---

## ⚡ Temporary Overrides

Adjust options per command with `git -c`.

Example: disable line numbers for one commit:

```bash
git -c delta.line-numbers=false show
```

---

## 🎭 Themes

List themes:

```bash
delta --show-syntax-themes
```

Apply one temporarily:

```bash
git diff --syntax-theme="Dracula"
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

## 🖥️ Common Git Commands with Delta

```bash
git diff
# Shows unstaged changes (highlighted by Delta)
```

```bash
git show
# Displays details of the most recent commit with syntax-highlighted diff
```

```bash
git log -p
# Commit history with patch diffs, highlighted and styled
```

```bash
git stash show -p
# Shows saved stash diff in a clean, readable format
```

👉 With **Delta enabled as `core.pager`**, all Git diffs become colorized, structured, and easy to read.

---

✅ With **Delta + your editor**, you get the best of both worlds:
**beautiful diffs in the terminal + powerful editing when needed.**
