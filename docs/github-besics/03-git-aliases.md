---
id: 03-git-aliases
title: Git Aliases
sidebar_position: 6
---

# ⚡ Git Aliases

Git aliases are **custom shortcuts** that replace long Git commands with memorable abbreviations, making your workflow faster and more efficient. Instead of typing verbose commands repeatedly, you define simple aliases that Git expands automatically.

---

## 🎯 Why Use Git Aliases?

* **Save time** - Fewer keystrokes for common operations
* **Reduce errors** - Consistent commands across projects
* **Customize workflow** - Tailor Git to your preferences
* **Improve productivity** - Focus on coding, not remembering commands

---

## 🔧 How Git Aliases Work

When you type a Git command:

1. **Git checks** if it's a built-in command
2. **If not found**, searches for matching aliases in your configuration
3. **If alias exists**, expands it to the full command
4. **Executes** the expanded command

This transparent expansion means aliases work exactly like native Git commands.

---

## 📍 Alias Scope

### Local Aliases
* **Scope**: Current repository only
* **Location**: `.git/config` within the repository
* **Use case**: Project-specific workflows

### Global Aliases  
* **Scope**: All repositories for your user
* **Location**: `~/.gitconfig` (user home directory)
* **Use case**: Personal workflow preferences (recommended)

---

## ⚙️ Setting Your Git Editor

Before creating aliases, configure your preferred editor for commit messages and configuration edits:

### Popular Editor Options

```bash title="Terminal"
# Neovim
git config --global core.editor "nvim"

# VS Code
git config --global core.editor "code --wait"

# Vim
git config --global core.editor "vim"

# Nano
git config --global core.editor "nano"

# Sublime Text
git config --global core.editor "subl -w"
```

> **Note**: The `--wait` flag tells Git to pause until you close the editor, ensuring your message is saved.

---

## 📂 Accessing Git Configuration

### Open Config File
```bash title="Terminal"
git config --global -e
```
Opens your global Git configuration in the default editor.

### Config File Locations
* **macOS/Linux**: `~/.gitconfig` 
* **Windows**: `C:\Users\<Username>\.gitconfig`

### View Current Aliases
```bash title="Terminal"
git config --get-regexp alias
```

---

## 🛠️ Creating Aliases

### Method 1: Command Line (Quick)
```bash title="Terminal"
git config --global alias.<shortcut> "<command>"
```

**Examples:**
```bash
git config --global alias.st "status"
git config --global alias.br "branch"
git config --global alias.co "checkout"
```

### Method 2: Edit Config File (Comprehensive)
Open `~/.gitconfig` and add under `[alias]` section:

```ini title="~/.gitconfig"
[alias]
  st = status
  br = branch
  co = checkout
  cm = commit -m
```

---

## 🚀 Essential Alias Collection

### 🔍 Basic Operations
```bash
git config --global alias.st "status"
git config --global alias.br "branch"
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.cm "commit -m"
git config --global alias.ca "commit --amend"
git config --global alias.cane "commit --amend --no-edit"
```

### 📊 Enhanced Viewing
```bash
git config --global alias.lo "log --oneline"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.ll "log --pretty=format:'%C(yellow)%h%Creset %s %Cgreen(%cr) %C(blue)%an%Creset'"
```

### 🔄 Branch Management
```bash
git config --global alias.cob "checkout -b"
git config --global alias.bm "branch --merged"
git config --global alias.bnm "branch --no-merged"
git config --global alias.bd "branch -d"
git config --global alias.bD "branch -D"
```

### 📁 File Operations
```bash
git config --global alias.a "add"
git config --global alias.aa "add --all"
git config --global alias.ap "add --patch"
git config --global alias.d "diff"
git config --global alias.ds "diff --staged"
git config --global alias.dc "diff --cached"
```

---

## ⚡ Power User Aliases

### 🔄 Advanced Workflow
```bash
# Rebase operations
git config --global alias.rb "rebase"
git config --global alias.rbi "rebase -i"
git config --global alias.rbc "rebase --continue"
git config --global alias.rba "rebase --abort"

# Stash management
git config --global alias.ss "stash"
git config --global alias.ssp "stash pop"
git config --global alias.ssl "stash list"
git config --global alias.ssa "stash apply"

# Merge operations
git config --global alias.mg "merge"
git git config --global alias.mga "merge --abort"
git config --global alias.mc "merge --continue"
```

### 🧹 Cleanup & Maintenance
```bash
# Reset operations
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "reset HEAD --"
git config --global alias.uncommit "reset --soft HEAD^"

# Cleanup commands
git config --global alias.cleanup "!git clean -fd && git reset --hard"
git config --global alias.prune "fetch --prune"
git config --global alias.gc "gc --aggressive"
```

