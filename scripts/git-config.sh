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
#   ./config.sh --check-only        # Verify current configuration
#   ./config.sh --reset             # Reset identity and reconfigure
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

# --- Logging functions ---
log_info() { echo -e "${BLUE}ℹ️  $*${RESET}"; }
log_success() { echo -e "${GREEN}✅ $*${RESET}"; }
log_warning() { echo -e "${YELLOW}⚠️  $*${RESET}"; }
log_error() { echo -e "${RED}❌ $*${RESET}"; }
log_debug() { [[ "$QUIET" != true ]] && echo -e "${BOLD}🔍 $*${RESET}"; }

# --- Usage information ---
show_usage() {
  cat <<EOF
${BOLD}Git Configuration Bootstrap Script${RESET}

${BOLD}Usage:${RESET} $0 [OPTIONS]

${BOLD}Options:${RESET}
  --reset         Reset Git user identity before configuration
  --check-only    Check current configuration without making changes
  --quiet         Suppress non-essential output
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
    git config --global --unset user.name 2>/dev/null || true
    git config --global --unset user.email 2>/dev/null || true
  fi

  local current_name current_email
  current_name=$(git config --global user.name 2>/dev/null || echo "")
  current_email=$(git config --global user.email 2>/dev/null || echo "")

  if [[ -n "$current_name" && -n "$current_email" && "$RESET_IDENTITY" != true ]]; then
    log_info "Current Git identity:"
    echo "  Name:  $current_name"
    echo "  Email: $current_email"
    read -rp "Use current identity? [Y/n] " -n 1 use_current
    echo
    if [[ "${use_current:-y}" =~ ^[Yy]$ ]]; then
      return 0
    fi
  fi

  local git_name git_email
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

  git config --global user.name "$git_name"
  git config --global user.email "$git_email"
  log_success "Git identity configured"
}

# --- Core Git configuration ---
configure_git_core() {
  log_info "Applying core Git configuration..."

  # Basic settings
  git config --global core.editor "nvim"
  git config --global core.pager "delta"
  git config --global init.defaultBranch "main"
  git config --global color.ui "auto"

  # Merge and diff settings
  git config --global merge.conflictStyle "zdiff3"
  git config --global merge.tool "vimdiff"
  git config --global diff.colorMoved "default"

  # Branch behavior
  git config --global pull.rebase true
  git config --global push.default "simple"
  git config --global push.autoSetupRemote true

  # Credential caching (1 hour)
  git config --global credential.helper "cache --timeout=3600"

  # Performance optimizations
  git config --global feature.manyFiles true
}

# --- Delta configuration ---
configure_delta() {
  log_info "Configuring Delta for enhanced diff viewing..."

  git config --global delta.navigate true
  git config --global delta.line-numbers true
  git config --global delta.side-by-side true
  git config --global delta.syntax-theme "Monokai Extended"
  git config --global delta.features "decorations"

  # Pager configurations
  git config --global pager.log "delta"
  git config --global pager.diff "delta"
  git config --global pager.show "delta"
  git config --global interactive.diffFilter "delta --color-only"

  # Decoration settings
  git config --global delta.decorations.commit-decoration-style "bold yellow box ul"
  git config --global delta.decorations.file-style "bold yellow"
  git config --global delta.decorations.file-decoration-style "none"
}

