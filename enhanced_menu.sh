#!/bin/bash
# enhanced_menu.sh - Enhanced Main Menu for Universal Shell GUI Framework
# Version: 1.0.0
# Compatible with: bash, zsh, fish

# --- ENHANCED MENU FUNCTIONS ---

# Show enhanced main menu
show_enhanced_main_menu() {
    while true; do
        clear
        _show_menu_header
        
        local options=(
            "🎨 Theme Manager"
            "🔧 Tool Integrations"
            "📁 File Operations"
            "🐳 Docker Manager"
            "🌿 Git Operations"
            "📦 Package Manager"
            "⚙️  System Tools"
            "📊 Framework Status"
            "❓ Help & Support"
            "🚪 Exit"
        )
        
        local choice=$(show_gui_menu \
            "Universal Shell GUI Framework" \
            "Enhanced Menu - Choose an option" \
            "Main Menu:" \
            "${options[@]}")
        
        case "$choice" in
            "🎨 Theme Manager")
                if command -v show_theme_manager >/dev/null; then
                    show_theme_manager
                else
                    gui_log_error "Theme manager not available"
                fi
                ;;
            "🔧 Tool Integrations")
                if command -v show_integration_manager >/dev/null; then
                    show_integration_manager
                else
                    gui_log_error "Integration manager not available"
                fi
                ;;
            "📁 File Operations")
                show_file_operations_menu
                ;;
            "🐳 Docker Manager")
                if command -v show_docker_manager >/dev/null; then
                    show_docker_manager
                else
                    gui_log_error "Docker manager not available"
                fi
                ;;
            "🌿 Git Operations")
                show_git_operations_menu
                ;;
            "📦 Package Manager")
                if command -v show_package_manager >/dev/null; then
                    show_package_manager
                else
                    gui_log_error "Package manager not available"
                fi
                ;;
            "⚙️  System Tools")
                show_system_tools_menu
                ;;
            "📊 Framework Status")
                show_framework_status
                ;;
            "❓ Help & Support")
                show_help_and_support
                ;;
            "🚪 Exit")
                gui_handle_quit "Thank you for using Universal Shell GUI Framework!"
                ;;
        esac
    done
}

# Show menu header with system info
_show_menu_header() {
    local shell_name=$(get_shell_name 2>/dev/null || echo "unknown")
    local current_theme=$(get_current_theme 2>/dev/null || echo "default")
    local gum_version=$(get_gum_version)
    
    echo -e "${C_BLUE}╔══════════════════════════════════════════════════════════════╗${C_NC}"
    echo -e "${C_BLUE}║              Universal Shell GUI Framework                  ║${C_NC}"
    echo -e "${C_BLUE}║                    Enhanced Edition                        ║${C_NC}"
    echo -e "${C_BLUE}╠══════════════════════════════════════════════════════════════╣${C_NC}"
    echo -e "${C_BLUE}║${C_NC} Shell: $shell_name | Theme: $current_theme | Gum: $gum_version"
    echo -e "${C_BLUE}║${C_NC} User: $USER | OS: $(uname -s) $(uname -r)"
    echo -e "${C_BLUE}╚══════════════════════════════════════════════════════════════╝${C_NC}"
    echo
}

