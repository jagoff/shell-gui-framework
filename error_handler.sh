#!/bin/bash
# error_handler.sh - Enhanced Error Handling System for Universal Shell GUI Framework
# Version: 1.0.0
# Compatible with: bash, zsh, fish

# --- ERROR HANDLING CONFIGURATION ---
readonly ERROR_LOG_FILE="${GUI_ERROR_LOG:-$HOME/.cache/gui-framework/errors.log}"
readonly ERROR_REPORT_DIR="${GUI_ERROR_REPORT_DIR:-$HOME/.cache/gui-framework/reports}"
readonly MAX_ERROR_LOG_SIZE="${GUI_MAX_ERROR_LOG_SIZE:-1048576}" # 1MB
readonly ERROR_RETENTION_DAYS="${GUI_ERROR_RETENTION_DAYS:-30}"

# --- ERROR SEVERITY LEVELS ---
readonly ERROR_SEVERITY_LOW=1
readonly ERROR_SEVERITY_MEDIUM=2
readonly ERROR_SEVERITY_HIGH=3
readonly ERROR_SEVERITY_CRITICAL=4

# --- ERROR CATEGORIES ---
readonly ERROR_CATEGORY_DEPENDENCY="dependency"
readonly ERROR_CATEGORY_PERMISSION="permission"
readonly ERROR_CATEGORY_NETWORK="network"
readonly ERROR_CATEGORY_VALIDATION="validation"
readonly ERROR_CATEGORY_SYSTEM="system"
readonly ERROR_CATEGORY_USER="user"
readonly ERROR_CATEGORY_UNKNOWN="unknown"

# --- ERROR HANDLING FUNCTIONS ---

# Initialize error handling system
init_error_handler() {
    # Create error log directory
    mkdir -p "$(dirname "$ERROR_LOG_FILE")"
    mkdir -p "$ERROR_REPORT_DIR"
    
    # Set up error log rotation
    _setup_error_log_rotation
    
    # Set up error handlers
    _setup_error_handlers
    
    gui_log_debug "Error handling system initialized"
}

# Setup error log rotation
_setup_error_log_rotation() {
    if [[ -f "$ERROR_LOG_FILE" ]]; then
        local file_size=$(stat -f%z "$ERROR_LOG_FILE" 2>/dev/null || stat -c%s "$ERROR_LOG_FILE" 2>/dev/null || echo 0)
        if [[ $file_size -gt $MAX_ERROR_LOG_SIZE ]]; then
            mv "$ERROR_LOG_FILE" "$ERROR_LOG_FILE.old"
            gui_log_debug "Error log rotated"
        fi
    fi
    
    # Clean old error reports
    find "$ERROR_REPORT_DIR" -name "*.log" -mtime +$ERROR_RETENTION_DAYS -delete 2>/dev/null || true
}

# Setup error handlers
_setup_error_handlers() {
    # Set up trap for script errors
    trap '_handle_script_error $? $LINENO $BASH_LINENO' ERR
    
    # Set up trap for script exit
    trap '_handle_script_exit' EXIT
    
    # Set up trap for interrupt signals
    trap '_handle_interrupt' INT TERM
}

# Handle script errors
_handle_script_error() {
    local exit_code="$1"
    local line_number="$2"
    local bash_lineno="$3"
    
    # Don't handle errors if we're already in error handling
    if [[ "${_IN_ERROR_HANDLING:-false}" == "true" ]]; then
        return
    fi
    
    _IN_ERROR_HANDLING=true
    
    local error_message="Script error occurred at line $line_number (exit code: $exit_code)"
    local error_details=""
    
    # Get more details about the error
    if [[ -n "$bash_lineno" ]]; then
        error_details="Stack trace: ${BASH_LINENO[*]}"
    fi
    
    # Log the error
    log_error "$ERROR_CATEGORY_SYSTEM" "$ERROR_SEVERITY_HIGH" "$error_message" "$error_details"
    
    # Show user-friendly error message
    show_error_message "An unexpected error occurred" \
        "The application encountered an error and needs to exit." \
        "Error code: $exit_code" \
        "Please check the error log for more details."
    
    _IN_ERROR_HANDLING=false
    exit "$exit_code"
}

# Handle script exit
_handle_script_exit() {
    local exit_code="$?"
    
    # Only handle if it's not a normal exit
    if [[ $exit_code -ne 0 ]]; then
        gui_log_debug "Script exiting with code: $exit_code"
    fi
}

# Handle interrupt signals
_handle_interrupt() {
    gui_log_info "Interrupt signal received, cleaning up..."
    
    # Clean up any temporary files or processes
    _cleanup_on_exit
    
    gui_log_info "Cleanup completed, exiting gracefully"
    exit 0
}

