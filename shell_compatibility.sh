#!/bin/bash
# shell_compatibility.sh - Multi-Shell Compatibility Layer for Universal Shell GUI Framework
# Version: 1.0.0
# Compatible with: bash, zsh, fish

# --- SHELL DETECTION AND COMPATIBILITY ---

# Detect current shell
detect_shell() {
    local shell_name=""
    local shell_version=""
    
    # Get shell name
    if [[ -n "$BASH_VERSION" ]]; then
        shell_name="bash"
        shell_version="$BASH_VERSION"
    elif [[ -n "$ZSH_VERSION" ]]; then
        shell_name="zsh"
        shell_version="$ZSH_VERSION"
    elif [[ -n "$FISH_VERSION" ]]; then
        shell_name="fish"
        shell_version="$FISH_VERSION"
    else
        # Fallback detection
        shell_name=$(basename "$SHELL")
        shell_version="unknown"
    fi
    
    echo "$shell_name:$shell_version"
}

# Get shell name only
get_shell_name() {
    local shell_info=$(detect_shell)
    echo "${shell_info%:*}"
}

# Get shell version only
get_shell_version() {
    local shell_info=$(detect_shell)
    echo "${shell_info#*:}"
}

# Check if current shell is supported
is_shell_supported() {
    local shell_name=$(get_shell_name)
    case "$shell_name" in
        bash|zsh|fish)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Get shell-specific configuration
get_shell_config() {
    local shell_name=$(get_shell_name)
    local config_dir="$HOME/.config/gui-framework/shells"
    local config_file="$config_dir/$shell_name.conf"
    
    if [[ -f "$config_file" ]]; then
        echo "$config_file"
    else
        echo ""
    fi
}

# --- SHELL-SPECIFIC ADAPTATIONS ---

# Initialize shell-specific settings
init_shell_compatibility() {
    local shell_name=$(get_shell_name)
    
    gui_log_debug "Initializing compatibility for shell: $shell_name"
    
    case "$shell_name" in
        bash)
            _init_bash_compatibility
            ;;
        zsh)
            _init_zsh_compatibility
            ;;
        fish)
            _init_fish_compatibility
            ;;
        *)
            gui_log_warning "Unsupported shell: $shell_name, using bash compatibility"
            _init_bash_compatibility
            ;;
    esac
    
    # Load shell-specific configuration
    _load_shell_config
    
    gui_log_debug "Shell compatibility initialized for $shell_name"
}

# Initialize bash compatibility
_init_bash_compatibility() {
    # Enable extended globbing
    shopt -s extglob 2>/dev/null || true
    
    # Enable null globbing
    shopt -s nullglob 2>/dev/null || true
    
    # Enable case-insensitive globbing
    shopt -s nocaseglob 2>/dev/null || true
    
    # Set bash-specific options
    set -o pipefail 2>/dev/null || true
    
    # Enable associative arrays (bash 4+)
    if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
        declare -A _BASH_ASSOC_ARRAYS_ENABLED=1
    fi
    
    gui_log_debug "Bash compatibility initialized (version: $BASH_VERSION)"
}

# Initialize zsh compatibility
_init_zsh_compatibility() {
    # Enable extended globbing
    setopt extended_glob 2>/dev/null || true
    
    # Enable null globbing
    setopt null_glob 2>/dev/null || true
    
    # Enable case-insensitive globbing
    setopt no_case_glob 2>/dev/null || true
    
    # Disable flow control
    setopt no_flow_control 2>/dev/null || true
    
    # Enable word splitting
    setopt sh_word_split 2>/dev/null || true
    
    # Disable auto-cd
    unsetopt auto_cd 2>/dev/null || true
    
    gui_log_debug "Zsh compatibility initialized (version: $ZSH_VERSION)"
}

# Initialize fish compatibility
_init_fish_compatibility() {
    # Fish has different syntax, so we need to adapt
    # Most functions will need to be rewritten for fish
    
    # Set fish-specific options
    set -g fish_autosuggestion_enabled 0 2>/dev/null || true
    
    # Disable fish greeting
    set -g fish_greeting "" 2>/dev/null || true
    
    gui_log_debug "Fish compatibility initialized (version: $FISH_VERSION)"
    gui_log_warning "Fish shell support is limited. Consider using bash or zsh for full functionality."
}

# Load shell-specific configuration
_load_shell_config() {
    local config_file=$(get_shell_config)
    
    if [[ -n "$config_file" && -f "$config_file" ]]; then
        gui_log_debug "Loading shell config: $config_file"
        source "$config_file"
    else
        gui_log_debug "No shell-specific configuration found"
    fi
}

# --- CROSS-SHELL FUNCTION ADAPTATIONS ---

# Array operations that work across shells
array_contains() {
    local needle="$1"
    shift
    local haystack=("$@")
    
    local shell_name=$(get_shell_name)
    
    case "$shell_name" in
        bash|zsh)
            # Use bash/zsh array syntax
            for item in "${haystack[@]}"; do
                if [[ "$item" == "$needle" ]]; then
                    return 0
                fi
            done
            ;;
        fish)
            # Fish has different array syntax
            for item in $haystack; do
                if [[ "$item" == "$needle" ]]; then
                    return 0
                fi
            done
            ;;
    esac
    
    return 1
}

