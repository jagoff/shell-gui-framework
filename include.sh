#!/bin/bash
# include.sh - Universal Shell GUI Framework Direct Inclusion
# This script allows you to include the framework directly from Git in any project

# --- CONFIGURATION ---
readonly FRAMEWORK_REPO="https://raw.githubusercontent.com/jagoff/shell-gui-framework/main"
readonly FRAMEWORK_FILE="gui_framework.sh"

# --- COLOR VARIABLES ---
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_BLUE='\033[0;34m'
readonly C_YELLOW='\033[0;93m'
readonly C_NC='\033[0m'

# --- LOGGING FUNCTIONS ---
log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }

# --- DOWNLOAD FRAMEWORK ---
download_framework() {
    local target_dir="${1:-.}"
    local framework_path="$target_dir/$FRAMEWORK_FILE"
    
    log_info "Downloading Universal Shell GUI Framework..."
    
    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"
    
    # Download the framework
    if curl -sSL "$FRAMEWORK_REPO/$FRAMEWORK_FILE" -o "$framework_path"; then
        chmod +x "$framework_path"
        log_success "Framework downloaded to $framework_path"
        return 0
    else
        log_error "Failed to download framework"
        return 1
    fi
}

# --- INCLUDE FRAMEWORK ---
include_framework() {
    local target_dir="${1:-.}"
    local framework_path="$target_dir/$FRAMEWORK_FILE"
    
    # Check if framework exists
    if [[ ! -f "$framework_path" ]]; then
        log_warning "Framework not found at $framework_path"
        if download_framework "$target_dir"; then
            log_info "Framework downloaded successfully"
        else
            log_error "Cannot include framework"
            return 1
        fi
    fi
    
    # Source the framework
    if source "$framework_path"; then
        log_success "Framework included successfully"
        
        # Initialize the framework
        if type init_gui_framework >/dev/null 2>&1; then
            init_gui_framework
            log_success "Framework initialized"
        else
            log_warning "Framework initialization function not found"
        fi
        
        return 0
    else
        log_error "Failed to source framework"
        return 1
    fi
}

# --- SHOW USAGE ---
show_usage() {
    cat << EOF
🎨 Universal Shell GUI Framework - Direct Inclusion

Usage: $0 [OPTIONS]

Options:
    -d, --download DIR    Download framework to directory (default: current)
    -i, --include DIR     Include framework from directory (default: current)
    -h, --help           Show this help

Examples:
    # Download framework to current directory
    $0 -d

    # Download framework to specific directory
    $0 -d ./lib

    # Include framework from current directory
    $0 -i

    # Include framework from specific directory
    $0 -i ./lib

    # Download and include in one command
    $0 -d . && $0 -i .

EOF
}

# --- MAIN ---
main() {
    local action=""
    local target_dir="."
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--download)
                action="download"
                target_dir="${2:-.}"
                shift 2
                ;;
            -i|--include)
                action="include"
                target_dir="${2:-.}"
                shift 2
                ;;
            -h|--help)
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
    
    # Default action
    if [[ -z "$action" ]]; then
        action="include"
    fi
    
    # Execute action
    case "$action" in
        "download")
            download_framework "$target_dir"
            ;;
        "include")
            include_framework "$target_dir"
            ;;
        *)
            log_error "Unknown action: $action"
            exit 1
            ;;
    esac
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 