# File operations menu
show_file_operations_menu() {
    local options=(
        "🔍 FZF File Browser"
        "📄 File Information"
        "📋 Directory Listing"
        "🔗 Create Symlink"
        "📦 Archive Operations"
        "🔍 Search Files"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "File Operations" \
        "Manage files and directories" \
        "Select an operation:" \
        "${options[@]}")
    
    case "$choice" in
        "🔍 FZF File Browser")
            if command -v show_fzf_file_browser >/dev/null; then
                show_fzf_file_browser
            else
                gui_log_error "FZF file browser not available"
            fi
            ;;
        "📄 File Information")
            _show_file_info_menu
            ;;
        "📋 Directory Listing")
            _show_directory_listing
            ;;
        "🔗 Create Symlink")
            _create_symlink
            ;;
        "📦 Archive Operations")
            _show_archive_operations
            ;;
        "🔍 Search Files")
            _search_files
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Git operations menu
show_git_operations_menu() {
    local options=(
        "📊 Repository Browser"
        "🌿 Branch Manager"
        "📝 Commit History"
        "🔄 Remote Operations"
        "🏷️  Tag Manager"
        "📦 Stash Operations"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Git Operations" \
        "Manage Git repositories" \
        "Select an operation:" \
        "${options[@]}")
    
    case "$choice" in
        "📊 Repository Browser")
            if command -v show_git_repo_browser >/dev/null; then
                show_git_repo_browser
            else
                gui_log_error "Git repository browser not available"
            fi
            ;;
        "🌿 Branch Manager")
            _show_git_branch_manager
            ;;
        "📝 Commit History")
            _show_git_commit_history
            ;;
        "🔄 Remote Operations")
            _show_git_remote_operations
            ;;
        "🏷️  Tag Manager")
            _show_git_tag_manager
            ;;
        "📦 Stash Operations")
            _show_git_stash_operations
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# System tools menu
show_system_tools_menu() {
    local options=(
        "💻 System Information"
        "📊 Process Manager"
        "🌐 Network Tools"
        "💾 Disk Usage"
        "🔧 System Services"
        "📋 Environment Variables"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "System Tools" \
        "System administration and monitoring" \
        "Select a tool:" \
        "${options[@]}")
    
    case "$choice" in
        "💻 System Information")
            _show_system_information
            ;;
        "📊 Process Manager")
            _show_process_manager
            ;;
        "🌐 Network Tools")
            _show_network_tools
            ;;
        "💾 Disk Usage")
            _show_disk_usage
            ;;
        "🔧 System Services")
            _show_system_services
            ;;
        "📋 Environment Variables")
            _show_environment_variables
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Show framework status
show_framework_status() {
    echo -e "${C_BLUE}📊 Framework Status${C_NC}"
    echo
    
    # System information
    echo -e "${C_CYAN}System Information:${C_NC}"
    echo -e "  OS: $(uname -s) $(uname -r)"
    echo -e "  Architecture: $(uname -m)"
    echo -e "  Hostname: $(hostname)"
    echo -e "  User: $USER"
    echo -e "  Shell: $(get_shell_name 2>/dev/null || echo "unknown")"
    echo
    
    # Framework information
    echo -e "${C_CYAN}Framework Information:${C_NC}"
    echo -e "  Version: $(grep 'Version:' gui_framework.sh | head -1 | cut -d: -f2 | xargs)"
    echo -e "  Theme: $(get_current_theme 2>/dev/null || echo "default")"
    echo -e "  Gum Version: $(get_gum_version)"
    echo -e "  Error Log: $ERROR_LOG_FILE"
    echo
    
    # Available integrations
    if command -v show_integrations_status >/dev/null; then
        echo -e "${C_CYAN}Integrations:${C_NC}"
        show_integrations_status
    fi
    
    # Recent errors
    if command -v show_recent_errors >/dev/null; then
        echo -e "${C_CYAN}Recent Errors:${C_NC}"
        show_recent_errors
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Show help and support
show_help_and_support() {
    local options=(
        "📖 User Guide"
        "🔧 Troubleshooting"
        "🐛 Report Bug"
        "💡 Feature Request"
        "📧 Contact Support"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Help & Support" \
        "Get help and support" \
        "Select an option:" \
        "${options[@]}")
    
    case "$choice" in
        "📖 User Guide")
            _show_user_guide
            ;;
        "🔧 Troubleshooting")
            _show_troubleshooting
            ;;
        "🐛 Report Bug")
            _report_bug
            ;;
        "💡 Feature Request")
            _request_feature
            ;;
        "📧 Contact Support")
            _contact_support
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# --- FILE OPERATIONS ---