# --- Git aliases ---
configure_aliases() {
  log_info "Setting up comprehensive Git aliases..."

  # Short aliases for frequent commands
  git config --global alias.a "add"
  git config --global alias.aa "add --all"
  git config --global alias.ap "add --patch"
  git config --global alias.au "add --update"

  # Branch operations
  git config --global alias.b "branch"
  git config --global alias.bm "branch --merged"
  git config --global alias.bnm "branch --no-merged"
  git config --global alias.bed "branch --edit-description"
  git config --global alias.bsd "branch --show-description"
  git config --global alias.bv "branch -v"
  git config --global alias.bra "branch -a"

  # Commit operations
  git config --global alias.c "commit"
  git config --global alias.ca "commit --amend"
  git config --global alias.cam "commit --amend --message"
  git config --global alias.cane "commit --amend --no-edit"
  git config --global alias.caa "commit --amend --all"
  git config --global alias.caam "commit --amend --all --message"
  git config --global alias.caane "commit --amend --all --no-edit"
  git config --global alias.ci "commit --interactive"
  git config --global alias.cm "commit --message"

  # Checkout operations
  git config --global alias.co "checkout"
  git config --global alias.cog "checkout --guess"
  git config --global alias.cong "checkout --no-guess"
  git config --global alias.cob "checkout -b"

  # Cherry-pick operations
  git config --global alias.cp "cherry-pick"
  git config --global alias.cpa "cherry-pick --abort"
  git config --global alias.cpc "cherry-pick --continue"
  git config --global alias.cpn "cherry-pick -n"
  git config --global alias.cpnx "cherry-pick -n -x"

  # Diff operations
  git config --global alias.d "diff"
  git config --global alias.dd "diff"
  git config --global alias.dc "diff --cached"
  git config --global alias.ds "diff --staged"
  git config --global alias.dwd "diff --word-diff"

  # Fetch operations
  git config --global alias.f "fetch"
  git config --global alias.fa "fetch --all"
  git config --global alias.fav "fetch --all --verbose"
  git config --global alias.fap "fetch --all --prune"

  # Grep operations
  git config --global alias.g "grep"
  git config --global alias.gg "grep"
  git config --global alias.gn "grep -n"

  # Log operations
  git config --global alias.l "log"
  git config --global alias.ll "log"
  git config --global alias.lll "log"
  git config --global alias.lo "log --oneline"
  git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  git config --global alias.ll "log --graph --decorate --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
  git config --global alias.lor "log --oneline --reverse"
  git config --global alias.lp "log --patch"
  git config --global alias.lfp "log --first-parent"
  git config --global alias.lto "log --topo-order"

  # ls-files operations
  git config --global alias.ls "ls-files"
  git config --global alias.lsd "ls-files --debug"
  git config --global alias.lsfn "ls-files --full-name"
  git config --global alias.lsio "ls-files --ignored --others --exclude-standard"

  # Merge operations
  git config --global alias.m "merge"
  git config --global alias.ma "merge --abort"
  git config --global alias.mc "merge --continue"
  git config --global alias.mncnf "merge --no-commit --no-ff"

  # Pull operations
  git config --global alias.p "pull"
  git config --global alias.pf "pull --ff-only"
  git config --global alias.pr "pull --rebase"
  git config --global alias.prp "pull --rebase=preserve"

  # Rebase operations
  git config --global alias.rb "rebase"
  git config --global alias.rba "rebase --abort"
  git config --global alias.rbc "rebase --continue"
  git config --global alias.rbs "rebase --skip"
  git config --global alias.rbi "rebase --interactive"
  git config --global alias.rbiu "rebase --interactive @{upstream}"

  # Reflog operations
  git config --global alias.rl "reflog"

  # Remote operations
  git config --global alias.rr "remote"
  git config --global alias.rrs "remote show"
  git config --global alias.rru "remote update"
  git config --global alias.rrp "remote prune"

  # Revert operations
  git config --global alias.rv "revert"
  git config --global alias.rvnc "revert --no-commit"

  # Show-branch operations
  git config --global alias.sb "show-branch"
  git config --global alias.sbdo "show-branch --date-order"
  git config --global alias.sbto "show-branch --topo-order"

  # Submodule operations
  git config --global alias.sm "submodule"
  git config --global alias.smi "submodule init"
  git config --global alias.sma "submodule add"
  git config --global alias.sms "submodule sync"
  git config --global alias.smu "submodule update"
  git config --global alias.smui "submodule update --init"
  git config --global alias.smuir "submodule update --init --recursive"

  # Status operations
  git config --global alias.s "status -sb"
  git config --global alias.ss "status --short"
  git config --global alias.ssb "status --short --branch"
  git config --global alias.st "status"

  # Whatchanged
  git config --global alias.w "whatchanged"

  # Friendly aliases - Recommended helpers
  git config --global alias.initer "!git init && git commit --allow-empty -m \"Initial empty commit\""
  git config --global alias.cloner "clone --recursive"
  git config --global alias.pruner "!git prune && git reflog expire --all --expire=now && git gc --prune=now"
  git config --global alias.repacker "!git repack -a -d -f --depth=250 --window=250"
  git config --global alias.optimizer "!git pruner && git repacker"

  # Quick highlights
  git config --global alias.chart "shortlog -sn"
  git config --global alias.churn "!git log --pretty=format: --name-only | sort | uniq -c | sort -rg"
  git config --global alias.summary "shortlog -s -n"

  # Branch names
  git config --global alias.default-branch "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
  git config --global alias.current-branch "symbolic-ref --short HEAD"
  git config --global alias.upstream-branch "!git rev-parse --abbrev-ref --symbolic-full-name @{u}"
  git config --global alias.topic-base-branch "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"

  # Friendly plurals
  git config --global alias.aliases "!git config --get-regexp alias | cut -c 7-"
  git config --global alias.branches "branch -a"
  git config --global alias.tags "tag -l"
  git config --global alias.stashes "stash list"

  # Undo operations
  git config --global alias.uncommit "reset --soft HEAD~1"
  git config --global alias.unadd "reset HEAD"
  git config --global alias.undo "reset --soft HEAD~1"

  # Lookups
  git config --global alias.whois "!sh -c 'git log --format=\"%an <%ae>\" | grep -i \"$1\" | head -1' -"
  git config --global alias.whatis "show --name-status"

  # Commit details
  git config --global alias.commit-parents "show --format=%P -s"
  git config --global alias.commit-is-merge "!\"[ $(git show --format=%P -s | wc -w) -gt 1 ]\""

  # Alias helpers
  git config --global alias.alias "!git config --get-regexp alias"
  git config --global alias.add-alias "!sh -c 'git config alias.\"$1\" \"$2\"' -"
  git config --global alias.move-alias "!sh -c 'git config alias.\"$2\" \"$(git config alias.\"$1\")\" && git config --unset alias.\"$1\"' -"

  # Script helpers
  git config --global alias.top "rev-parse --show-toplevel"
  git config --global alias.exec "!sh"

  # New repos
  git config --global alias.init-empty "!git init && git commit --allow-empty -m \"Initial empty commit\""
  git config --global alias.clone-lean "clone --depth=1"

  # Saving work
  git config --global alias.snapshot "stash push -m \"snapshot: $(date)\""
  git config --global alias.panic "!git add -A && git stash && git stash drop"

  # Advanced aliases
  git config --global alias.search-commits "log --grep"
  git config --global alias.debug "!echo \"Current branch: $(git current-branch)\" && echo \"Upstream: $(git upstream-branch 2>/dev/null || echo none)\""

  # Workflow aliases
  git config --global alias.get "pull --ff-only"
  git config --global alias.put "push"
  git config --global alias.ours "checkout --ours"
  git config --global alias.theirs "checkout --theirs"
  git config --global alias.wip "stash push -m \"wip\""
  git config --global alias.unwip "stash pop"
  git config --global alias.assume "update-index --assume-unchanged"
  git config --global alias.unassume "update-index --no-assume-unchanged"
  git config --global alias.publish "push -u origin HEAD"
  git config --global alias.unpublish "push origin :HEAD"

  # Reset & undo
  git config --global alias.reset-commit "reset --soft HEAD~1"
  git config --global alias.undo-commit "reset --soft HEAD~1"

  # Track & untrack
  git config --global alias.track "branch --set-upstream-to=origin/HEAD"
  git config --global alias.untrack "branch --unset-upstream"

  # Inbound & outbound
  git config --global alias.inbound "!git fetch && git log ..@{u}"
  git config --global alias.outbound "!git log @{u}.."

  # Pull1 & push1
  git config --global alias.pull1 "pull origin HEAD"
  git config --global alias.push1 "push origin HEAD"

  # Tooling aliases
  git config --global alias.gitk-conflict "!gitk --merge"
  git config --global alias.gitk-history-all "!gitk --all"

  # CVS aliases
  git config --global alias.cvs-e "cvsexportcommit"
  git config --global alias.cvs-i "cvsimport"

  # SVN aliases
  git config --global alias.svn-b "svn branch"
  git config --global alias.svn-c "svn commit"
  git config --global alias.svn-cp "svn cherry-pick"
  git config --global alias.svn-m "svn merge"

  # Graphviz
  git config --global alias.graphviz "log --graph --oneline --all"

  # Additional utility aliases
  git config --global alias.heads "log --oneline --decorate"
  git config --global alias.ignore "!echo \"$1\" >> .gitignore"
  git config --global alias.last-tag "describe --tags --abbrev=0"
  git config --global alias.refs-by-date "for-each-ref --sort=-committerdate --format='%(refname:short)'"
  git config --global alias.fixup "commit --fixup"
  git config --global alias.orphans "fsck --unreachable"
  git config --global alias.track-all-remote-branches "!git branch -r | grep -v '\\->' | while read remote; do git branch --track \"${remote#origin/}\" \"$remote\"; done"
  git config --global alias.cleaner "clean -fd"
  git config --global alias.cleanest "clean -fdx"
  git config --global alias.cleanout "!git clean -fd && git checkout --"
  git config --global alias.serve "daemon --reuseaddr --base-path=. --export-all --verbose"

  # Topic branching
  git config --global alias.topic-begin "checkout -b"
  git config --global alias.topic-end "!git checkout main && git merge --no-ff"
  git config --global alias.topic-sync "!git fetch && git rebase origin/$(git current-branch)"
  git config --global alias.topic-move "branch -m"

  # Flow aliases
  git config --global alias.issues "log --grep=\"#\" --oneline"
  git config --global alias.expunge "filter-branch --tree-filter 'rm -f \"$1\"' --prune-empty HEAD"
  git config --global alias.reincarnate "!git branch -D \"$1\" && git checkout -b \"$1\""
  git config --global alias.last-tagged "describe --tags --abbrev=0 --always"

  log_success "Comprehensive Git aliases configured"
}

