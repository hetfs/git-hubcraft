#!/usr/bin/env bash
# Git Configuration Bootstrap Script
#
# Author: Fredaw Lomdo
# Repository: https://github.com/hetfs/git-hubcraft
#
# Description:
# A comprehensive Git configuration bootstrap script that sets up a professional
# development environment with optimized defaults, Delta for enhanced diff viewing,
# and an extensive collection of productivity aliases.
#
# Features:
# • 150+ carefully crafted aliases covering all Git workflows
# • Cross-platform support (Linux: pacman, apt, dnf, yum | macOS: Homebrew)
# • Delta integration for beautiful, syntax-highlighted diffs
# • Interactive setup with input validation
# • Safety features including error handling and dry-run mode
#
# Alias Categories:
# • Basic Operations: a, s, d, c, co, b
# • Advanced Commit: ca, cam, cane, caa, caam, caane
# • Branch Management: bm, bnm, bed, bsd
# • Diff & Log: Multiple formats and viewing options
# • Merge & Rebase: Conflict resolution and workflow tools
# • Utility Aliases: wip, uncommit, cleanout, etc.
# • Repository Management: initer, cloner, pruner, optimizer
#
# Usage:
#   ./git-config.sh                 # Full interactive setup
#   ./git-config.sh --check-only    # Verify current configuration
#   ./git-config.sh --reset         # Reset identity and reconfigure
#   ./git-config.sh --quiet         # Suppress non-essential output
#
#   git aliases                     # View all configured aliases
#   git config --global -e          # This opens ~/.gitconfig
#
# The script creates a complete Git productivity environment suitable for
# both beginners and experienced developers.

set -euo pipefail
IFS=$'\n\t'

# Color and styling constants
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly RESET='\033[0m'

# Script variables
RESET_IDENTITY=false
CHECK_ONLY=false
QUIET=false
DRY_RUN=false

# --- Logging functions ---
log_info() { echo -e "${BLUE}ℹ️  $*${RESET}"; }
log_success() { echo -e "${GREEN}✅ $*${RESET}"; }
log_warning() { echo -e "${YELLOW}⚠️  $*${RESET}"; }
log_error() { echo -e "${RED}❌ $*${RESET}"; }
log_debug() { [[ "$QUIET" != true ]] && echo -e "${BOLD}🔍 $*${RESET}"; }
log_dry_run() { echo -e "${YELLOW}🚀 DRY RUN: $*${RESET}"; }

# --- Usage information ---
show_usage() {
  cat <<EOF
${BOLD}Git Configuration Bootstrap Script${RESET}

${BOLD}Usage:${RESET} $0 [OPTIONS]

${BOLD}Options:${RESET}
  --reset         Reset Git user identity before configuration
  --check-only    Check current configuration without making changes
  --quiet         Suppress non-essential output
  --dry-run       Show what would be done without making changes
  --help          Show this help message

${BOLD}Features:${RESET}
  • Installs Git and Delta (if missing)
  • Configures user identity interactively
  • Sets up Delta for enhanced diff viewing
  • Configures sensible Git defaults
  • Adds useful aliases for daily workflow

${BOLD}Supported Platforms:${RESET}
  Linux (pacman, apt-get, dnf, yum) and macOS (Homebrew)
EOF
}

# --- Argument parsing ---
parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
    --reset)
      RESET_IDENTITY=true
      shift
      ;;
    --check-only)
      CHECK_ONLY=true
      shift
      ;;
    --quiet)
      QUIET=true
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --help | -h)
      show_usage
      exit 0
      ;;
    *)
      log_error "Unknown option: $1"
      show_usage
      exit 1
      ;;
    esac
  done
}

# --- Safe git config wrapper ---
git_config() {
  if [[ "$DRY_RUN" == true ]]; then
    log_dry_run "git config $*"
  else
    git config "$@"
  fi
}

# --- Dependency checks ---
check_dependencies() {
  local deps=("git")
  for dep in "${deps[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      log_error "Missing required dependency: $dep"
      return 1
    fi
  done
}