# Show file information menu
_show_file_info_menu() {
    local file_path=$(show_gui_input \
        "File Information" \
        "Enter file path")
    
    if [[ -n "$file_path" ]]; then
        if command -v _show_file_info >/dev/null; then
            _show_file_info "$file_path"
        else
            _show_basic_file_info "$file_path"
        fi
    fi
}

# Show basic file information
_show_basic_file_info() {
    local file="$1"
    
    echo -e "${C_BLUE}📄 File Information${C_NC}"
    echo
    
    if [[ -e "$file" ]]; then
        local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "unknown")
        local modified=$(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file" 2>/dev/null | xargs -I {} date -d @{} 2>/dev/null || echo "unknown")
        local permissions=$(stat -f%Lp "$file" 2>/dev/null || stat -c%A "$file" 2>/dev/null || echo "unknown")
        
        echo -e "  ${C_GRAY}Path:${C_NC} $file"
        echo -e "  ${C_GRAY}Size:${C_NC} $size bytes"
        echo -e "  ${C_GRAY}Modified:${C_NC} $modified"
        echo -e "  ${C_GRAY}Permissions:${C_NC} $permissions"
        
        if [[ -f "$file" ]]; then
            echo -e "  ${C_GRAY}Type:${C_NC} File"
        elif [[ -d "$file" ]]; then
            echo -e "  ${C_GRAY}Type:${C_NC} Directory"
        elif [[ -L "$file" ]]; then
            echo -e "  ${C_GRAY}Type:${C_NC} Symbolic Link"
            local target=$(readlink "$file")
            echo -e "  ${C_GRAY}Target:${C_NC} $target"
        fi
    else
        echo -e "${C_RED}File not found: $file${C_NC}"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Show directory listing
_show_directory_listing() {
    local dir_path=$(show_gui_input \
        "Directory Listing" \
        "Enter directory path (default: current)")
    
    if [[ -z "$dir_path" ]]; then
        dir_path="."
    fi
    
    if [[ -d "$dir_path" ]]; then
        echo -e "${C_BLUE}📋 Directory Listing: $dir_path${C_NC}"
        echo
        
        # Use tree if available, otherwise use ls
        if command -v tree >/dev/null; then
            tree "$dir_path" -L 2
        else
            ls -la "$dir_path"
        fi
    else
        gui_log_error "Directory not found: $dir_path"
    fi
    
    echo
    read -p "Press Enter to continue..."
}

# Create symlink
_create_symlink() {
    local source=$(show_gui_input \
        "Create Symlink" \
        "Enter source file/directory path")
    
    if [[ -n "$source" ]]; then
        local target=$(show_gui_input \
            "Create Symlink" \
            "Enter target path for symlink")
        
        if [[ -n "$target" ]]; then
            if ln -s "$source" "$target" 2>/dev/null; then
                gui_log_success "Symlink created: $target -> $source"
            else
                gui_log_error "Failed to create symlink"
            fi
        fi
    fi
}

# Show archive operations
_show_archive_operations() {
    local options=(
        "📦 Create Archive"
        "📂 Extract Archive"
        "📋 List Archive Contents"
        "Back to File Operations"
    )
    
    local choice=$(show_gui_menu \
        "Archive Operations" \
        "Manage compressed archives" \
        "Select an operation:" \
        "${options[@]}")
    
    case "$choice" in
        "📦 Create Archive")
            _create_archive
            ;;
        "📂 Extract Archive")
            _extract_archive
            ;;
        "📋 List Archive Contents")
            _list_archive_contents
            ;;
        "Back to File Operations")
            return 0
            ;;
    esac
}

