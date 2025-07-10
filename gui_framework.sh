#!/bin/bash
# gui_framework.sh - Universal Shell GUI Framework (English Only)
# Version: 1.1.0
# Compatible with: bash, zsh
# Dependency: gum

# --- FRAMEWORK CONFIGURATION ---
# These can be overridden by setting environment variables
readonly GUI_CONFIG_FILE="${GUI_CONFIG_FILE:-$HOME/.config/gui-framework.conf}"
readonly GUI_THEME_NAME="${GUI_THEME_NAME:-default}"
readonly GUI_VERBOSE="${GUI_VERBOSE:-false}"
readonly GUI_DEBUG="${GUI_DEBUG:-false}"

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
gui_log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
gui_log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
gui_log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
gui_log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }
gui_log_debug() { echo -e "${C_GRAY}[DEBUG] $1${C_NC}"; }
gui_log_verbose() { if [[ "${VERBOSE:-false}" = true ]]; then echo -e "${C_GRAY}   [VERBOSE] $1${C_NC}"; fi; }

# --- EXIT HANDLING ---
gui_handle_quit() {
    local message="${1:-Exiting..."}"
    gui_log_info "$message"
    exit 0
}

# --- GUM VERSION DETECTION ---
# Cache for gum version to avoid multiple calls
_GUM_VERSION_CACHE=""

get_gum_version() {
    if [[ -n "$_GUM_VERSION_CACHE" ]]; then
        echo "$_GUM_VERSION_CACHE"
        return
    fi
    
    if ! command -v gum >/dev/null; then
        _GUM_VERSION_CACHE="0.0.0"
        echo "$_GUM_VERSION_CACHE"
        return
    fi
    
    _GUM_VERSION_CACHE=$(gum --version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
    echo "$_GUM_VERSION_CACHE"
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
        gui_log_warning "Gum is not installed. Installing..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install gum
        elif command -v apt-get >/dev/null; then
            sudo apt-get update && sudo apt-get install -y gum
        elif command -v yum >/dev/null; then
            sudo yum install -y gum
        else
            gui_log_error "Gum is not available. Please install it manually from: https://github.com/charmbracelet/gum"
            return 1
        fi
    fi
    return 0
}

# --- TTY DETECTION ---
require_tty() {
    if [[ ! -t 0 ]]; then
        gui_log_error "This menu requires an interactive terminal TTY. Please run the script from a real terminal."
        exit 2
    fi
}

# --- GUI COMPONENTS WITH 'q' EXIT FUNCTIONALITY ---
show_gui_menu() {
    require_tty
    local title="$1"
    local subtitle="$2"
    local header="$3"
    shift 3
    local options=("$@")
    
    echo -e "${C_BLUE}📋 $title${C_NC}"
    echo -e "${C_GRAY}$subtitle${C_NC}"
    echo -e "${C_GRAY}←→ toggle • enter submit • q Quit${C_NC}"
    
    local result
    result=$(gum choose \
        --header="$header" \
        "${options[@]}")
    
    # Check if user pressed 'q' or cancelled
    if [[ -z "$result" ]]; then
        gui_handle_quit "Menu cancelled by user"
    fi
    
    echo "$result"
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
    echo -e "${C_GRAY}←→ toggle • space select • enter submit • q Quit${C_NC}"
    
    local result
    result=$(gum choose \
        --header="$header" \
        --limit="$limit" \
        "${options[@]}")
    
    # Check if user pressed 'q' or cancelled
    if [[ -z "$result" ]]; then
        gui_handle_quit "Multi-select cancelled by user"
    fi
    
    echo "$result"
}

show_gui_confirmation() {
    require_tty
    local message="$1"
    local affirmative="Yes, continue"
    local negative="No, cancel"
    
    echo -e "${C_GRAY}y Yes, continue • n No, cancel • q Quit${C_NC}"
    
    # Use a custom approach to handle 'q' exit
    local choice
    choice=$(gum choose \
        --header="$message" \
        "$affirmative" \
        "$negative" \
        "Quit \(q\)")
    
    case "$choice" in
        "$affirmative")
            return 0
            ;;
        "$negative"|"Quit \(q\)")
            gui_handle_quit "Confirmation cancelled by user"
            ;;
        *)
            # User cancelled or pressed Ctrl+C
            gui_handle_quit "Confirmation cancelled by user"
            ;;
    esac
}

