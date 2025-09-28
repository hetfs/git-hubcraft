---
id: 04-git-config-bootstrap
title: Git Config Bootstrap Scripts
sidebar_position: 6
---

# Git Configuration Bootstrap Scripts

A ready-to-use toolkit for setting up a professional Git environment with modern defaults, **Delta** for beautiful diffs, and **150+ productivity aliases** for faster workflows.

---

## 📋 Overview

These scripts fully automate your Git setup:

* Configure Git with smart defaults (safe, modern, cross-platform).
* Install **Delta** for syntax-highlighted, side-by-side diffs.
* Add **150+ aliases** to cover daily workflows, commits, branching, history, cleanup, and more.

Suitable for both beginners and experienced developers.

---

## 🚀 Quick Start (Run Online)

> ⚠️ **Security Note**
> One-line installs (`curl | bash` or `irm | iex`) are fast and convenient, but they run code directly from the internet.
> **Best practice:** review the script before running it. Use the "Download & Run" method if you prefer a safer approach.

---

### Linux & macOS

#### **Method 1: One-Line Online Install (Quickest)**

```bash
curl -s -O https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh
cat git-config.sh   # 👀 review before running
chmod +x git-config.sh
./git-config.sh
````

#### **Method 2: Download & Run Locally (Safer)**

```bash
# Download the script
curl -s -O https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh

# Review the script (recommended)
cat git-config.sh

# Make it executable and run
chmod +x git-config.sh
./git-config.sh
```

---

### Windows (PowerShell)

#### **Method 1: One-Line Online Install (Quickest)**

```powershell
irm https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1 | iex
```

#### **Method 2: Download & Run Locally (Safer)**

```powershell
# Download the script
curl -o git-config.ps1 https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1

# Review the script
notepad git-config.ps1

# Run the script
.\git-config.ps1

# If you see an execution policy error:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\git-config.ps1
```

---

## ⚙️ Script Options

Both Linux/macOS and Windows scripts support:

```bash
# Interactive setup (default)
./git-config.sh

# Check current config without changes
./git-config.sh --check-only

# Reset Git identity and reconfigure
./git-config.sh --reset

# Dry run: preview changes only
./git-config.sh --dry-run

# Quiet mode
./git-config.sh --quiet

# Help
./git-config.sh --help
```

---

## ✨ What Gets Configured

### 🔑 Core Git Setup

* User identity (name & email)
* Optimized defaults for collaboration
* Cross-platform package manager support (Linux, macOS Homebrew)
* Safe input validation and error handling

### 🎨 Enhanced Experience

* **Delta integration** with syntax highlighting
* **Neovim as default editor** (changeable)
* Performance-tuned paging and file handling
* Smarter workflows (rebasing, auto-setup remote, etc.)

### ⚡ Productivity Aliases

Over 150 aliases, including:

```bash
git s        # Status (compact)
git a        # Add files
git d        # Diff changes
git c        # Commit
git co       # Checkout
git b        # Branch list
git lg       # Graph log
git wip      # Save work-in-progress
git publish  # Push & set upstream
git cleanup  # Clean repo
```

---

## ✅ Verify Installation

After running the script:

```bash
# Check identity
git config --global user.name
git config --global user.email

# View aliases
git aliases

# Test Delta integration
git log -p --oneline -n 2
```

---

## 🆘 Troubleshooting

* **Linux/macOS Permission Denied**

  ```bash
  chmod +x git-config.sh
  ```

* **Windows Execution Policy**

  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope Process
  ```

* **Delta Installation Fails**
  Install manually:

  ```bash
  cargo install git-delta
  ```

  or use your package manager.

---

## 🔧 Customization

* **Add aliases**

  ```bash
  git config --global alias.graph "log --graph --oneline --all"
  ```

* **Change editor**

  ```bash
  git config --global core.editor "code --wait"
  ```

* **Switch Delta theme**

  ```bash
  git config --global delta.syntax-theme "GitHub"
  ```

---

## 📚 Next Steps

1. Run a check:

   ```bash
   ./git-config.sh --check-only
   ```
2. Learn essential aliases (`s`, `d`, `c`, `co`, `lg`).
3. Practice workflows: feature branches, quick commits, history exploration.
4. Customize to fit your projects.

---

**Repository:** [hetfs/git-hubcraft](https://github.com/hetfs/git-hubcraft)
**Author:** Fredaw Lomdo
**License:** MIT
**Feedback:** Issues & contributions welcome!