# Cleanup on exit
_cleanup_on_exit() {
    # Remove temporary files
    if [[ -n "${_TEMP_FILES:-}" ]]; then
        for temp_file in "${_TEMP_FILES[@]}"; do
            if [[ -f "$temp_file" ]]; then
                rm -f "$temp_file"
                gui_log_debug "Removed temporary file: $temp_file"
            fi
        done
    fi
    
    # Kill background processes
    if [[ -n "${_BACKGROUND_PIDS:-}" ]]; then
        for pid in "${_BACKGROUND_PIDS[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                kill "$pid" 2>/dev/null
                gui_log_debug "Terminated background process: $pid"
            fi
        done
    fi
}

# Log an error with details
log_error() {
    local category="${1:-$ERROR_CATEGORY_UNKNOWN}"
    local severity="${2:-$ERROR_SEVERITY_MEDIUM}"
    local message="$3"
    local details="${4:-}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local script_name=$(basename "${BASH_SOURCE[1]:-unknown}")
    local line_number="${BASH_LINENO[0]:-unknown}"
    
    # Create error entry
    local error_entry="[$timestamp] [$category] [SEV:$severity] [$script_name:$line_number] $message"
    if [[ -n "$details" ]]; then
        error_entry="$error_entry | Details: $details"
    fi
    
    # Log to file
    echo "$error_entry" >> "$ERROR_LOG_FILE"
    
    # Log to stderr with appropriate color
    case $severity in
        $ERROR_SEVERITY_LOW)
            gui_log_warning "$message"
            ;;
        $ERROR_SEVERITY_MEDIUM)
            gui_log_error "$message"
            ;;
        $ERROR_SEVERITY_HIGH|$ERROR_SEVERITY_CRITICAL)
            echo -e "${C_RED}🚨 CRITICAL ERROR: $message${C_NC}" >&2
            ;;
    esac
    
    # Log details if provided
    if [[ -n "$details" ]]; then
        gui_log_debug "Error details: $details"
    fi
}

# Show user-friendly error message
show_error_message() {
    local title="$1"
    local description="$2"
    local details="$3"
    local suggestions="$4"
    
    # Check if we're in an interactive terminal
    if [[ ! -t 0 ]]; then
        # Non-interactive mode, just log
        gui_log_error "$title: $description"
        if [[ -n "$details" ]]; then
            gui_log_debug "Details: $details"
        fi
        return
    fi
    
    # Interactive mode, show formatted error
    echo
    echo -e "${C_RED}╔══════════════════════════════════════════════════════════════╗${C_NC}"
    echo -e "${C_RED}║                        ERROR                                ║${C_NC}"
    echo -e "${C_RED}╠══════════════════════════════════════════════════════════════╣${C_NC}"
    echo -e "${C_RED}║${C_NC} $title"
    echo -e "${C_RED}║${C_NC}"
    echo -e "${C_RED}║${C_NC} $description"
    if [[ -n "$details" ]]; then
        echo -e "${C_RED}║${C_NC}"
        echo -e "${C_RED}║${C_NC} $details"
    fi
    if [[ -n "$suggestions" ]]; then
        echo -e "${C_RED}║${C_NC}"
        echo -e "${C_RED}║${C_NC} $suggestions"
    fi
    echo -e "${C_RED}╚══════════════════════════════════════════════════════════════╝${C_NC}"
    echo
}

# Handle dependency errors
handle_dependency_error() {
    local dependency="$1"
    local install_command="$2"
    local error_message="$3"
    
    log_error "$ERROR_CATEGORY_DEPENDENCY" "$ERROR_SEVERITY_HIGH" \
        "Missing dependency: $dependency" "$error_message"
    
    show_error_message \
        "Missing Required Dependency" \
        "The application requires '$dependency' to function properly." \
        "Error: $error_message" \
        "Install command: $install_command"
    
    # Offer to install the dependency
    if show_gui_confirmation "Would you like to install $dependency now?"; then
        gui_log_info "Installing $dependency..."
        eval "$install_command"
        
        if command -v "$dependency" >/dev/null; then
            gui_log_success "$dependency installed successfully"
            return 0
        else
            gui_log_error "Failed to install $dependency"
            return 1
        fi
    fi
    
    return 1
}

# Handle permission errors
handle_permission_error() {
    local operation="$1"
    local resource="$2"
    local required_permission="$3"
    
    log_error "$ERROR_CATEGORY_PERMISSION" "$ERROR_SEVERITY_HIGH" \
        "Permission denied: $operation on $resource" "Required: $required_permission"
    
    show_error_message \
        "Permission Denied" \
        "You don't have sufficient permissions to $operation." \
        "Resource: $resource" \
        "Required permission: $required_permission"
}

# Handle network errors
handle_network_error() {
    local operation="$1"
    local url="$2"
    local error_code="$3"
    
    log_error "$ERROR_CATEGORY_NETWORK" "$ERROR_SEVERITY_MEDIUM" \
        "Network error during $operation" "URL: $url, Code: $error_code"
    
    show_error_message \
        "Network Error" \
        "Failed to connect to the network during $operation." \
        "URL: $url" \
        "Error code: $error_code"
}

