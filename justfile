# Dotfiles management with just
# Run `just --list` to see all available commands

# Show all available commands
default:
    @just --list

# Initial setup - install dotfiles and configure git
setup:
    ./setup.sh --yes

# Update dotfiles to latest version
update: git-pull stow git-conf

# Configure git with personal settings
git-conf:
    ./bin/git-configure.sh

# Install Homebrew formulae from formulae.txt
install-formulae:
    @echo "Installing Homebrew formulae..."
    @if command -v brew >/dev/null 2>&1; then \
        brew install $(cat formulae.txt | tr '\n' ' '); \
    else \
        echo "Homebrew not found. Please install Homebrew first."; \
    fi

# Install Homebrew casks from casks.txt
install-casks:
    @echo "Installing Homebrew casks..."
    @if command -v brew >/dev/null 2>&1; then \
        brew install --cask $(cat casks.txt | tr '\n' ' '); \
    else \
        echo "Homebrew not found. Please install Homebrew first."; \
    fi

# Install both formulae and casks
install-all: install-formulae install-casks

# Pull latest changes from git
git-pull:
    git pull origin master

# Stow dotfiles (link configuration files)
stow:
    stow -S sh -S bash -S zsh -S clang-format -S macos -S ripgrep

# Unstow dotfiles (remove symlinks)
unstow:
    stow -D sh -D bash -D zsh -D clang-format -D macos -D ripgrep

# Restow dotfiles (remove and relink)
restow:
    stow -R sh -R bash -R zsh -R clang-format -R macos -R ripgrep

# Install git scripts
install-git-scripts:
    ./git-scripts/install.sh

# Check what files would be linked (dry run)
dry-run:
    stow -n -S sh -S bash -S zsh -S clang-format -S macos -S ripgrep

# Show broken symlinks (safe - only lists them)
check-broken-links:
    @echo "Finding broken symlinks in home directory..."
    @find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null

# Clean up broken symlinks (WARNING: actually deletes them)
delete-broken-links:
    @echo "Cleaning up broken symlinks in home directory..."
    @find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print -delete 2>/dev/null

# Check if all required tools are installed
check:
    @echo "Checking required tools..."
    @printf "stow: "; command -v stow >/dev/null && echo "✓" || echo "✗ not found"
    @printf "brew: "; command -v brew >/dev/null && echo "✓" || echo "✗ not found"
    @printf "git: "; command -v git >/dev/null && echo "✓" || echo "✗ not found"
    @printf "zsh: "; command -v zsh >/dev/null && echo "✓" || echo "✗ not found"

# Show status of dotfiles
status:
    @echo "=== Git Status ==="
    @git status --short
    @echo "\n=== Stow Status ==="
    @stow -n -S sh -S bash -S zsh -S clang-format -S macos -S ripgrep 2>&1 | grep -E "(LINK|UNLINK)" || echo "All files are properly linked"
