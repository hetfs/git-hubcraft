<p align="center">
  <img src="assets/banner.png" alt="Git HubCraft Banner" width="800">
</p>

<h1 align="center">⚡ Git HubCraft</h1>

<p align="center">
  <strong>Master Git & GitHub with Professional Workflows, Automation, and 150+ Productivity Aliases</strong>
</p>

<p align="center">
  <!-- Badges -->
  <a href="https://github.com/hetfs/git-hubcraft/stargazers">
    <img src="https://img.shields.io/github/stars/hetfs/git-hubcraft?style=for-the-badge&logo=github&color=blue" alt="GitHub Stars"/>
  </a>
  <a href="https://github.com/hetfs/git-hubcraft/issues">
    <img src="https://img.shields.io/github/issues/hetfs/git-hubcraft?style=for-the-badge&color=orange" alt="GitHub Issues"/>
  </a>
  <a href="https://github.com/hetfs/git-hubcraft/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/hetfs/git-hubcraft?style=for-the-badge&color=green" alt="MIT License"/>
  </a>
  <a href="https://git-scm.com/">
    <img src="https://img.shields.io/badge/Git-v2.30+-orange?style=for-the-badge&logo=git" alt="Git Version"/>
  </a>
  <a href="https://nodejs.org/">
    <img src="https://img.shields.io/badge/Node.js-v16+-green?style=for-the-badge&logo=nodedotjs" alt="Node.js Version"/>
  </a>
</p>

<p align="center">
  <a href="#-quick-setup">Quick Setup</a> •
  <a href="#-features">Features</a> •
  <a href="#-documentation">Documentation</a> •
  <a href="#-scripts">Scripts</a> •
  <a href="#-contributing">Contributing</a> •
  <a href="#-license">License</a>
</p>

---

## 🎯 What is Git HubCraft?

**Git HubCraft** is a comprehensive ecosystem for mastering Git and GitHub, featuring professional configuration scripts, extensive documentation, and productivity-enhancing tools. Go from Git basics to advanced automation with ready-to-use workflows.

### 🚀 One-Command Professional Setup

```bash
# Transform your Git experience in one command
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash
```

---

## ✨ Key Features

### 🛠️ **Git Configuration Bootstrap**
- **150+ curated aliases** for daily workflow efficiency
- **Delta integration** for beautiful, syntax-highlighted diffs
- **Cross-platform support** (Linux, macOS, Windows)
- **Auto-installation** of Git and Delta if missing
- **Safe dry-run mode** to preview changes

### 📚 **Comprehensive Documentation**
- **Step-by-step tutorials** from basics to advanced
- **Real-world workflows** and best practices
- **Visual guides** and cheat sheets
- **Troubleshooting** common issues

### ⚡ **Productivity Boosters**
```bash
# Essential aliases you'll get
git s           # Compact status
git lg          # Beautiful graph log
git wip         # Save work in progress
git cane        # Amend without editing
git publish     # Push + set upstream
git aliases     # View all 150+ shortcuts
```

### 🔧 **Automation & Security**
- **GitHub Actions** workflows
- **Automated vulnerability detection**
- **CI/CD pipelines**
- **Security scanning** configurations

---

## 🚀 Quick Setup

### For Linux & macOS
```bash
# One-line installation (recommended)
curl -s https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh | bash

# Or download and run manually
curl -s -O https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.sh
chmod +x git-config.sh
./git-config.sh
```

### For Windows
```powershell
# PowerShell one-liner
irm https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1 | iex

# Or download and run
curl -o git-config.ps1 https://raw.githubusercontent.com/hetfs/git-hubcraft/main/scripts/git-config.ps1
.\git-config.ps1
```

### Script Options
```bash
./git-config.sh --check-only    # Verify current setup
./git-config.sh --reset         # Reset and reconfigure
./git-config.sh --dry-run       # Preview changes
./git-config.sh --quiet         # Minimal output
./git-config.sh --help          # Show all options
```

---

## 📖 Documentation

Run the documentation locally to explore all resources:

```bash
# Clone and setup
git clone https://github.com/hetfs/git-hubcraft.git
cd git-hubcraft
npm install
npm run start
```

Then open `http://localhost:3000` in your browser.

### 📚 Documentation Sections