# Handle validation errors
handle_validation_error() {
    local field="$1"
    local value="$2"
    local expected_format="$3"
    
    log_error "$ERROR_CATEGORY_VALIDATION" "$ERROR_SEVERITY_MEDIUM" \
        "Validation failed for field: $field" "Value: $value, Expected: $expected_format"
    
    show_error_message \
        "Invalid Input" \
        "The value you entered for '$field' is not valid." \
        "Value: $value" \
        "Expected format: $expected_format"
}

# Handle user errors
handle_user_error() {
    local action="$1"
    local reason="$2"
    local suggestion="$3"
    
    log_error "$ERROR_CATEGORY_USER" "$ERROR_SEVERITY_LOW" \
        "User error during $action" "Reason: $reason"
    
    show_error_message \
        "Action Failed" \
        "The action '$action' could not be completed." \
        "Reason: $reason" \
        "Suggestion: $suggestion"
}

# Check if error log exists and show recent errors
show_recent_errors() {
    if [[ ! -f "$ERROR_LOG_FILE" ]]; then
        gui_log_info "No error log found"
        return
    fi
    
    local recent_errors=$(tail -n 10 "$ERROR_LOG_FILE" 2>/dev/null)
    if [[ -n "$recent_errors" ]]; then
        echo -e "${C_YELLOW}📋 Recent Errors:${C_NC}"
        echo "$recent_errors"
        echo
    else
        gui_log_info "No recent errors found"
    fi
}

# Generate error report
generate_error_report() {
    local report_file="$ERROR_REPORT_DIR/error_report_$(date +%Y%m%d_%H%M%S).log"
    
    mkdir -p "$ERROR_REPORT_DIR"
    
    {
        echo "=== Universal Shell GUI Framework Error Report ==="
        echo "Generated: $(date)"
        echo "Framework Version: $(grep 'Version:' gui_framework.sh | head -1 | cut -d: -f2 | xargs)"
        echo "Shell: $SHELL"
        echo "OS: $(uname -s) $(uname -r)"
        echo "User: $USER"
        echo "Home: $HOME"
        echo
        
        echo "=== Recent Errors ==="
        if [[ -f "$ERROR_LOG_FILE" ]]; then
            tail -n 50 "$ERROR_LOG_FILE"
        else
            echo "No error log found"
        fi
        echo
        
        echo "=== System Information ==="
        echo "Terminal: $TERM"
        echo "Terminal Size: $(tput cols)x$(tput lines)"
        echo "Gum Version: $(gum --version 2>/dev/null || echo 'Not installed')"
        echo
        
        echo "=== Environment Variables ==="
        env | grep -E '^(GUI_|THEME_|GUM_)' | sort
        echo
        
        echo "=== Configuration Files ==="
        for config_file in "$HOME/.config/gui-framework"/*; do
            if [[ -f "$config_file" ]]; then
                echo "Config: $config_file"
                echo "Size: $(stat -f%z "$config_file" 2>/dev/null || stat -c%s "$config_file" 2>/dev/null || echo 'unknown') bytes"
                echo "Modified: $(stat -f%m "$config_file" 2>/dev/null || stat -c%Y "$config_file" 2>/dev/null | xargs -I {} date -d @{} 2>/dev/null || echo 'unknown')"
                echo
            fi
        done
    } > "$report_file"
    
    gui_log_success "Error report generated: $report_file"
    echo "$report_file"
}

# Validate error handling configuration
validate_error_config() {
    local errors=()
    
    # Check if error log directory is writable
    if [[ ! -w "$(dirname "$ERROR_LOG_FILE")" ]]; then
        errors+=("Error log directory is not writable: $(dirname "$ERROR_LOG_FILE")")
    fi
    
    # Check if report directory is writable
    if [[ ! -w "$ERROR_REPORT_DIR" ]]; then
        errors+=("Error report directory is not writable: $ERROR_REPORT_DIR")
    fi
    
    # Check log file size limit
    if [[ ! "$MAX_ERROR_LOG_SIZE" =~ ^[0-9]+$ ]]; then
        errors+=("Invalid MAX_ERROR_LOG_SIZE: $MAX_ERROR_LOG_SIZE")
    fi
    
    # Check retention days
    if [[ ! "$ERROR_RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
        errors+=("Invalid ERROR_RETENTION_DAYS: $ERROR_RETENTION_DAYS")
    fi
    
    if [[ ${#errors[@]} -gt 0 ]]; then
        for error in "${errors[@]}"; do
            gui_log_error "$error"
        done
        return 1
    fi
    
    return 0
}

# Add temporary file for cleanup
add_temp_file() {
    local temp_file="$1"
    _TEMP_FILES+=("$temp_file")
}

# Add background process for cleanup
add_background_process() {
    local pid="$1"
    _BACKGROUND_PIDS+=("$pid")
}

# --- END OF ERROR HANDLER --- 