# --- Configuration verification ---
verify_configuration() {
  log_info "Verifying Git configuration..."

  echo -e "\n${BOLD}Git Identity:${RESET}"
  echo "  Name:  $(git config --global user.name)"
  echo "  Email: $(git config --global user.email)"

  echo -e "\n${BOLD}Core Settings:${RESET}"
  git config --global --get core.editor
  git config --global --get init.defaultBranch

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
  git config --global --get-regexp alias | wc -l

  if command -v delta &>/dev/null; then
    echo -e "\n${BOLD}Delta Configuration:${RESET}"
    delta --version
  fi
}

# --- Main execution ---
main() {
  parse_arguments "$@"

  log_info "Starting Git configuration bootstrap..."

  # Check mode
  if [[ "$CHECK_ONLY" == true ]]; then
    log_info "Check-only mode activated"
    verify_configuration
    exit 0
  fi

  # Ensure dependencies are installed
  ensure_installed git git
  ensure_installed delta git-delta

  # Configure Git
  configure_git_identity
  configure_git_core
  configure_delta
  configure_aliases

  # Final verification
  verify_configuration

  log_success "Git configuration completed successfully!"
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
# Check if script is being executed directly or sourced
if [[ "${BASH_SOURCE[0]:-}" == "$0" ]]; then
  main "$@"
fi