| Section | Description |
|---------|-------------|
| **🏠 Introduction** | Git & GitHub fundamentals |
| **⚡ Git Aliases** | 150+ productivity shortcuts |
| **🛠️ Bootstrap Scripts** | Automated configuration |
| **🌐 Git & GitHub** | Collaboration workflows |
| **🛡️ Security** | Vulnerability detection |
| **🔧 Advanced** | Internals & automation |

---

## 🛠️ Available Scripts

### Configuration Scripts
- [`git-config.sh`](./scripts/git-config.sh) - Main bootstrap script (Linux/macOS)
- [`git-config.ps1`](./scripts/git-config.ps1) - Windows PowerShell version

### Utility Scripts
- [`alias-checker.sh`](./scripts/alias-checker.sh) - Validate alias configurations
- [`config-backup.sh`](./scripts/config-backup.sh) - Backup existing Git config

---

## 🎯 What You'll Master

### Git Fundamentals
- **Installation & Configuration** - Proper setup across platforms
- **Essential Commands** - add, commit, push, pull, status
- **Branching Strategies** - feature branches, GitFlow, GitHub Flow
- **Merge vs Rebase** - When and how to use each

### Advanced Git
- **History Rewriting** - Interactive rebase, commit amendment
- **Conflict Resolution** - Professional merge strategies
- **Git Hooks** - Automated quality checks
- **Submodules & Subtrees** - Managing dependencies

### GitHub Collaboration
- **Pull Requests** - Effective code review workflows
- **Issue Management** - Bug tracking and project organization
- **Team Best Practices** - Code ownership, review standards
- **Open Source Contribution** - Forking and contributing workflow

### Automation & DevOps
- **GitHub Actions** - CI/CD pipelines
- **Security Automation** - Vulnerability scanning
- **Dependency Management** - Dependabot configurations
- **Container Security** - Docker scanning workflows

---

## 🤝 Contributing

We welcome contributions! Whether you're fixing bugs, adding new features, or improving documentation, your help makes Git HubCraft better for everyone.

### How to Contribute

1. **Fork** the repository
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m "Add amazing feature"
   ```
4. **Push to your fork**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Contribution Areas
- 🐛 **Bug fixes** and improvements
- 📚 **Documentation** enhancements
- 🎨 **New aliases** and workflows
- 🔧 **Script improvements**
- 🌐 **Translation** efforts

Please read our [Code of Conduct](./CODE_OF_CONDUCT.md) and [Contributing Guidelines](./CONTRIBUTING.md).

---

## 🏗️ Project Structure

```
git-hubcraft/
├── docs/                 # Documentation source
├── scripts/              # Configuration scripts
│   ├── git-config.sh     # Main bootstrap script
│   ├── git-config.ps1    # Windows PowerShell script
│   └── utilities/        # Helper scripts
├── assets/               # Images and media
├── src/              # Docusaurus configuration
└── package.json          # Node.js dependencies
```

---

## 📊 Stats & Metrics

- **150+ Git Aliases** covering all workflows
- **2 Installation Methods** (Bash & PowerShell)
- **3 Platform Support** (Linux, macOS, Windows)
- **Comprehensive Documentation** with practical examples
- **Active Community** of contributors and users

---

## 🆘 Support & Community

- **📖 Documentation**: Full guides available locally via `npm run start`
- **🐛 Issues**: [Report bugs](https://github.com/hetfs/git-hubcraft/issues)
- **💬 Discussions**: [Join conversations](https://github.com/hetfs/git-hubcraft/discussions)
- **🔧 Script Help**: Use `--help` flag with any script

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](./LICENSE) file for details.

---

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=hetfs/git-hubcraft&type=Date)](https://star-history.com/#hetfs/git-hubcraft&Date)

---

## 🙏 Acknowledgments

- **Git Community** for the incredible version control system
- **GitHub** for amazing collaboration platforms
- **Contributors** who help improve Git HubCraft
- **Users** who provide feedback and suggestions

---

<p align="center">
  <em>Git HubCraft - Mastering the craft of version control and collaboration</em>
</p>

<p align="center">
  <a href="https://github.com/hetfs/git-hubcraft">⭐ Star us on GitHub</a> •
  <a href="https://github.com/hetfs/git-hubcraft/issues">🐛 Report an issue</a> •
  <a href="https://github.com/hetfs/git-hubcraft/discussions">💬 Join discussion</a>
</p>