# Search files
_search_files() {
    local search_term=$(show_gui_input \
        "Search Files" \
        "Enter search term")
    
    if [[ -n "$search_term" ]]; then
        local search_path=$(show_gui_input \
            "Search Files" \
            "Enter search path (default: current directory)")
        
        if [[ -z "$search_path" ]]; then
            search_path="."
        fi
        
        echo -e "${C_BLUE}🔍 Searching for: $search_term${C_NC}"
        echo
        
        # Use find to search
        find "$search_path" -name "*$search_term*" -type f 2>/dev/null | head -20
        
        echo
        read -p "Press Enter to continue..."
    fi
}

# --- GIT OPERATIONS ---

# Show git branch manager
_show_git_branch_manager() {
    if ! command -v git >/dev/null; then
        gui_log_error "Git is not installed"
        return 1
    fi
    
    if [[ ! -d ".git" ]]; then
        gui_log_error "Not a git repository"
        return 1
    fi
    
    local options=(
        "📋 List Branches"
        "🌿 Create Branch"
        "🔄 Switch Branch"
        "🗑️  Delete Branch"
        "Back to Git Operations"
    )
    
    local choice=$(show_gui_menu \
        "Git Branch Manager" \
        "Manage Git branches" \
        "Select an operation:" \
        "${options[@]}")
    
    case "$choice" in
        "📋 List Branches")
            _list_git_branches
            ;;
        "🌿 Create Branch")
            _create_git_branch
            ;;
        "🔄 Switch Branch")
            _switch_git_branch
            ;;
        "🗑️  Delete Branch")
            _delete_git_branch
            ;;
        "Back to Git Operations")
            return 0
            ;;
    esac
}

# --- SYSTEM TOOLS ---

# Show system information
_show_system_information() {
    echo -e "${C_BLUE}💻 System Information${C_NC}"
    echo
    
    echo -e "${C_CYAN}Operating System:${C_NC}"
    echo -e "  OS: $(uname -s)"
    echo -e "  Version: $(uname -r)"
    echo -e "  Architecture: $(uname -m)"
    echo -e "  Hostname: $(hostname)"
    echo
    
    echo -e "${C_CYAN}User Information:${C_NC}"
    echo -e "  User: $USER"
    echo -e "  Home: $HOME"
    echo -e "  Shell: $SHELL"
    echo
    
    echo -e "${C_CYAN}System Resources:${C_NC}"
    echo -e "  CPU: $(sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo "unknown") cores"
    echo -e "  Memory: $(sysctl -n hw.memsize 2>/dev/null | awk '{print $0/1024/1024/1024 " GB"}' || free -h 2>/dev/null | grep Mem | awk '{print $2}' || echo "unknown")"
    echo -e "  Uptime: $(uptime 2>/dev/null | cut -d, -f1 || echo "unknown")"
    echo
    
    echo -e "${C_CYAN}Network:${C_NC}"
    echo -e "  IP Address: $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1 || ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1 || echo "unknown")"
    echo
    
    read -p "Press Enter to continue..."
}

# Show process manager
_show_process_manager() {
    local options=(
        "📊 List Processes"
        "🔍 Search Processes"
        "⚡ Kill Process"
        "📈 Process Tree"
        "Back to System Tools"
    )
    
    local choice=$(show_gui_menu \
        "Process Manager" \
        "Manage system processes" \
        "Select an operation:" \
        "${options[@]}")
    
    case "$choice" in
        "📊 List Processes")
            _list_processes
            ;;
        "🔍 Search Processes")
            _search_processes
            ;;
        "⚡ Kill Process")
            _kill_process
            ;;
        "📈 Process Tree")
            _show_process_tree
            ;;
        "Back to System Tools")
            return 0
            ;;
    esac
}

# --- HELP AND SUPPORT ---

