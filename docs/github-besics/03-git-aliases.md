---
id: 03-git-aliase
title: Git Aliases
sidebar_position: 6
---

# ⚡ Git Aliases

Git aliases are **shortcuts** that replace long Git commands with shorter ones, making your workflow faster and easier. Instead of typing the full command every time, you define a quick alias that Git will expand automatically.

---

## 🔎 How Git Aliases Work

When you type a Git command:

1. Git first checks if it’s a built-in command.
2. If not, it looks for a matching alias in your Git configuration.
3. If an alias exists, Git replaces it with the command you defined.

This means you can customize Git to match **your personal workflow**.

---

## 🗂️ Types of Git Aliases

* **Local aliases** → apply only to the current repository

  * stored in `.git/config` inside the repo

* **Global aliases** → apply to all repositories for your user

  * stored in `~/.gitconfig`

---

## 📝 Setting Your Preferred Git Editor

Git lets you choose which editor to use when it needs you to write a commit message or edit your configuration. You can set **any editor** (Notepad, VS Code, Vim, Nano, etc.) as the default.

---

## ⚙️ Configure Your Editor

### neovim

```bash title="Terminal"
git config --global core.editor "nvim"
```

### VS Code

```bash title="Terminal"
git config --global core.editor "code --wait"
```

> The `--wait` flag makes Git pause until you finish editing and close the editor.

🔎 Want a different editor? Just search **“Set {editor} as default Git editor”** and replace `{editor}` with your choice (e.g., `nano`, `vim`, `subl`).

---

## 📂 Opening the Git Config File

To edit your global Git configuration file directly, run:

```bash title="Terminal"
git config --global -e
```

This opens `~/.gitconfig` (or its platform equivalent) in your configured editor.

### File Locations

* **macOS** → `~/.gitconfig` (Home → show hidden files with `Cmd + Shift + .`)
* **Linux** → `~/.gitconfig` (Home → show hidden files with `Ctrl + H`)
* **Windows** → `C:\Users\<YourUsername>\.gitconfig` (enable hidden files in Explorer)

---

## 🚀 Adding Git Aliases via Config File

Aliases let you shorten common Git commands. To add them manually:

1. Open your `.gitconfig` file.
2. Add a new `[alias]` section (if it doesn’t exist).
3. Define your shortcuts in the format:

```ini title="~/.gitconfig"
[alias]
  co = checkout
  cob = checkout -b
```

---

### ✅ Example Usage

* `git co main` → runs `git checkout main`
* `git cob feature/123` → runs `git checkout -b feature/123`

> You don’t need to type `git` in the alias definition — Git automatically knows it’s a Git command.

---

## ⚡ Notes

* Any arguments you pass go straight to the underlying command.
* You can add as many aliases as you like.
* Save and close the file — the aliases will be available immediately in your terminal.

---

Do you want me to **combine this editor setup doc with your alias doc** into one single **“Git Configuration Guide”** for Docusaurus (so readers see both editors + aliases in one place), or keep them as separate pages?
## ⚙️ Add Aliases in the CLI

If you want a more streamlined approach to adding Git aliases, you can add them directly from within the terminal/command line.

You create aliases using the `git config` command:

```bash title="Terminal"
git config [--global] alias.<alias_name> "<command>"
```

* Replace `<alias_name>` with the shortcut name.
* Replace `<command>` with the Git command you want to run.
* Use `--global` if you want the alias to work across all repositories.

---

## 🛠️ Examples

### ✅ Status

```bash title="Terminal"
git config --global alias.st "status"
```

Now you can run:

```bash
git st
```

---

### ✅ Branches

```bash title="Terminal"
git config --global alias.br "branch"
```

Usage:

```bash
git br
```

---

### ✅ Pretty Logs

```bash title="Terminal"
git config --global alias.lg "log --oneline --graph --decorate"
```

Usage:

```bash
git lg
```

---

## 📋 Listing All Aliases

To view all the aliases you’ve defined:

```bash title="Terminal"
git config --get-regexp alias
```

This shows every setting in your Git configuration that starts with `alias`.
⚡ With a few aliases, you’ll save keystrokes and speed up your daily Git workflow.

---

## 📌 Extended Git Alias Set

### 🔧 Add with `git config`

```bash
# Starter set (already included)
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.cm "commit -m"
git config --global alias.ca "commit -am"
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.df diff
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "reset HEAD --"

# Rebase helpers
git config --global alias.rb rebase
git config --global alias.rbi "rebase -i"
git config --global alias.rbc "rebase --continue"
git config --global alias.rba "rebase --abort"

# Stash helpers
git config --global alias.ss stash
git config --global alias.ssp "stash pop"
git config --global alias.ssl "stash list"
git config --global alias.ssa "stash apply"

# Cherry-pick / Merge
git config --global alias.cp cherry-pick
git config --global alias.mg merge
git config --global alias.mga "merge --abort"

# Cleanup
git config --global alias.clean "!git clean -fd && git reset --hard"
git config --global alias.prune "fetch --prune"

# Show info
git config --global alias.last "log -1 HEAD"
git config --global alias.who "shortlog -sne"
git config --global alias.lg log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative

```

---

### 📌 Or paste into `~/.gitconfig`

```ini
[alias]
  # Starter
  st = status
  br = branch
  co = checkout
  cm = commit -m
  ca = commit -am
  lg = log --oneline --graph --all --decorate
  df = diff
  undo = reset --soft HEAD~1
  unstage = reset HEAD --

  # Rebase
  rb = rebase
  rbi = rebase -i
  rbc = rebase --continue
  rba = rebase --abort

  # Stash
  ss = stash
  ssp = stash pop
  ssl = stash list
  ssa = stash apply

  # Cherry-pick / Merge
  cp = cherry-pick
  mg = merge
  mga = merge --abort

  # Cleanup
  clean = !git clean -fd && git reset --hard
  prune = fetch --prune

  # Show info
  last = log -1 HEAD
  who = shortlog -sne

```

---

## 🚀 Example Usage

```bash
git rb main      # rebase current branch on main
git rbi HEAD~3   # interactive rebase last 3 commits
git ss           # stash changes
git ssp          # apply & drop last stash
git cp abc123    # cherry-pick commit abc123
git clean        # wipe untracked files + reset
git prune        # remove stale remote branches
git last         # show last commit
git who          # show contributors
```

---

⚡ With this setup, you basically get a **Git power toolkit**.
