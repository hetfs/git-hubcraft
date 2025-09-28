---
id: 04-git-config-boostrap.md
title: Git Bootstrap Scripts 
sidebar_position: 6
---

# Git Configuration Bootstrap Scripts

A comprehensive set of scripts to set up a professional Git development environment with optimized defaults, Delta for enhanced diff viewing, and an extensive collection of productivity aliases.

## 📋 Overview

These scripts provide a complete Git productivity environment suitable for both beginners and experienced developers. They automate the setup of Git configuration, install necessary tools, and configure 150+ carefully crafted aliases covering all Git workflows.

## 🚀 Quick Start

### For Linux & macOS Users

#### **Method 1: Download & Run Directly (Recommended)**
```bash
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash
```

#### **Method 2: Download, Inspect, Then Run**
```bash
# Download the script
curl -s -O https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh

# (Optional) Review the script
cat git-config.sh

# Make executable and run
chmod +x git-config.sh
./git-config.sh
```

### For Windows Users

#### **Method 1: Run from PowerShell (Recommended)**
```powershell
irm https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1 | iex
```

#### **Method 2: Download, Then Run**
```powershell
# Download the script
curl -o git-config.ps1 https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1

# Run the script
.\git-config.ps1

# If you get execution policy error, run:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\git-config.ps1
```

## 🎯 Script Options

Both scripts support the following command-line options:

```bash
# Full interactive setup (default)
./git-config.sh

# Check current configuration without changes
./git-config.sh --check-only

# Reset Git identity and reconfigure
./git-config.sh --reset

# Suppress non-essential output
./git-config.sh --quiet

# Show help information
./git-config.sh --help
```

## ✨ Features

### Core Configuration
- **Git Identity Setup**: Interactive configuration of user name and email
- **Sensible Defaults**: Optimized Git settings for modern development
- **Cross-Platform Support**: Linux (pacman, apt, dnf, yum) and macOS (Homebrew)
- **Safety Features**: Error handling and input validation

### Enhanced Tooling
- **Delta Integration**: Beautiful, syntax-highlighted diffs with side-by-side view
- **Neovim Integration**: Sets Neovim as the default Git editor
- **Performance Optimizations**: Many-files feature and efficient paging

### Alias Ecosystem (150+ Aliases)

#### 🔧 Basic Operations
```bash
git a           # Add files
git s           # Compact status
git d           # View changes
git c           # Commit
git co          # Checkout
git b           # Branch management
```

#### 📝 Advanced Commit Workflows
```bash
git ca          # Amend last commit
git cam "msg"   # Amend with new message
git cane        # Amend without editing message
git caa         # Amend including all changes
```

#### 🌿 Branch Management
```bash
git bm          # Show merged branches
git bnm         # Show unmerged branches
git bed         # Edit branch description
git bsd         # Show branch description
```

#### 📊 Enhanced Viewing
```bash
git lg          # Graph log with pretty formatting
git lo          # One-line commit history
git lp          # Log with patch preview
git dc          # View staged changes
```

#### 🔄 Workflow Tools
```bash
git wip         # Save work in progress
git unwip       # Restore work in progress
git uncommit    # Soft reset last commit
git publish     # Push and set upstream
```

#### 🛠️ Utility Commands
```bash
git aliases     # View all configured aliases
git cleanup     # Clean working directory
git snapshot    # Create timed backup stash
git panic       # Emergency save and clean
```

## 🛠️ Delta Configuration

The script automatically configures Delta with:
- **Side-by-side diff view**
- **Syntax highlighting** (Monokai Extended theme)
- **Line numbers** and navigation
- **Enhanced commit decorations**
- **Interactive diff filtering**

## 📁 Repository Management

```bash
git initer      # Initialize repo with empty commit
git cloner      # Clone with submodules
git pruner      # Aggressive repository cleanup
git optimizer   # Complete repository optimization
```

## 🔍 Verification

After running the script, verify your configuration:

```bash
# Check Git identity
git config --global user.name
git config --global user.email

# View all aliases
git aliases

# Check core configuration
git config --global --list

# Test Delta integration
git log -p --oneline -n 3
```

## 🎪 Useful Workflow Examples

### Daily Development
```bash
git co -b feature/new-feature    # Create and switch to new branch
git aa                           # Add all changes
git cm "Implement new feature"   # Commit with message
git publish                      # Push to remote
```

### Code Review
```bash
git lg -n 20                    # Review recent history
git d filename                  # Check specific file changes
git dc                          # Review staged changes
```

### Maintenance
```bash
git bnm                         # Find unmerged branches
git pruner                      # Clean up repository
git cleanup                     # Reset working directory
```

## 🆘 Troubleshooting

### Common Issues

**Permission Denied (Linux/macOS):**
```bash
chmod +x git-config.sh
```

**PowerShell Execution Policy (Windows):**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

**Delta Not Installed:**
- The script will attempt to install Delta automatically
- Manual installation: `cargo install git-delta`

**Editor Configuration:**
- Default editor is set to Neovim
- Change with: `git config --global core.editor "your-editor"`

### Getting Help

View all configured aliases:
```bash
git aliases
```

Edit global Git configuration:
```bash
git config --global -e
```

Check script options:
```bash
./git-config.sh --help
```

## 📝 Post-Installation

### Recommended Next Steps
1. **Verify configuration** with `git config --global --list`
2. **Test common aliases** like `git s`, `git lg`, `git d`
3. **Customize further** by editing `~/.gitconfig`
4. **Explore workflow** with the alias cheat sheet

### Customization
The scripts create a solid foundation that you can extend:
```bash
# Add custom aliases
git config --global alias.myalias "command"

# Modify Delta themes
git config --global delta.syntax-theme "DifferentTheme"
```

---

**Repository**: https://github.com/hetfs/git-hubcraft
**Author**: Fredaw Lomdo
**License**: MIT