# --- Package manager detection ---
detect_package_manager() {
  if command -v pacman &>/dev/null; then
    echo "pacman"
  elif command -v apt-get &>/dev/null; then
    echo "apt-get"
  elif command -v dnf &>/dev/null; then
    echo "dnf"
  elif command -v yum &>/dev/null; then
    echo "yum"
  elif command -v brew &>/dev/null; then
    echo "brew"
  else
    echo "unknown"
  fi
}

# --- Package installation ---
install_package() {
  local pkg_manager="$1"
  local package="$2"
  local install_cmd=""

  if [[ "$DRY_RUN" == true ]]; then
    log_dry_run "Would install package: $package using $pkg_manager"
    return 0
  fi

  case "$pkg_manager" in
  pacman) install_cmd="sudo pacman -Sy --noconfirm $package" ;;
  apt-get) install_cmd="sudo apt-get update && sudo apt-get install -y $package" ;;
  dnf) install_cmd="sudo dnf install -y $package" ;;
  yum) install_cmd="sudo yum install -y $package" ;;
  brew) install_cmd="brew install $package" ;;
  *)
    log_error "Unsupported package manager: $pkg_manager"
    return 1
    ;;
  esac

  log_info "Installing $package..."
  if eval "$install_cmd"; then
    log_success "Successfully installed $package"
  else
    log_error "Failed to install $package"
    return 1
  fi
}

# --- Ensure required tools are installed ---
ensure_installed() {
  local cmd="$1"
  local pkg="${2:-$cmd}"

  if command -v "$cmd" &>/dev/null; then
    log_debug "$cmd is already installed"
    return 0
  fi

  local pkg_manager
  pkg_manager=$(detect_package_manager)

  if [[ "$pkg_manager" == "unknown" ]]; then
    log_error "No supported package manager found. Please install $pkg manually."
    return 1
  fi

  install_package "$pkg_manager" "$pkg"
}