# Safe array length
array_length() {
    local array_name="$1"
    local shell_name=$(get_shell_name)
    
    case "$shell_name" in
        bash|zsh)
            eval "echo \${#$array_name[@]}"
            ;;
        fish)
            # Fish arrays are different
            eval "echo \${#$array_name}"
            ;;
    esac
}

# Safe array access
array_get() {
    local array_name="$1"
    local index="$2"
    local shell_name=$(get_shell_name)
    
    case "$shell_name" in
        bash|zsh)
            eval "echo \"\${$array_name[$index]}\""
            ;;
        fish)
            eval "echo \"\${$array_name[$index]}\""
            ;;
    esac
}

# Safe array assignment
array_set() {
    local array_name="$1"
    local index="$2"
    local value="$3"
    local shell_name=$(get_shell_name)
    
    case "$shell_name" in
        bash|zsh)
            eval "$array_name[$index]=\"$value\""
            ;;
        fish)
            eval "set -g $array_name[$index] \"$value\""
            ;;
    esac
}

# --- SHELL-SPECIFIC PATH HANDLING ---

# Get shell-specific path
get_shell_path() {
    local shell_name=$(get_shell_name)
    
    case "$shell_name" in
        bash)
            echo "$HOME/.bashrc"
            ;;
        zsh)
            echo "$HOME/.zshrc"
            ;;
        fish)
            echo "$HOME/.config/fish/config.fish"
            ;;
        *)
            echo "$HOME/.profile"
            ;;
    esac
}

# Add to shell path
add_to_shell_path() {
    local path_to_add="$1"
    local shell_file=$(get_shell_path)
    
    if [[ -f "$shell_file" ]]; then
        # Check if path is already in file
        if ! grep -q "$path_to_add" "$shell_file" 2>/dev/null; then
            echo "export PATH=\"$path_to_add:\$PATH\"" >> "$shell_file"
            gui_log_success "Added $path_to_add to $shell_file"
            return 0
        else
            gui_log_info "Path $path_to_add already exists in $shell_file"
            return 0
        fi
    else
        gui_log_error "Shell configuration file not found: $shell_file"
        return 1
    fi
}

# --- SHELL-SPECIFIC ALIAS HANDLING ---

# Add shell alias
add_shell_alias() {
    local alias_name="$1"
    local alias_command="$2"
    local shell_file=$(get_shell_path)
    
    if [[ -f "$shell_file" ]]; then
        # Check if alias already exists
        if ! grep -q "alias $alias_name=" "$shell_file" 2>/dev/null; then
            echo "alias $alias_name='$alias_command'" >> "$shell_file"
            gui_log_success "Added alias $alias_name to $shell_file"
            return 0
        else
            gui_log_info "Alias $alias_name already exists in $shell_file"
            return 0
        fi
    else
        gui_log_error "Shell configuration file not found: $shell_file"
        return 1
    fi
}

# --- SHELL-SPECIFIC FUNCTION HANDLING ---

# Add shell function
add_shell_function() {
    local function_name="$1"
    local function_body="$2"
    local shell_file=$(get_shell_path)
    
    if [[ -f "$shell_file" ]]; then
        # Check if function already exists
        if ! grep -q "$function_name()" "$shell_file" 2>/dev/null; then
            echo "" >> "$shell_file"
            echo "$function_name() {" >> "$shell_file"
            echo "$function_body" >> "$shell_file"
            echo "}" >> "$shell_file"
            gui_log_success "Added function $function_name to $shell_file"
            return 0
        else
            gui_log_info "Function $function_name already exists in $shell_file"
            return 0
        fi
    else
        gui_log_error "Shell configuration file not found: $shell_file"
        return 1
    fi
}

# --- SHELL-SPECIFIC COMPLETION ---

# Get completion file path
get_completion_file() {
    local shell_name=$(get_shell_name)
    local command_name="$1"
    
    case "$shell_name" in
        bash)
            echo "/etc/bash_completion.d/$command_name"  # System-wide
            # or "$HOME/.local/share/bash-completion/completions/$command_name"  # User-specific
            ;;
        zsh)
            echo "$HOME/.zsh/completions/_$command_name"  # User-specific
            ;;
        fish)
            echo "$HOME/.config/fish/completions/$command_name.fish"  # User-specific
            ;;
        *)
            echo ""
            ;;
    esac
}

# Install completion
install_completion() {
    local command_name="$1"
    local completion_content="$2"
    local completion_file=$(get_completion_file "$command_name")
    
    if [[ -n "$completion_file" ]]; then
        # Create directory if it doesn't exist
        mkdir -p "$(dirname "$completion_file")"
        
        # Write completion content
        echo "$completion_content" > "$completion_file"
        
        gui_log_success "Installed completion for $command_name"
        return 0
    else
        gui_log_warning "Completion not supported for current shell"
        return 1
    fi
}

# --- SHELL-SPECIFIC ENVIRONMENT ---

