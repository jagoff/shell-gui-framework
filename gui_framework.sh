#!/bin/bash
# gui_framework.sh - Universal Shell GUI Framework (English Only)
# Version: 1.0.0
# Compatible with: bash, zsh
# Dependency: gum

# --- UNIVERSAL COLOR VARIABLES ---
readonly C_RED='\033[0;31m'        # Red - Errors and critical alerts
readonly C_GREEN='\033[0;32m'      # Green - Success and confirmations
readonly C_BLUE='\033[0;34m'       # Blue - Information and titles
readonly C_YELLOW='\033[0;93m'     # Yellow - Warnings and prompts
readonly C_CYAN='\033[0;36m'       # Cyan - Technical info
readonly C_MAGENTA='\033[0;35m'    # Magenta - Special highlights
readonly C_WHITE='\033[1;37m'      # White - Main text
readonly C_GRAY='\033[0;90m'       # Gray - Secondary text
readonly C_NC='\033[0m'            # Reset color

# --- UNIVERSAL LOGGING FUNCTIONS ---
log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }
log_debug() { echo -e "${C_GRAY}[DEBUG] $1${C_NC}"; }
log_verbose() { if [[ "${VERBOSE:-false}" = true ]]; then echo -e "${C_GRAY}   [VERBOSE] $1${C_NC}"; fi; }

# --- GUM VERSION DETECTION ---
get_gum_version() {
    if ! command -v gum >/dev/null; then
        echo "0.0.0"
        return
    fi
    gum --version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+'
}

supports_gum_unselected_flags() {
    local version=$(get_gum_version)
    local major=$(echo "$version" | cut -d. -f1)
    local minor=$(echo "$version" | cut -d. -f2)
    local patch=$(echo "$version" | cut -d. -f3)
    # gum >= 0.13.0 supports unselected flags
    if (( major > 0 )) || (( major == 0 && minor > 12 )) || (( major == 0 && minor == 12 && patch >= 0 )); then
        return 0
    else
        return 1
    fi
}

# --- DEPENDENCY CHECK ---
check_gui_dependencies() {
    if ! command -v gum >/dev/null; then
        log_warning "Gum is not installed. Installing..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install gum
        elif command -v apt-get >/dev/null; then
            sudo apt-get update && sudo apt-get install -y gum
        elif command -v yum >/dev/null; then
            sudo yum install -y gum
        else
            log_error "Gum is not available. Please install it manually from: https://github.com/charmbracelet/gum"
            return 1
        fi
    fi
    return 0
}

# --- TTY DETECTION ---
require_tty() {
    if [[ ! -t 0 ]]; then
        log_error "This menu requires an interactive terminal (TTY). Please run the script from a real terminal."
        exit 2
    fi
}

# --- GUI COMPONENTS ---
show_gui_menu() {
    require_tty
    local title="$1"
    local subtitle="$2"
    local header="$3"
    shift 3
    local options=("$@")
    echo -e "${C_BLUE}📋 $title${C_NC}"
    echo -e "${C_GRAY}$subtitle${C_NC}"
    gum choose \
        --header="$header" \
        "${options[@]}"
}

show_gui_multi_select() {
    require_tty
    local title="$1"
    local subtitle="$2"
    local header="$3"
    local limit="${4:-5}"
    shift 4
    local options=("$@")
    echo -e "${C_BLUE}📋 $title${C_NC}"
    echo -e "${C_GRAY}$subtitle${C_NC}"
    gum choose \
        --header="$header" \
        --limit="$limit" \
        "${options[@]}"
}

show_gui_confirmation() {
    require_tty
    local message="$1"
    local affirmative="${2:-Yes, continue}"
    local negative="${3:-No, cancel}"
    gum confirm \
        --affirmative="$affirmative" \
        --negative="$negative" \
        "$message"
    local result=$?
    return $result
}

show_gui_input() {
    require_tty
    local prompt="$1"
    local placeholder="${2:-}"
    gum input \
        --prompt="$prompt" \
        --placeholder="$placeholder"
}

show_gui_spinner() {
    local title="$1"
    shift
    gum spin \
        --spinner="dots" \
        --title="$title" \
        -- "$@"
}

show_gui_progress() {
    local title="$1"
    local percent="$2"
    gum progress \
        --percent="$percent" \
        --width=50 \
        --title="$title"
}

# --- GUM CONFIGURATION (OPTIONAL) ---
setup_gum_config() {
    if supports_gum_unselected_flags; then
        export GUM_CHOOSE_UNSELECTED_FOREGROUND="#ffffff"
        export GUM_CHOOSE_UNSELECTED_BACKGROUND="#333333"
        log_debug "Advanced gum config applied"
    else
        log_debug "Using basic gum config"
    fi
}

# --- FRAMEWORK INITIALIZATION ---
init_gui_framework() {
    check_gui_dependencies
    setup_gum_config
    log_info "GUI framework initialized"
}

# --- END OF UNIVERSAL SHELL GUI FRAMEWORK --- 