### 🔍 Information & Debugging
```bash
git config --global alias.last "log -1 HEAD"
git config --global alias.who "shortlog -sne"
git config --global alias.stats "diff --stat"
git config --global alias.changed "diff --name-only"
git config --global alias.contributors "shortlog -sn --no-merges"
```

---

## 📋 Complete Alias Set for Config File

For a comprehensive setup, add this to your `~/.gitconfig`:

```ini title="~/.gitconfig"
[alias]
  # === Basic Operations ===
  st = status
  br = branch
  co = checkout
  ci = commit
  cm = commit -m
  ca = commit --amend
  cane = commit --amend --no-edit
  
  # === Enhanced Viewing ===
  lo = log --oneline
  lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
  ll = log --pretty=format:'%C(yellow)%h%Creset %s %Cgreen(%cr) %C(blue)%an%Creset'
  lp = log --patch
  
  # === Branch Management ===
  cob = checkout -b
  bm = branch --merged
  bnm = branch --no-merged
  bd = branch -d
  bD = branch -D
  
  # === File Operations ===
  a = add
  aa = add --all
  ap = add --patch
  d = diff
  ds = diff --staged
  dc = diff --cached
  
  # === Advanced Workflow ===
  rb = rebase
  rbi = rebase -i
  rbc = rebase --continue
  rba = rebase --abort
  ss = stash
  ssp = stash pop
  ssl = stash list
  ssa = stash apply
  mg = merge
  mga = merge --abort
  mc = merge --continue
  
  # === Cleanup & Maintenance ===
  undo = reset --soft HEAD~1
  unstage = reset HEAD --
  uncommit = reset --soft HEAD^
  cleanup = !git clean -fd && git reset --hard
  prune = fetch --prune
  
  # === Information & Debugging ===
  last = log -1 HEAD
  who = shortlog -sne
  stats = diff --stat
  changed = diff --name-only
  contributors = shortlog -sn --no-merges
  aliases = !git config --get-regexp alias
```

---

## 🎯 Practical Usage Examples

### Daily Development Workflow
```bash
# Start new feature
git cob feature/user-auth
git aa
git cm "Add user authentication"

# Quick fixes
git cane                    # Amend without editing
git ca -m "Better message" # Amend with new message

# Review changes
git lg -10                 # Graph view of recent commits
git ds                     # See staged changes
```

### Branch Management
```bash
# Clean up branches
git bm                     # See merged branches (safe to delete)
git bnm                    # See unmerged branches
git bd feature/old-branch  # Delete merged branch

# Interactive rebase
git rbi HEAD~3             # Rebase last 3 commits
```

### Maintenance Tasks
```bash
# Clean working directory
git cleanup                # Reset and clean untracked files
git prune                  # Remove stale remote references

# Get information
git last                   # Show most recent commit
git who                    # See contributor statistics
git aliases                # List all configured aliases
```

---

## 💡 Pro Tips

### 1. **Start Small**
Begin with 5-10 essential aliases and gradually add more as needed.

### 2. **Use Memorable Names**
Choose aliases that make sense to you:
- `st` for status
- `co` for checkout  
- `br` for branch
- `lg` for log graph

### 3. **Test Aliases**
After creating an alias, test it in a safe repository first.

### 4. **Share Your Setup**
Keep your `.gitconfig` in version control to sync across machines.

### 5. **Combine with Shell Aliases**
For even faster workflows, create shell aliases:
```bash
# Add to .bashrc or .zshrc
alias g="git"
alias gst="git st"
alias gco="git co"
```

---

## 🆘 Troubleshooting

### Alias Not Working?
1. **Check spelling** - Verify alias name and command
2. **Verify scope** - Use `--global` for user-wide aliases
3. **Restart terminal** - Some changes require new terminal session

### View All Aliases
```bash
git config --get-regexp alias
```

### Remove an Alias
```bash
git config --global --unset alias.<name>
```

### Edit Aliases
```bash
git config --global -e  # Opens config in editor
```

---

## 🚀 Next Steps

1. **Start** with basic status, branch, and commit aliases
2. **Add** log and diff aliases for better visualization
3. **Incorporate** advanced workflow aliases as needed
4. **Customize** further based on your specific workflow

With these aliases, you'll transform Git from a verbose command-line tool into a personalized productivity powerhouse!

---

**💬 Tip**: The Git Configuration Bootstrap Script can automatically set up these aliases and more. Check out the [Git Bootstrap Scripts](/docs/github-besics/04-git-config-bootstrap.md) guide for one-click setup.