# Show user guide
_show_user_guide() {
    echo -e "${C_BLUE}📖 User Guide${C_NC}"
    echo
    echo -e "${C_CYAN}Getting Started:${C_NC}"
    echo -e "  1. The framework provides an enhanced GUI for shell operations"
    echo -e "  2. Use the main menu to navigate between different features"
    echo -e "  3. Most operations support keyboard navigation (arrow keys, Enter, q to quit)"
    echo
    echo -e "${C_CYAN}Key Features:${C_NC}"
    echo -e "  • Theme Manager: Customize the appearance"
    echo -e "  • Tool Integrations: Use popular tools like Git, Docker, FZF"
    echo -e "  • File Operations: Browse and manage files"
    echo -e "  • System Tools: Monitor and manage system resources"
    echo
    echo -e "${C_CYAN}Keyboard Shortcuts:${C_NC}"
    echo -e "  • Arrow keys: Navigate menus"
    echo -e "  • Enter: Select option"
    echo -e "  • q: Quit current operation"
    echo -e "  • Ctrl+C: Force quit"
    echo
    read -p "Press Enter to continue..."
}

# Show troubleshooting
_show_troubleshooting() {
    echo -e "${C_BLUE}🔧 Troubleshooting${C_NC}"
    echo
    echo -e "${C_CYAN}Common Issues:${C_NC}"
    echo
    echo -e "${C_YELLOW}1. Gum not found:${C_NC}"
    echo -e "   Install gum: brew install gum (macOS) or apt install gum (Linux)"
    echo
    echo -e "${C_YELLOW}2. Terminal not interactive:${C_NC}"
    echo -e "   Run the script from a real terminal, not from a script"
    echo
    echo -e "${C_YELLOW}3. Permission denied:${C_NC}"
    echo -e "   Check file permissions and ensure you have write access"
    echo
    echo -e "${C_YELLOW}4. Theme not loading:${C_NC}"
    echo -e "   Check theme configuration files in ~/.config/gui-framework/themes/"
    echo
    echo -e "${C_CYAN}Getting Help:${C_NC}"
    echo -e "  • Check the error log: $ERROR_LOG_FILE"
    echo -e "  • Generate error report using the framework status menu"
    echo -e "  • Report bugs with detailed information"
    echo
    read -p "Press Enter to continue..."
}

# Report bug
_report_bug() {
    echo -e "${C_BLUE}🐛 Report Bug${C_NC}"
    echo
    echo -e "To report a bug, please include:"
    echo -e "  1. Framework version"
    echo -e "  2. Operating system and version"
    echo -e "  3. Shell type and version"
    echo -e "  4. Steps to reproduce"
    echo -e "  5. Error messages"
    echo -e "  6. Error log contents"
    echo
    echo -e "You can generate an error report using the Framework Status menu."
    echo -e "Submit issues at: https://github.com/jagoff/shell-gui-framework/issues"
    echo
    read -p "Press Enter to continue..."
}

# Request feature
_request_feature() {
    echo -e "${C_BLUE}💡 Feature Request${C_NC}"
    echo
    echo -e "To request a new feature, please include:"
    echo -e "  1. Feature description"
    echo -e "  2. Use case and benefits"
    echo -e "  3. Implementation suggestions (if any)"
    echo -e "  4. Priority level"
    echo
    echo -e "Submit feature requests at: https://github.com/jagoff/shell-gui-framework/issues"
    echo
    read -p "Press Enter to continue..."
}

# Contact support
_contact_support() {
    echo -e "${C_BLUE}📧 Contact Support${C_NC}"
    echo
    echo -e "Support channels:"
    echo -e "  • GitHub Issues: https://github.com/jagoff/shell-gui-framework/issues"
    echo -e "  • GitHub Discussions: https://github.com/jagoff/shell-gui-framework/discussions"
    echo -e "  • Documentation: https://github.com/jagoff/shell-gui-framework/blob/main/README.md"
    echo
    echo -e "Before contacting support:"
    echo -e "  1. Check the troubleshooting guide"
    echo -e "  2. Search existing issues"
    echo -e "  3. Generate an error report"
    echo
    read -p "Press Enter to continue..."
}

# --- END OF ENHANCED MENU --- 