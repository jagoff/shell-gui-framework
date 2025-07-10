#!/bin/bash
# integrations.sh - Tool Integrations for Universal Shell GUI Framework
# Version: 1.0.0
# Compatible with: bash, zsh, fish

# --- INTEGRATION CONFIGURATION ---
readonly INTEGRATIONS_DIR="${GUI_INTEGRATIONS_DIR:-$HOME/.config/gui-framework/integrations}"
readonly INTEGRATIONS_ENABLED="${GUI_INTEGRATIONS_ENABLED:-true}"

# --- INTEGRATION REGISTRY ---
declare -A INTEGRATION_TOOLS
declare -A INTEGRATION_FUNCTIONS
declare -A INTEGRATION_DEPENDENCIES

# --- INTEGRATION FUNCTIONS ---

# Initialize integrations system
init_integrations() {
    if [[ "$INTEGRATIONS_ENABLED" != "true" ]]; then
        gui_log_debug "Integrations disabled"
        return 0
    fi
    
    # Create integrations directory
    mkdir -p "$INTEGRATIONS_DIR"
    
    # Register built-in integrations
    _register_builtin_integrations
    
    # Load custom integrations
    _load_custom_integrations
    
    # Validate integrations
    _validate_integrations
    
    gui_log_debug "Integrations system initialized"
}

# Register built-in integrations
_register_builtin_integrations() {
    # Git integration
    _register_integration "git" "Git Version Control" "git" "git --version"
    
    # GitHub CLI integration
    _register_integration "gh" "GitHub CLI" "gh" "gh --version"
    
    # Docker integration
    _register_integration "docker" "Docker" "docker" "docker --version"
    
    # FZF integration
    _register_integration "fzf" "Fuzzy Finder" "fzf" "fzf --version"
    
    # JQ integration
    _register_integration "jq" "JSON Processor" "jq" "jq --version"
    
    # Curl integration
    _register_integration "curl" "HTTP Client" "curl" "curl --version"
    
    # Wget integration
    _register_integration "wget" "Web Downloader" "wget" "wget --version"
    
    # SSH integration
    _register_integration "ssh" "SSH Client" "ssh" "ssh -V"
    
    # RSync integration
    _register_integration "rsync" "File Synchronization" "rsync" "rsync --version"
    
    # Tar integration
    _register_integration "tar" "Archive Utility" "tar" "tar --version"
    
    # Gzip integration
    _register_integration "gzip" "Compression Utility" "gzip" "gzip --version"
    
    # Node.js integration
    _register_integration "node" "Node.js" "node" "node --version"
    
    # Python integration
    _register_integration "python" "Python" "python3" "python3 --version"
    
    # Ruby integration
    _register_integration "ruby" "Ruby" "ruby" "ruby --version"
    
    # Go integration
    _register_integration "go" "Go Language" "go" "go version"
    
    # Rust integration
    _register_integration "rust" "Rust Language" "cargo" "cargo --version"
    
    # Homebrew integration (macOS)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        _register_integration "brew" "Homebrew Package Manager" "brew" "brew --version"
    fi
    
    # Apt integration (Debian/Ubuntu)
    if command -v apt-get >/dev/null; then
        _register_integration "apt" "APT Package Manager" "apt-get" "apt-get --version"
    fi
    
    # Yum integration (RHEL/CentOS)
    if command -v yum >/dev/null; then
        _register_integration "yum" "YUM Package Manager" "yum" "yum --version"
    fi
    
    # Pacman integration (Arch)
    if command -v pacman >/dev/null; then
        _register_integration "pacman" "Pacman Package Manager" "pacman" "pacman --version"
    fi
}

# Register an integration
_register_integration() {
    local tool_name="$1"
    local description="$2"
    local command="$3"
    local version_command="$4"
    
    INTEGRATION_TOOLS["$tool_name"]="$description"
    INTEGRATION_FUNCTIONS["$tool_name"]="$command"
    INTEGRATION_DEPENDENCIES["$tool_name"]="$version_command"
    
    gui_log_debug "Registered integration: $tool_name ($description)"
}