# Set shell-specific environment variable
set_shell_env() {
    local var_name="$1"
    local var_value="$2"
    local shell_file=$(get_shell_path)
    
    if [[ -f "$shell_file" ]]; then
        # Check if variable already exists
        if ! grep -q "export $var_name=" "$shell_file" 2>/dev/null; then
            echo "export $var_name=\"$var_value\"" >> "$shell_file"
            gui_log_success "Added environment variable $var_name to $shell_file"
            return 0
        else
            gui_log_info "Environment variable $var_name already exists in $shell_file"
            return 0
        fi
    else
        gui_log_error "Shell configuration file not found: $shell_file"
        return 1
    fi
}

# --- SHELL DETECTION AND VALIDATION ---

# Validate shell environment
validate_shell_environment() {
    local shell_name=$(get_shell_name)
    local shell_version=$(get_shell_version)
    local errors=()
    local warnings=()
    
    # Check if shell is supported
    if ! is_shell_supported; then
        errors+=("Unsupported shell: $shell_name")
    fi
    
    # Check shell version requirements
    case "$shell_name" in
        bash)
            if [[ ${BASH_VERSINFO[0]} -lt 4 ]]; then
                warnings+=("Bash version $shell_version detected. Version 4.0+ recommended for full functionality.")
            fi
            ;;
        zsh)
            if [[ ${ZSH_VERSION%%.*} -lt 5 ]]; then
                warnings+=("Zsh version $shell_version detected. Version 5.0+ recommended for full functionality.")
            fi
            ;;
        fish)
            if [[ ${FISH_VERSION%%.*} -lt 3 ]]; then
                warnings+=("Fish version $shell_version detected. Version 3.0+ recommended for full functionality.")
            fi
            ;;
    esac
    
    # Check required features
    if ! command -v printf >/dev/null; then
        errors+=("printf command not found")
    fi
    
    if ! command -v grep >/dev/null; then
        errors+=("grep command not found")
    fi
    
    # Report errors and warnings
    if [[ ${#errors[@]} -gt 0 ]]; then
        for error in "${errors[@]}"; do
            gui_log_error "$error"
        done
        return 1
    fi
    
    if [[ ${#warnings[@]} -gt 0 ]]; then
        for warning in "${warnings[@]}"; do
            gui_log_warning "$warning"
        done
    fi
    
    return 0
}

# Get shell capabilities
get_shell_capabilities() {
    local shell_name=$(get_shell_name)
    local capabilities=()
    
    case "$shell_name" in
        bash)
            capabilities+=("associative_arrays")
            capabilities+=("extended_globbing")
            capabilities+=("process_substitution")
            if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
                capabilities+=("associative_arrays")
            fi
            ;;
        zsh)
            capabilities+=("associative_arrays")
            capabilities+=("extended_globbing")
            capabilities+=("process_substitution")
            capabilities+=("advanced_completion")
            ;;
        fish)
            capabilities+=("associative_arrays")
            capabilities+=("advanced_completion")
            ;;
    esac
    
    printf '%s\n' "${capabilities[@]}"
}

# --- SHELL-SPECIFIC INITIALIZATION ---

# Generate shell-specific initialization code
generate_shell_init() {
    local shell_name=$(get_shell_name)
    local framework_path="$1"
    
    case "$shell_name" in
        bash)
            cat <<EOF
# Universal Shell GUI Framework - Bash Initialization
# Add this to your ~/.bashrc

# Source the framework
if [[ -f "$framework_path/gui_framework.sh" ]]; then
    source "$framework_path/gui_framework.sh"
    source "$framework_path/theme_manager.sh"
    source "$framework_path/error_handler.sh"
    source "$framework_path/shell_compatibility.sh"
    
    # Initialize the framework
    init_gui_framework
    init_theme_system
    init_error_handler
    init_shell_compatibility
    
    # Add framework to PATH
    export PATH="$framework_path:\$PATH"
fi
EOF
            ;;
        zsh)
            cat <<EOF
# Universal Shell GUI Framework - Zsh Initialization
# Add this to your ~/.zshrc

# Source the framework
if [[ -f "$framework_path/gui_framework.sh" ]]; then
    source "$framework_path/gui_framework.sh"
    source "$framework_path/theme_manager.sh"
    source "$framework_path/error_handler.sh"
    source "$framework_path/shell_compatibility.sh"
    
    # Initialize the framework
    init_gui_framework
    init_theme_system
    init_error_handler
    init_shell_compatibility
    
    # Add framework to PATH
    export PATH="$framework_path:\$PATH"
fi
EOF
            ;;
        fish)
            cat <<EOF
# Universal Shell GUI Framework - Fish Initialization
# Add this to your ~/.config/fish/config.fish

# Source the framework (limited support)
if test -f "$framework_path/gui_framework.sh"
    # Note: Fish support is limited
    # Consider using bash or zsh for full functionality
    echo "Universal Shell GUI Framework: Fish support is limited"
end

# Add framework to PATH
set -gx PATH "$framework_path" \$PATH
EOF
            ;;
    esac
}

# --- END OF SHELL COMPATIBILITY --- 