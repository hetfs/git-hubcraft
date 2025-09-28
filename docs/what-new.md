---
id: what-new
title: What's New
sidebar_position: 3
---

# What's New

## 🎉 Latest Updates & Features

Welcome to the latest version of Git HubCraft! Here's what's new and improved in our documentation and tools.

---

## 🚀 Recent Major Updates

### 🔄 Git Configuration Bootstrap Script v2.0
**Released: December 2023**

Our flagship script has been completely overhauled with:

- **Fixed BASH_SOURCE issue** - Now works seamlessly when piped to bash
- **Dry-run mode** - Preview changes before applying with `--dry-run` flag
- **Enhanced Delta configuration** - Better colors and syntax highlighting
- **Improved error handling** - More robust installation and setup
- **150+ curated aliases** - Comprehensive coverage of Git workflows

```bash
# Try the new improved script
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash -- --dry-run
```

### 📚 Completely Revamped Documentation
**December 2023 Rewrite**

- **Restructured navigation** - Better organization and flow
- **Enhanced Git Aliases guide** - From basics to power user features
- **New Git & GitHub overview** - Clear explanations for beginners
- **Practical examples** - Real-world workflows and use cases
- **Improved troubleshooting** - Common issues and solutions

---

## 🆕 New Features

### ⚡ Enhanced Git Aliases Collection
We've expanded our alias collection with:

- **Smart commit workflows** - `ca`, `cane`, `caa` for efficient amending
- **Advanced branch management** - `bm`, `bnm`, `bed`, `bsd`
- **Delta integration** - Beautiful diff viewing out of the box
- **Repository utilities** - `initer`, `cloner`, `pruner`, `optimizer`

```bash
# New aliases you can now use
git cane        # Amend commit without editing message
git bnm         # Show unmerged branches
git lg          # Beautiful graph log
git wip         # Save work in progress
```

### 🎨 Delta Configuration Presets
Automatically configured Delta with:

- **Monokai Extended theme** - Professional syntax highlighting
- **Side-by-side view** - Better code review experience
- **Line numbers** - Easy navigation in diffs
- **Enhanced decorations** - Visual improvements throughout

### 🔧 Cross-Platform Support Improvements
- **Better package manager detection** - pacman, apt, dnf, yum, Homebrew
- **Windows PowerShell script** - Native Windows support
- **Improved dependency handling** - Automatic Git and Delta installation

---

## 📖 Documentation Updates

### ✅ New Guides Added

1. **Git Configuration Bootstrap Scripts**
   - Complete setup instructions
   - Troubleshooting guide
   - Usage examples and workflows

2. **Comprehensive Git Aliases Guide**
   - Alias creation methods
   - Categorized alias collections
   - Practical usage scenarios

3. **Git and GitHub Fundamentals**
   - Clear distinction between tools
   - Collaboration workflows
   - Best practices

### 🔄 Updated Content

- **Restructured navigation** - Logical learning path
- **Enhanced code examples** - Copy-paste ready commands
- **Better visual hierarchy** - Improved readability
- **Expanded troubleshooting** - More solutions to common problems

---

## 🐛 Bug Fixes & Improvements

### Script Fixes
- **Resolved BASH_SOURCE error** in piped execution
- **Fixed unbound variable issues** in alias definitions
- **Improved package installation** error handling
- **Better platform detection** logic

### Documentation Fixes
- **Corrected command syntax** throughout guides
- **Fixed code formatting** issues
- **Updated outdated examples**
- **Improved mobile responsiveness**

### Performance Improvements
- **Faster script execution** with optimized checks
- **Reduced redundant operations**
- **Better dependency management**
- **Improved configuration validation**

---

## 🎯 Recently Added Features

### 🆕 Git Workflow Shortcuts
```bash
# Quick feature development
git publish          # Push and set upstream
git unwip            # Restore work in progress
git uncommit         # Soft reset last commit

# Repository management
git track-all        # Track all remote branches
git snapshot         # Timed backup stash
git panic            # Emergency save and clean
```

### 🆕 Delta Enhancements
- **Custom color schemes** for better readability
- **Improved diff highlighting** for moved code
- **Better pager integration** with Git commands
- **Enhanced commit decorations**

### 🆕 Safety Features
- **Input validation** for user information
- **Dry-run mode** for safe experimentation
- **Error recovery** mechanisms
- **Backup prompts** for existing configurations

---

## 📅 Coming Soon

### 🚧 Planned Features

#### Git HubCraft v2.1
- **Interactive alias selector** - Choose which aliases to install
- **Theme customization** - Multiple Delta theme options
- **Profile system** - Different alias sets for different workflows
- **Export/import** - Share your Git configuration

#### Documentation Enhancements
- **Video tutorials** - Visual guides for complex workflows
- **Interactive examples** - Try commands in-browser
- **Cheat sheet generator** - Customizable command references
- **Advanced topics** - Git internals and power user techniques

#### Integration Features
- **VS Code extension** - Git HubCraft integration
- **CI/CD templates** - GitHub Actions for Git workflows
- **Docker images** - Pre-configured development environments
- **Plugin system** - Extensible alias collections

---

## 🔄 Migration Notes

### From Previous Versions
If you're upgrading from an older setup:

1. **Backup your existing configuration**
   ```bash
   cp ~/.gitconfig ~/.gitconfig.backup
   ```

2. **Run the new bootstrap script**
   ```bash
   curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash
   ```

3. **Merge custom settings** from your backup if needed

### Breaking Changes
- **Some alias names** may have changed for consistency
- **Delta configuration** is now more comprehensive
- **Script options** have been expanded and improved

---

## 🎊 Community Contributions

### Recent Community Additions
- **PowerShell script** for Windows users
- **Additional alias suggestions** from users
- **Documentation improvements** and corrections
- **Translation efforts** underway

### How to Contribute
We welcome contributions! Here's how you can help:

1. **Report issues** on GitHub
2. **Suggest new aliases** or improvements
3. **Submit documentation** corrections
4. **Share your workflows** and use cases

Visit our [GitHub repository](https://github.com/hetfs/git-hubcraft) to get involved!

---

## 📊 Statistics & Metrics

### Current Status
- **150+ Git aliases** available
- **2 installation methods** (bash and PowerShell)
- **3 major platforms** supported (Linux, macOS, Windows)
- **Comprehensive documentation** with practical examples

### Usage Growth
- **Script downloads**: Growing steadily
- **Documentation visits**: Increasing monthly
- **Community contributions**: Active and welcome

---

## 🎯 Getting the Latest Version

### Update Your Installation
```bash
# Re-run the bootstrap script
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash

# Or use the reset option to start fresh
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash -- --reset
```

### Check Your Version
```bash
# View your current Git configuration
git config --global --list | head -5

# Test key aliases
git aliases | wc -l  # Should show 150+ aliases
git lg --oneline -3  # Should show formatted log
```

---

## 💬 Feedback & Support

We'd love to hear from you!

- **Found a bug?** [Open an issue](https://github.com/hetfs/git-hubcraft/issues)
- **Have a suggestion?** Start a discussion
- **Want to contribute?** Submit a pull request
- **Need help?** Check our documentation or ask the community

---

## 🎉 Thank You!

Thanks to all our users and contributors for making Git HubCraft better every day. Your feedback and contributions help us create tools that make developers more productive and happy!

**Stay tuned for more updates coming soon!** 🚀