# Load custom integrations
_load_custom_integrations() {
    if [[ ! -d "$INTEGRATIONS_DIR" ]]; then
        return
    fi
    
    for integration_file in "$INTEGRATIONS_DIR"/*.sh; do
        if [[ -f "$integration_file" ]]; then
            gui_log_debug "Loading custom integration: $integration_file"
            source "$integration_file"
        fi
    done
}

# Validate integrations
_validate_integrations() {
    local available_tools=()
    local missing_tools=()
    
    for tool_name in "${!INTEGRATION_TOOLS[@]}"; do
        local command="${INTEGRATION_FUNCTIONS[$tool_name]}"
        local version_command="${INTEGRATION_DEPENDENCIES[$tool_name]}"
        
        if command -v "$command" >/dev/null; then
            available_tools+=("$tool_name")
            gui_log_debug "Integration available: $tool_name"
        else
            missing_tools+=("$tool_name")
            gui_log_debug "Integration missing: $tool_name"
        fi
    done
    
    # Store results for later use
    _AVAILABLE_INTEGRATIONS=("${available_tools[@]}")
    _MISSING_INTEGRATIONS=("${missing_tools[@]}")
}

# --- GIT INTEGRATION ---

# Git repository browser
show_git_repo_browser() {
    if ! is_integration_available "git"; then
        handle_dependency_error "git" "brew install git" "Git is required for repository browsing"
        return 1
    fi
    
    local repo_path="${1:-.}"
    
    if [[ ! -d "$repo_path/.git" ]]; then
        gui_log_error "Not a git repository: $repo_path"
        return 1
    fi
    
    local options=(
        "Show Status"
        "Show Branches"
        "Show Log"
        "Show Remotes"
        "Show Tags"
        "Show Stash"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Git Repository Browser" \
        "Repository: $(basename "$repo_path")" \
        "Select an action:" \
        "${options[@]}")
    
    case "$choice" in
        "Show Status")
            _show_git_status "$repo_path"
            ;;
        "Show Branches")
            _show_git_branches "$repo_path"
            ;;
        "Show Log")
            _show_git_log "$repo_path"
            ;;
        "Show Remotes")
            _show_git_remotes "$repo_path"
            ;;
        "Show Tags")
            _show_git_tags "$repo_path"
            ;;
        "Show Stash")
            _show_git_stash "$repo_path"
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Show git status
_show_git_status() {
    local repo_path="$1"
    cd "$repo_path" || return 1
    
    echo -e "${C_BLUE}📊 Git Status${C_NC}"
    echo
    
    # Get status
    local status_output=$(git status --porcelain 2>/dev/null)
    local branch=$(git branch --show-current 2>/dev/null)
    
    echo -e "${C_GRAY}Current branch: $branch${C_NC}"
    echo
    
    if [[ -n "$status_output" ]]; then
        echo -e "${C_YELLOW}Modified files:${C_NC}"
        echo "$status_output" | while read -r line; do
            local status="${line:0:2}"
            local file="${line:3}"
            case "$status" in
                "M "|" M")
                    echo -e "  ${C_YELLOW}Modified: $file${C_NC}"
                    ;;
                "A "|" A")
                    echo -e "  ${C_GREEN}Added: $file${C_NC}"
                    ;;
                "D "|" D")
                    echo -e "  ${C_RED}Deleted: $file${C_NC}"
                    ;;
                "R "|" R")
                    echo -e "  ${C_CYAN}Renamed: $file${C_NC}"
                    ;;
                "??")
                    echo -e "  ${C_MAGENTA}Untracked: $file${C_NC}"
                    ;;
            esac
        done
    else
        echo -e "${C_GREEN}Working directory is clean${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Show git branches
_show_git_branches() {
    local repo_path="$1"
    cd "$repo_path" || return 1
    
    echo -e "${C_BLUE}🌿 Git Branches${C_NC}"
    echo
    
    local branches=($(git branch -a --format="%(refname:short)" 2>/dev/null))
    local current_branch=$(git branch --show-current 2>/dev/null)
    
    for branch in "${branches[@]}"; do
        if [[ "$branch" == "$current_branch" ]]; then
            echo -e "  ${C_GREEN}* $branch${C_NC}"
        else
            echo -e "  $branch"
        fi
    done
    
    echo
    read -p "Press Enter to continue..."
}

# --- DOCKER INTEGRATION ---

# Docker container manager
show_docker_manager() {
    if ! is_integration_available "docker"; then
        handle_dependency_error "docker" "brew install docker" "Docker is required for container management"
        return 1
    fi
    
    local options=(
        "List Containers"
        "List Images"
        "List Networks"
        "List Volumes"
        "System Info"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Docker Manager" \
        "Manage Docker containers and resources" \
        "Select an action:" \
        "${options[@]}")
    
    case "$choice" in
        "List Containers")
            _show_docker_containers
            ;;
        "List Images")
            _show_docker_images
            ;;
        "List Networks")
            _show_docker_networks
            ;;
        "List Volumes")
            _show_docker_volumes
            ;;
        "System Info")
            _show_docker_system_info
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Show Docker containers
_show_docker_containers() {
    echo -e "${C_BLUE}🐳 Docker Containers${C_NC}"
    echo
    
    local containers=$(docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null)
    
    if [[ -n "$containers" ]]; then
        echo "$containers"
    else
        echo -e "${C_GRAY}No containers found${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Show Docker images
_show_docker_images() {
    echo -e "${C_BLUE}📦 Docker Images${C_NC}"
    echo
    
    local images=$(docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}" 2>/dev/null)
    
    if [[ -n "$images" ]]; then
        echo "$images"
    else
        echo -e "${C_GRAY}No images found${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# --- FZF INTEGRATION ---

# Enhanced file browser with FZF
show_fzf_file_browser() {
    if ! is_integration_available "fzf"; then
        handle_dependency_error "fzf" "brew install fzf" "FZF is required for enhanced file browsing"
        return 1
    fi
    
    local start_path="${1:-.}"
    
    echo -e "${C_BLUE}🔍 FZF File Browser${C_NC}"
    echo -e "${C_GRAY}Start typing to search files...${C_NC}"
    echo
    
    # Use FZF to select files
    local selected_file=$(find "$start_path" -type f 2>/dev/null | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:60%:wrap)
    
    if [[ -n "$selected_file" ]]; then
        echo -e "${C_GREEN}Selected: $selected_file${C_NC}"
        
        local options=(
            "Open with default editor"
            "Show file info"
            "Copy path"
            "Back to browser"
        )
        
        local choice=$(show_gui_menu \
            "File Actions" \
            "File: $selected_file" \
            "Select an action:" \
            "${options[@]}")
        
        case "$choice" in
            "Open with default editor")
                "${EDITOR:-nano}" "$selected_file"
                ;;
            "Show file info")
                _show_file_info "$selected_file"
                ;;
            "Copy path")
                echo "$selected_file" | pbcopy 2>/dev/null || echo "$selected_file" | xclip -selection clipboard 2>/dev/null || echo "$selected_file"
                gui_log_success "Path copied to clipboard"
                ;;
            "Back to browser")
                show_fzf_file_browser "$start_path"
                ;;
        esac
    fi
}

# Show file information
_show_file_info() {
    local file="$1"
    
    echo -e "${C_BLUE}📄 File Information${C_NC}"
    echo
    
    if [[ -f "$file" ]]; then
        local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "unknown")
        local modified=$(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file" 2>/dev/null | xargs -I {} date -d @{} 2>/dev/null || echo "unknown")
        local permissions=$(stat -f%Lp "$file" 2>/dev/null || stat -c%A "$file" 2>/dev/null || echo "unknown")
        local owner=$(stat -f%Su "$file" 2>/dev/null || stat -c%U "$file" 2>/dev/null || echo "unknown")
        
        echo -e "  ${C_GRAY}Name:${C_NC} $(basename "$file")"
        echo -e "  ${C_GRAY}Path:${C_NC} $(dirname "$file")"
        echo -e "  ${C_GRAY}Size:${C_NC} $size bytes"
        echo -e "  ${C_GRAY}Modified:${C_NC} $modified"
        echo -e "  ${C_GRAY}Permissions:${C_NC} $permissions"
        echo -e "  ${C_GRAY}Owner:${C_NC} $owner"
        
        # Show file type
        local file_type=$(file "$file" 2>/dev/null | cut -d: -f2-)
        if [[ -n "$file_type" ]]; then
            echo -e "  ${C_GRAY}Type:${C_NC} $file_type"
        fi
    else
        echo -e "${C_RED}File not found: $file${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# --- GITHUB CLI INTEGRATION ---

# GitHub repository browser
show_github_browser() {
    if ! is_integration_available "gh"; then
        handle_dependency_error "gh" "brew install gh" "GitHub CLI is required for GitHub integration"
        return 1
    fi
    
    # Check if user is authenticated
    if ! gh auth status >/dev/null 2>&1; then
        gui_log_warning "GitHub CLI not authenticated"
        if show_gui_confirmation "Would you like to authenticate with GitHub?"; then
            gh auth login
        fi
        return 1
    fi
    
    local options=(
        "My Repositories"
        "Search Repositories"
        "My Issues"
        "My Pull Requests"
        "Trending Repositories"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "GitHub Browser" \
        "Browse GitHub repositories and issues" \
        "Select an action:" \
        "${options[@]}")
    
    case "$choice" in
        "My Repositories")
            _show_github_repos
            ;;
        "Search Repositories")
            _search_github_repos
            ;;
        "My Issues")
            _show_github_issues
            ;;
        "My Pull Requests")
            _show_github_prs
            ;;
        "Trending Repositories")
            _show_trending_repos
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Show user repositories
_show_github_repos() {
    echo -e "${C_BLUE}📚 My GitHub Repositories${C_NC}"
    echo
    
    local repos=$(gh repo list --limit 20 --json name,description,url,updatedAt --jq '.[] | "\(.name) - \(.description // "No description")"')
    
    if [[ -n "$repos" ]]; then
        echo "$repos" | while read -r repo; do
            echo -e "  $repo"
        done
    else
        echo -e "${C_GRAY}No repositories found${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Search GitHub repositories
_search_github_repos() {
    local query=$(show_gui_input \
        "Search Repositories" \
        "Enter search query")
    
    if [[ -n "$query" ]]; then
        echo -e "${C_BLUE}🔍 Search Results for: $query${C_NC}"
        echo
        
        local results=$(gh search repos "$query" --limit 10 --json name,description,url,stargazerCount --jq '.[] | "\(.name) (\(.stargazerCount) stars) - \(.description // "No description")"')
        
        if [[ -n "$results" ]]; then
            echo "$results" | while read -r result; do
                echo -e "  $result"
            done
        else
            echo -e "${C_GRAY}No results found${C_NC}"
        fi
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# --- PACKAGE MANAGER INTEGRATION ---

# Package manager interface
show_package_manager() {
    local package_manager=""
    
    # Detect package manager
    if command -v brew >/dev/null; then
        package_manager="brew"
    elif command -v apt-get >/dev/null; then
        package_manager="apt"
    elif command -v yum >/dev/null; then
        package_manager="yum"
    elif command -v pacman >/dev/null; then
        package_manager="pacman"
    else
        gui_log_error "No supported package manager found"
        return 1
    fi
    
    local options=(
        "Search Packages"
        "Install Package"
        "Remove Package"
        "Update System"
        "List Installed"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Package Manager" \
        "Using: $package_manager" \
        "Select an action:" \
        "${options[@]}")
    
    case "$choice" in
        "Search Packages")
            _search_packages "$package_manager"
            ;;
        "Install Package")
            _install_package "$package_manager"
            ;;
        "Remove Package")
            _remove_package "$package_manager"
            ;;
        "Update System")
            _update_system "$package_manager"
            ;;
        "List Installed")
            _list_installed_packages "$package_manager"
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Search packages
_search_packages() {
    local package_manager="$1"
    local query=$(show_gui_input \
        "Search Packages" \
        "Enter package name to search")
    
    if [[ -n "$query" ]]; then
        echo -e "${C_BLUE}🔍 Searching for: $query${C_NC}"
        echo
        
        case "$package_manager" in
            brew)
                brew search "$query" 2>/dev/null | head -20
                ;;
            apt)
                apt search "$query" 2>/dev/null | head -20
                ;;
            yum)
                yum search "$query" 2>/dev/null | head -20
                ;;
            pacman)
                pacman -Ss "$query" 2>/dev/null | head -20
                ;;
        esac
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Install package
_install_package() {
    local package_manager="$1"
    local package_name=$(show_gui_input \
        "Install Package" \
        "Enter package name to install")
    
    if [[ -n "$package_name" ]]; then
        if show_gui_confirmation "Install $package_name?"; then
            case "$package_manager" in
                brew)
                    brew install "$package_name"
                    ;;
                apt)
                    sudo apt-get install "$package_name"
                    ;;
                yum)
                    sudo yum install "$package_name"
                    ;;
                pacman)
                    sudo pacman -S "$package_name"
                    ;;
            esac
        fi
    fi
}

# --- UTILITY FUNCTIONS ---

# Check if integration is available
is_integration_available() {
    local tool_name="$1"
    array_contains "$tool_name" "${_AVAILABLE_INTEGRATIONS[@]}"
}

# Get available integrations
get_available_integrations() {
    printf '%s\n' "${_AVAILABLE_INTEGRATIONS[@]}"
}

# Get missing integrations
get_missing_integrations() {
    printf '%s\n' "${_MISSING_INTEGRATIONS[@]}"
}

# Show integrations status
show_integrations_status() {
    echo -e "${C_BLUE}🔧 Integrations Status${C_NC}"
    echo
    
    if [[ ${#_AVAILABLE_INTEGRATIONS[@]} -gt 0 ]]; then
        echo -e "${C_GREEN}Available integrations:${C_NC}"
        for integration in "${_AVAILABLE_INTEGRATIONS[@]}"; do
            local description="${INTEGRATION_TOOLS[$integration]}"
            echo -e "  ✅ $integration - $description"
        done
        echo
    fi
    
    if [[ ${#_MISSING_INTEGRATIONS[@]} -gt 0 ]]; then
        echo -e "${C_YELLOW}Missing integrations:${C_NC}"
        for integration in "${_MISSING_INTEGRATIONS[@]}"; do
            local description="${INTEGRATION_TOOLS[$integration]}"
            echo -e "  ❌ $integration - $description"
        done
        echo
    fi
    
    if [[ ${#_AVAILABLE_INTEGRATIONS[@]} -eq 0 && ${#_MISSING_INTEGRATIONS[@]} -eq 0 ]]; then
        echo -e "${C_GRAY}No integrations registered${C_NC}"
    fi
}

# Integration management menu
show_integration_manager() {
    local options=(
        "Show Status"
        "Install Missing"
        "Test Integrations"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Integration Manager" \
        "Manage tool integrations" \
        "Select an action:" \
        "${options[@]}")
    
    case "$choice" in
        "Show Status")
            show_integrations_status
            read -p "Press Enter to continue..."
            ;;
        "Install Missing")
            _install_missing_integrations
            ;;
        "Test Integrations")
            _test_integrations
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Install missing integrations
_install_missing_integrations() {
    if [[ ${#_MISSING_INTEGRATIONS[@]} -eq 0 ]]; then
        gui_log_info "No missing integrations"
        return
    fi
    
    echo -e "${C_BLUE}📦 Install Missing Integrations${C_NC}"
    echo
    
    for integration in "${_MISSING_INTEGRATIONS[@]}"; do
        local description="${INTEGRATION_TOOLS[$integration]}"
        echo -e "${C_YELLOW}$integration - $description${C_NC}"
        
        if show_gui_confirmation "Install $integration?"; then
            case "$integration" in
                git)
                    _install_git
                    ;;
                gh)
                    _install_gh
                    ;;
                docker)
                    _install_docker
                    ;;
                fzf)
                    _install_fzf
                    ;;
                *)
                    gui_log_warning "No installation method for $integration"
                    ;;
            esac
        fi
    done
}

# Test integrations
_test_integrations() {
    echo -e "${C_BLUE}🧪 Testing Integrations${C_NC}"
    echo
    
    for integration in "${_AVAILABLE_INTEGRATIONS[@]}"; do
        local command="${INTEGRATION_FUNCTIONS[$integration]}"
        local version_command="${INTEGRATION_DEPENDENCIES[$integration]}"
        
        echo -n "Testing $integration... "
        if eval "$version_command" >/dev/null 2>&1; then
            echo -e "${C_GREEN}✅ OK${C_NC}"
        else
            echo -e "${C_RED}❌ FAILED${C_NC}"
        fi
    done
    
    echo
    read -p "Press Enter to continue..."
}

# --- END OF INTEGRATIONS --- 