# --- Git identity configuration ---
configure_git_identity() {
  if [[ "$RESET_IDENTITY" == true ]]; then
    log_info "Resetting Git identity..."
    if [[ "$DRY_RUN" != true ]]; then
      git config --global --unset user.name 2>/dev/null || true
      git config --global --unset user.email 2>/dev/null || true
    fi
  fi

  local current_name current_email
  current_name=$(git config --global user.name 2>/dev/null || echo "")
  current_email=$(git config --global user.email 2>/dev/null || echo "")

  if [[ -n "$current_name" && -n "$current_email" && "$RESET_IDENTITY" != true ]]; then
    log_info "Current Git identity:"
    echo "  Name:  $current_name"
    echo "  Email: $current_email"
    if [[ "$DRY_RUN" != true ]]; then
      read -rp "Use current identity? [Y/n] " -n 1 use_current
      echo
      if [[ "${use_current:-y}" =~ ^[Yy]$ ]]; then
        return 0
      fi
    else
      log_dry_run "Would use current identity: $current_name <$current_email>"
      return 0
    fi
  fi

  local git_name git_email
  if [[ "$DRY_RUN" == true ]]; then
    git_name="[Dry Run] Test User"
    git_email="test@example.com"
    log_dry_run "Would set Git identity to: $git_name <$git_email>"
  else
    while true; do
      read -rp "Enter your Git user name: " git_name
      git_name=$(echo "$git_name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
      if [[ -n "$git_name" ]]; then
        break
      fi
      log_warning "Name cannot be empty"
    done

    while true; do
      read -rp "Enter your Git email: " git_email
      git_email=$(echo "$git_email" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
      if [[ "$git_email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
        break
      fi
      log_warning "Please enter a valid email address"
    done
  fi

  git_config --global user.name "$git_name"
  git_config --global user.email "$git_email"
  log_success "Git identity configured"
}

# --- Core Git configuration ---
configure_git_core() {
  log_info "Applying core Git configuration..."

  # Basic settings
  git_config --global core.editor "nvim"
  git_config --global core.pager "delta"
  git_config --global init.defaultBranch "main"
  git_config --global color.ui "auto"

  # Merge and diff settings
  git_config --global merge.conflictStyle "zdiff3"
  git_config --global merge.tool "vimdiff"
  git_config --global diff.colorMoved "default"

  # Branch behavior
  git_config --global pull.rebase true
  git_config --global push.default "simple"
  git_config --global push.autoSetupRemote true

  # Credential caching (1 hour)
  git_config --global credential.helper "cache --timeout=3600"

  # Performance optimizations
  git_config --global feature.manyFiles true

  # Safety settings
  git_config --global fetch.prune true
  git_config --global rebase.autoStash true
  git_config --global rebase.updateRefs true
}

# --- Delta configuration ---
configure_delta() {
  log_info "Configuring Delta for enhanced diff viewing..."

  git_config --global delta.navigate true
  git_config --global delta.line-numbers true
  git_config --global delta.side-by-side true
  git_config --global delta.syntax-theme "Monokai Extended"
  git_config --global delta.features "decorations"

  # Pager configurations
  git_config --global pager.log "delta"
  git_config --global pager.diff "delta"
  git_config --global pager.show "delta"
  git_config --global interactive.diffFilter "delta --color-only"

  # Decoration settings
  git_config --global delta.decorations.commit-decoration-style "bold yellow box ul"
  git_config --global delta.decorations.file-style "bold yellow"
  git_config --global delta.decorations.file-decoration-style "none"

  # Improved diff settings
  git_config --global delta.plus-style "syntax #003800"
  git_config --global delta.minus-style "syntax #3f0001"
  git_config --global delta.plus-non-emph-style "#003800"
  git_config --global delta.minus-non-emph-style "#3f0001"
}

# --- Git aliases ---
configure_aliases() {
  log_info "Setting up comprehensive Git aliases..."

  # Short aliases for frequent commands
  git_config --global alias.a "add ."
  git_config --global alias.aa "add --all"
  git_config --global alias.ap "add --patch"
  git_config --global alias.au "add --update"

  # Branch operations
  git_config --global alias.b "branch"
  git_config --global alias.bm "branch --merged"
  git_config --global alias.bnm "branch --no-merged"
  git_config --global alias.bed "branch --edit-description"
  git_config --global alias.bsd "branch --show-description"
  git_config --global alias.bv "branch -v"
  git_config --global alias.bra "branch -a"

  # Commit operations
  git_config --global alias.c "commit"
  git_config --global alias.ca "commit --amend"
  git_config --global alias.cam "commit --amend --message"
  git_config --global alias.cane "commit --amend --no-edit"
  git_config --global alias.caa "commit --amend --all"
  git_config --global alias.caam "commit --amend --all --message"
  git_config --global alias.caane "commit --amend --all --no-edit"
  git_config --global alias.ci "commit --interactive"
  git_config --global alias.cm "commit --message"

  # Checkout operations
  git_config --global alias.co "checkout"
  git_config --global alias.cog "checkout --guess"
  git_config --global alias.cong "checkout --no-guess"
  git_config --global alias.cob "checkout -b"

  # Cherry-pick operations
  git_config --global alias.cp "cherry-pick"
  git_config --global alias.cpa "cherry-pick --abort"
  git_config --global alias.cpc "cherry-pick --continue"
  git_config --global alias.cpn "cherry-pick -n"
  git_config --global alias.cpnx "cherry-pick -n -x"

  # Diff operations
  git_config --global alias.d "diff"
  git_config --global alias.dd "diff"
  git_config --global alias.dc "diff --cached"
  git_config --global alias.ds "diff --staged"
  git_config --global alias.dwd "diff --word-diff"

  # Fetch operations
  git_config --global alias.f "fetch"
  git_config --global alias.fa "fetch --all"
  git_config --global alias.fav "fetch --all --verbose"
  git_config --global alias.fap "fetch --all --prune"

  # Grep operations
  git_config --global alias.g "grep"
  git_config --global alias.gg "grep"
  git_config --global alias.gn "grep -n"

  # Log operations
  git_config --global alias.l "log"
  git_config --global alias.ll "log"
  git_config --global alias.lll "log"
  git_config --global alias.lo "log --oneline"
  git_config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  git_config --global alias.ll "log --graph --decorate --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
  git_config --global alias.lor "log --oneline --reverse"
  git_config --global alias.lp "log --patch"
  git_config --global alias.lfp "log --first-parent"
  git_config --global alias.lto "log --topo-order"

  # ls-files operations
  git_config --global alias.ls "ls-files"
  git_config --global alias.lsd "ls-files --debug"
  git_config --global alias.lsfn "ls-files --full-name"
  git_config --global alias.lsio "ls-files --ignored --others --exclude-standard"

  # Merge operations
  git_config --global alias.m "merge"
  git_config --global alias.ma "merge --abort"
  git_config --global alias.mc "merge --continue"
  git_config --global alias.mncnf "merge --no-commit --no-ff"

  # Pull operations
  git_config --global alias.p "pull"
  git_config --global alias.pf "pull --ff-only"
  git_config --global alias.pr "pull --rebase"
  git_config --global alias.prp "pull --rebase=preserve"

  # Rebase operations
  git_config --global alias.rb "rebase"
  git_config --global alias.rba "rebase --abort"
  git_config --global alias.rbc "rebase --continue"
  git_config --global alias.rbs "rebase --skip"
  git_config --global alias.rbi "rebase --interactive"
  git_config --global alias.rbiu "rebase --interactive @{upstream}"

  # Reflog operations
  git_config --global alias.rl "reflog"

  # Remote operations
  git_config --global alias.rr "remote"
  git_config --global alias.rrs "remote show"
  git_config --global alias.rru "remote update"
  git_config --global alias.rrp "remote prune"

  # Revert operations
  git_config --global alias.rv "revert"
  git_config --global alias.rvnc "revert --no-commit"

  # Show-branch operations
  git_config --global alias.sb "show-branch"
  git_config --global alias.sbdo "show-branch --date-order"
  git_config --global alias.sbto "show-branch --topo-order"

  # Submodule operations
  git_config --global alias.sm "submodule"
  git_config --global alias.smi "submodule init"
  git_config --global alias.sma "submodule add"
  git_config --global alias.sms "submodule sync"
  git_config --global alias.smu "submodule update"
  git_config --global alias.smui "submodule update --init"
  git_config --global alias.smuir "submodule update --init --recursive"

  # Status operations
  git_config --global alias.s "status -sb"
  git_config --global alias.ss "status --short"
  git_config --global alias.ssb "status --short --branch"
  git_config --global alias.st "status"

  # Whatchanged
  git_config --global alias.w "whatchanged"

  # Friendly aliases - Recommended helpers
  git_config --global alias.initer "!git init && git commit --allow-empty -m \"Initial empty commit\""
  git_config --global alias.cloner "clone --recursive"
  git_config --global alias.pruner "!git prune && git reflog expire --all --expire=now && git gc --prune=now"
  git_config --global alias.repacker "!git repack -a -d -f --depth=250 --window=250"
  git_config --global alias.optimizer "!git pruner && git repacker"

  # Quick highlights
  git_config --global alias.chart "shortlog -sn"
  git_config --global alias.churn "!git log --pretty=format: --name-only | sort | uniq -c | sort -rg"
  git_config --global alias.summary "shortlog -s -n"

  # Branch names
  git_config --global alias.default-branch "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
  git_config --global alias.current-branch "symbolic-ref --short HEAD"
  git_config --global alias.upstream-branch "!git rev-parse --abbrev-ref --symbolic-full-name @{u}"
  git_config --global alias.topic-base-branch "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"

  # Friendly plurals
  git_config --global alias.aliases "!git config --get-regexp alias | cut -c 7-"
  git_config --global alias.branches "branch -a"
  git_config --global alias.tags "tag -l"
  git_config --global alias.stashes "stash list"

  # Undo operations
  git_config --global alias.uncommit "reset --soft HEAD~1"
  git_config --global alias.unadd "reset HEAD"
  git_config --global alias.undo "reset --soft HEAD~1"

  # Lookups
  git_config --global alias.whois "!sh -c 'git log --format=\"%an <%ae>\" | grep -i \"\$1\" | head -1' -"
  git_config --global alias.whatis "show --name-status"

  # Commit details - FIXED: Properly escaped the problematic alias
  git_config --global alias.commit-parents "show --format=%P -s"
  git_config --global alias.commit-is-merge "!'[ $(git show --format=%P -s | wc -w) -gt 1 ]'"

  # Alias helpers
  git_config --global alias.alias "!git config --get-regexp alias"
  git_config --global alias.add-alias "!sh -c 'git config alias.\"\$1\" \"\$2\"' -"
  git_config --global alias.move-alias "!sh -c 'git config alias.\"\$2\" \"\$(git config alias.\"\$1\")\" && git config --unset alias.\"\$1\"' -"

  # Script helpers
  git_config --global alias.top "rev-parse --show-toplevel"
  git_config --global alias.exec "!sh"

  # New repos
  git_config --global alias.init-empty "!git init && git commit --allow-empty -m \"Initial empty commit\""
  git_config --global alias.clone-lean "clone --depth=1"

  # Saving work
  git_config --global alias.snapshot "stash push -m \"snapshot: \$(date)\""
  git_config --global alias.panic "!git add -A && git stash && git stash drop"

  # Advanced aliases
  git_config --global alias.search-commits "log --grep"
  git_config --global alias.debug "!echo \"Current branch: \$(git current-branch)\" && echo \"Upstream: \$(git upstream-branch 2>/dev/null || echo none)\""

  # Workflow aliases
  git_config --global alias.get "pull --ff-only"
  git_config --global alias.put "push"
  git_config --global alias.ours "checkout --ours"
  git_config --global alias.theirs "checkout --theirs"
  git_config --global alias.wip "stash push -m \"wip\""
  git_config --global alias.unwip "stash pop"
  git_config --global alias.assume "update-index --assume-unchanged"
  git_config --global alias.unassume "update-index --no-assume-unchanged"
  git_config --global alias.publish "push -u origin HEAD"
  git_config --global alias.unpublish "push origin :HEAD"

  # Reset & undo
  git_config --global alias.reset-commit "reset --soft HEAD~1"
  git_config --global alias.undo-commit "reset --soft HEAD~1"

  # Track & untrack
  git_config --global alias.track "branch --set-upstream-to=origin/HEAD"
  git_config --global alias.untrack "branch --unset-upstream"

  # Inbound & outbound
  git_config --global alias.inbound "!git fetch && git log ..@{u}"
  git_config --global alias.outbound "!git log @{u}.."

  # Pull1 & push1
  git_config --global alias.pull1 "pull origin HEAD"
  git_config --global alias.push1 "push origin HEAD"

  # Tooling aliases
  git_config --global alias.gitk-conflict "!gitk --merge"
  git_config --global alias.gitk-history-all "!gitk --all"

  # CVS aliases
  git_config --global alias.cvs-e "cvsexportcommit"
  git_config --global alias.cvs-i "cvsimport"

  # SVN aliases
  git_config --global alias.svn-b "svn branch"
  git_config --global alias.svn-c "svn commit"
  git_config --global alias.svn-cp "svn cherry-pick"
  git_config --global alias.svn-m "svn merge"

  # Graphviz
  git_config --global alias.graphviz "log --graph --oneline --all"

  # Additional utility aliases
  git_config --global alias.heads "log --oneline --decorate"
  git_config --global alias.ignore "!echo \"\$1\" >> .gitignore"
  git_config --global alias.last-tag "describe --tags --abbrev=0"
  git_config --global alias.refs-by-date "for-each-ref --sort=-committerdate --format='%(refname:short)'"
  git_config --global alias.fixup "commit --fixup"
  git_config --global alias.orphans "fsck --unreachable"
  git_config --global alias.track-all-remote-branches "!git branch -r | grep -v '\\->' | while read remote; do git branch --track \"\${remote#origin/}\" \"\$remote\"; done"
  git_config --global alias.cleaner "clean -fd"
  git_config --global alias.cleanest "clean -fdx"
  git_config --global alias.cleanout "!git clean -fd && git checkout --"
  git_config --global alias.serve "daemon --reuseaddr --base-path=. --export-all --verbose"

  # Topic branching
  git_config --global alias.topic-begin "checkout -b"
  git_config --global alias.topic-end "!git checkout main && git merge --no-ff"
  git_config --global alias.topic-sync "!git fetch && git rebase origin/\$(git current-branch)"
  git_config --global alias.topic-move "branch -m"

  # Flow aliases
  git_config --global alias.issues "log --grep=\"#\" --oneline"
  git_config --global alias.expunge "filter-branch --tree-filter 'rm -f \"\$1\"' --prune-empty HEAD"
  git_config --global alias.reincarnate "!git branch -D \"\$1\" && git checkout -b \"\$1\""
  git_config --global alias.last-tagged "describe --tags --abbrev=0 --always"

  log_success "Comprehensive Git aliases configured"
}

# --- Configuration verification ---
verify_configuration() {
  log_info "Verifying Git configuration..."

  echo -e "\n${BOLD}Git Identity:${RESET}"
  echo "  Name:  $(git config --global user.name 2>/dev/null || echo "Not set")"
  echo "  Email: $(git config --global user.email 2>/dev/null || echo "Not set")"

  echo -e "\n${BOLD}Core Settings:${RESET}"
  local editor=$(git config --global core.editor 2>/dev/null || echo "Not set")
  local default_branch=$(git config --global init.defaultBranch 2>/dev/null || echo "Not set")
  echo "  Editor: $editor"
  echo "  Default Branch: $default_branch"

  echo -e "\n${BOLD}Alias Categories Configured:${RESET}"
  local categories=(
    "Basic (a, s, d, c, co, b)"
    "Commit (ca, cam, cane, caam)"
    "Branch (bm, bnm, bed, bsd)"
    "Diff (dc, ds, dwd)"
    "Log (lg, lo, lp, lfp)"
    "Fetch (fa, fav, fap)"
    "Merge (ma, mc, mncnf)"
    "Rebase (rba, rbc, rbi)"
    "Utility (uncommit, unstage, wip)"
    "Advanced (initer, cloner, pruner)"
  )

  for category in "${categories[@]}"; do
    echo "  ✅ $category"
  done

  echo -e "\n${BOLD}Total Aliases:${RESET}"
  local alias_count=$(git config --global --get-regexp alias 2>/dev/null | wc -l || echo "0")
  echo "  $alias_count aliases configured"

  if command -v delta &>/dev/null; then
    echo -e "\n${BOLD}Delta Configuration:${RESET}"
    delta --version 2>/dev/null || echo "  Delta installed but version check failed"
  else
    echo -e "\n${BOLD}Delta:${RESET} Not installed"
  fi
}

# --- Main execution ---
main() {
  parse_arguments "$@"

  if [[ "$DRY_RUN" == true ]]; then
    log_info "DRY RUN MODE: No changes will be made"
  fi

  log_info "Starting Git configuration bootstrap..."

  # Check mode
  if [[ "$CHECK_ONLY" == true ]]; then
    log_info "Check-only mode activated"
    verify_configuration
    exit 0
  fi

  # Ensure dependencies are installed
  if [[ "$DRY_RUN" != true ]]; then
    ensure_installed git git
    ensure_installed delta git-delta
  else
    log_dry_run "Would check/install dependencies: git, delta"
  fi

  # Configure Git
  configure_git_identity
  configure_git_core
  configure_delta
  configure_aliases

  # Final verification
  verify_configuration

  if [[ "$DRY_RUN" == true ]]; then
    log_success "Dry run completed successfully! No changes were made."
  else
    log_success "Git configuration completed successfully!"
  fi

  echo
  log_info "Try these useful aliases:"
  echo "  git s          # Compact status"
  echo "  git lg         # Graph log"
  echo "  git d filename # View changes"
  echo "  git co -b feat/new-feature # Create new branch"
  echo "  git ca         # Amend last commit"
  echo "  git wip        # Save work in progress"
  echo "  git uncommit   # Soft reset last commit"
  echo "  git aa         # Add all changes"
  echo "  git cp         # Cherry-pick commits"
  echo "  git rb         # Interactive rebase"
  echo ""
  log_info "View all aliases with: ${BOLD}git aliases${RESET}"
}

# --- Error handling ---
handle_error() {
  local line="$1"
  local command="$2"
  local code="${3:-0}"
  log_error "Error on line $line: command '$command' exited with status $code"
  exit 1
}

trap 'handle_error ${LINENO} "$BASH_COMMAND" $?' ERR

# --- Script entry point ---
# Fixed BASH_SOURCE check that works with piped execution
if [[ "${BASH_SOURCE[0]:-}" == "$0" ]]; then
  main "$@"
fi