show_gui_input() {
    require_tty
    local prompt="$1"
    local placeholder="${2:-}"
    local pattern="${3:-.*}"
    local max_length="${4:-1000}"
    
    echo -e "${C_GRAY}type and enter submit • q Quit${C_NC}"
    
    while true; do
        local result
        result=$(gum input \
            --prompt="$prompt" \
            --placeholder="$placeholder")
        
        # Check if user pressed 'q' or cancelled
        if [[ -z "$result" ]]; then
            gui_handle_quit "Input cancelled by user"
        fi
        
        # Check if user entered 'q' to quit
        if [[ "$result" == "q" ]]; then
            gui_handle_quit "Input cancelled by user"
        fi
        
        # Sanitize and validate input
        result=$(gui_sanitize_input "$result")
        
        if gui_validate_input "$result" "$pattern" "$max_length"; then
            echo "$result"
            return 0
        else
            gui_log_warning "Invalid input. Please try again."
            continue
        fi
    done
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

# --- ENHANCED MENU WITH QUIT OPTION ---
show_gui_menu_with_quit() {
    require_tty
    local title="$1"
    local subtitle="$2"
    local header="$3"
    shift 3
    local options=("$@")
    
    # Add quit option to the menu
    local menu_options=("${options[@]}" "Quit \(q\)")
    
    echo -e "${C_BLUE}📋 $title${C_NC}"
    echo -e "${C_GRAY}$subtitle${C_NC}"
    echo -e "${C_GRAY}←→ toggle • enter submit • q Quit${C_NC}"
    
    local result
    result=$(gum choose \
        --header="$header" \
        "${menu_options[@]}")
    
    # Check if user selected quit or cancelled
    if [[ -z "$result" ]] || [[ "$result" == "Quit \(q\)" ]]; then
        gui_handle_quit "Menu cancelled by user"
    fi
    
    echo "$result"
}

# --- GUM CONFIGURATION (OPTIONAL) ---
setup_gum_config() {
    if supports_gum_unselected_flags; then
        export GUM_CHOOSE_UNSELECTED_FOREGROUND="#ffffff"
        export GUM_CHOOSE_UNSELECTED_BACKGROUND="#333333"
        gui_log_debug "Advanced gum config applied"
    else
        gui_log_debug "Using basic gum config"
    fi
}

# --- CONFIGURATION MANAGEMENT ---
load_gui_config() {
    if [[ -f "$GUI_CONFIG_FILE" ]]; then
        gui_log_debug "Loading configuration from $GUI_CONFIG_FILE"
        source "$GUI_CONFIG_FILE"
    else
        gui_log_debug "No configuration file found, using defaults"
    fi
}

# --- INPUT VALIDATION ---
gui_validate_input() {
    local input="$1"
    local pattern="${2:-.*}"
    local max_length="${3:-1000}"
    
    # Check if input is empty
    if [[ -z "$input" ]]; then
        return 1
    fi
    
    # Check length
    if [[ ${#input} -gt $max_length ]]; then
        return 1
    fi
    
    # Check pattern
    if [[ ! "$input" =~ $pattern ]]; then
        return 1
    fi
    
    return 0
}

# --- PERFORMANCE MONITORING ---
_GUI_PERF_START_TIME=""
_GUI_PERF_MEASUREMENTS=()

gui_perf_start() {
    local label="$1"
    _GUI_PERF_START_TIME=$(date +%s.%N)
    _GUI_PERF_MEASUREMENTS+=("$label:$GUI_PERF_START_TIME")
    gui_log_debug "Performance measurement started: $label"
}

gui_perf_end() {
    local label="$1"
    local end_time=$(date +%s.%N)
    
    # Find the start time for this label
    for measurement in "${_GUI_PERF_MEASUREMENTS[@]}"; do
        if [[ "$measurement" == "$label:"* ]]; then
            local start_time="${measurement#*:}"
            local duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "0")
            gui_log_debug "Performance measurement ended: $label - ${duration}s"
            
            # Remove from measurements array
            _GUI_PERF_MEASUREMENTS=("${_GUI_PERF_MEASUREMENTS[@]/$measurement}")
            return 0
        fi
    done
    
    gui_log_warning "No start time found for performance measurement: $label"
}

gui_perf_report() {
    if [[ ${#_GUI_PERF_MEASUREMENTS[@]} -gt 0 ]]; then
        gui_log_warning "Unfinished performance measurements: ${_GUI_PERF_MEASUREMENTS[*]}"
    fi
}

gui_sanitize_input() {
    local input="$1"
    
    # Remove control characters except newlines and tabs
    echo "$input" | tr -d '\000-\010\013\014\016-\037'
}

gui_validate_filename() {
    local filename="$1"
    
    # Check for dangerous characters
    if [[ "$filename" =~ [<>:"/\\|?*] ]]; then
        return 1
    fi
    
    # Check for reserved names (Windows)
    local reserved_names=("CON" "PRN" "AUX" "NUL" "COM1" "COM2" "COM3" "COM4" "COM5" "COM6" "COM7" "COM8" "COM9" "LPT1" "LPT2" "LPT3" "LPT4" "LPT5" "LPT6" "LPT7" "LPT8" "LPT9")
    for reserved in "${reserved_names[@]}"; do
        if [[ "${filename^^}" == "$reserved" ]]; then
            return 1
        fi
    done
    
    return 0
}

# --- FRAMEWORK INITIALIZATION ---
init_gui_framework() {
    load_gui_config
    check_gui_dependencies
    setup_gum_config
    gui_log_info "GUI framework initialized"
}

# --- END OF UNIVERSAL SHELL GUI FRAMEWORK --- 