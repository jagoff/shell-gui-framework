#!/bin/bash
# theme_manager.sh - Theme Management System for Universal Shell GUI Framework
# Version: 1.0.0
# Compatible with: bash, zsh, fish

# --- THEME MANAGEMENT CONFIGURATION ---
readonly THEME_DIR="${GUI_THEME_DIR:-$(dirname "$0")/themes}"
readonly THEME_CONFIG_DIR="${GUI_THEME_CONFIG_DIR:-$HOME/.config/gui-framework/themes}"
readonly DEFAULT_THEME="default"
readonly CURRENT_THEME_FILE="$THEME_CONFIG_DIR/current-theme"

# --- THEME VARIABLES ---
declare -A THEME_COLORS
declare -A THEME_LAYOUT
declare -A THEME_COMPONENTS
declare -A THEME_ACCESSIBILITY

# --- THEME MANAGEMENT FUNCTIONS ---

# Load a theme from file
load_theme() {
    local theme_name="${1:-$DEFAULT_THEME}"
    local theme_file=""
    
    # Check if theme exists in user config first
    if [[ -f "$THEME_CONFIG_DIR/$theme_name.conf" ]]; then
        theme_file="$THEME_CONFIG_DIR/$theme_name.conf"
    elif [[ -f "$THEME_DIR/$theme_name.conf" ]]; then
        theme_file="$THEME_DIR/$theme_name.conf"
    else
        gui_log_error "Theme '$theme_name' not found"
        return 1
    fi
    
    # Clear previous theme
    unset THEME_COLORS THEME_LAYOUT THEME_COMPONENTS THEME_ACCESSIBILITY
    
    # Load theme file
    if [[ -f "$theme_file" ]]; then
        gui_log_debug "Loading theme: $theme_name from $theme_file"
        source "$theme_file"
        
        # Parse theme into associative arrays
        _parse_theme_variables
        
        # Save current theme
        mkdir -p "$THEME_CONFIG_DIR"
        echo "$theme_name" > "$CURRENT_THEME_FILE"
        
        gui_log_success "Theme '$theme_name' loaded successfully"
        return 0
    else
        gui_log_error "Theme file not found: $theme_file"
        return 1
    fi
}

# Parse theme variables into associative arrays
_parse_theme_variables() {
    # Colors
    THEME_COLORS[primary]="${THEME_PRIMARY_COLOR:-#007ACC}"
    THEME_COLORS[secondary]="${THEME_SECONDARY_COLOR:-#6C757D}"
    THEME_COLORS[success]="${THEME_SUCCESS_COLOR:-#28A745}"
    THEME_COLORS[warning]="${THEME_WARNING_COLOR:-#FFC107}"
    THEME_COLORS[error]="${THEME_ERROR_COLOR:-#DC3545}"
    THEME_COLORS[info]="${THEME_INFO_COLOR:-#17A2B8}"
    THEME_COLORS[bg_primary]="${THEME_BG_PRIMARY:-#FFFFFF}"
    THEME_COLORS[bg_secondary]="${THEME_BG_SECONDARY:-#F8F9FA}"
    THEME_COLORS[bg_dark]="${THEME_BG_DARK:-#212529}"
    THEME_COLORS[text_primary]="${THEME_TEXT_PRIMARY:-#212529}"
    THEME_COLORS[text_secondary]="${THEME_TEXT_SECONDARY:-#6C757D}"
    THEME_COLORS[text_light]="${THEME_TEXT_LIGHT:-#FFFFFF}"
    THEME_COLORS[text_muted]="${THEME_TEXT_MUTED:-#ADB5BD}"
    THEME_COLORS[border_primary]="${THEME_BORDER_PRIMARY:-#DEE2E6}"
    THEME_COLORS[border_secondary]="${THEME_BORDER_SECONDARY:-#CED4DA}"
    THEME_COLORS[border_focus]="${THEME_BORDER_FOCUS:-#007ACC}"
    
    # Layout
    THEME_LAYOUT[font_family]="${THEME_FONT_FAMILY:-monospace}"
    THEME_LAYOUT[font_size_normal]="${THEME_FONT_SIZE_NORMAL:-14}"
    THEME_LAYOUT[font_size_small]="${THEME_FONT_SIZE_SMALL:-12}"
    THEME_LAYOUT[font_size_large]="${THEME_FONT_SIZE_LARGE:-16}"
    THEME_LAYOUT[padding_small]="${THEME_PADDING_SMALL:-4}"
    THEME_LAYOUT[padding_normal]="${THEME_PADDING_NORMAL:-8}"
    THEME_LAYOUT[padding_large]="${THEME_PADDING_LARGE:-16}"
    THEME_LAYOUT[margin_small]="${THEME_MARGIN_SMALL:-4}"
    THEME_LAYOUT[margin_normal]="${THEME_MARGIN_NORMAL:-8}"
    THEME_LAYOUT[margin_large]="${THEME_MARGIN_LARGE:-16}"
    THEME_LAYOUT[border_radius]="${THEME_BORDER_RADIUS:-4}"
    THEME_LAYOUT[border_width]="${THEME_BORDER_WIDTH:-1}"
    THEME_LAYOUT[min_width]="${THEME_MIN_WIDTH:-40}"
    THEME_LAYOUT[min_height]="${THEME_MIN_HEIGHT:-20}"
    THEME_LAYOUT[max_width]="${THEME_MAX_WIDTH:-120}"
    THEME_LAYOUT[max_height]="${THEME_MAX_HEIGHT:-40}"
    
    # Components
    THEME_COMPONENTS[menu_bg]="${THEME_MENU_BG:-#FFFFFF}"
    THEME_COMPONENTS[menu_border]="${THEME_MENU_BORDER:-#DEE2E6}"
    THEME_COMPONENTS[menu_selected_bg]="${THEME_MENU_SELECTED_BG:-#007ACC}"
    THEME_COMPONENTS[menu_selected_text]="${THEME_MENU_SELECTED_TEXT:-#FFFFFF}"
    THEME_COMPONENTS[input_bg]="${THEME_INPUT_BG:-#FFFFFF}"
    THEME_COMPONENTS[input_border]="${THEME_INPUT_BORDER:-#DEE2E6}"
    THEME_COMPONENTS[input_focus_border]="${THEME_INPUT_FOCUS_BORDER:-#007ACC}"
    THEME_COMPONENTS[button_primary_bg]="${THEME_BUTTON_PRIMARY_BG:-#007ACC}"
    THEME_COMPONENTS[button_primary_text]="${THEME_BUTTON_PRIMARY_TEXT:-#FFFFFF}"
    THEME_COMPONENTS[button_secondary_bg]="${THEME_BUTTON_SECONDARY_BG:-#6C757D}"
    THEME_COMPONENTS[button_secondary_text]="${THEME_BUTTON_SECONDARY_TEXT:-#FFFFFF}"
    THEME_COMPONENTS[button_danger_bg]="${THEME_BUTTON_DANGER_BG:-#DC3545}"
    THEME_COMPONENTS[button_danger_text]="${THEME_BUTTON_DANGER_TEXT:-#FFFFFF}"
    THEME_COMPONENTS[progress_bg]="${THEME_PROGRESS_BG:-#E9ECEF}"
    THEME_COMPONENTS[progress_fill]="${THEME_PROGRESS_FILL:-#007ACC}"
    THEME_COMPONENTS[progress_text]="${THEME_PROGRESS_TEXT:-#212529}"
    
    # Accessibility
    THEME_ACCESSIBILITY[high_contrast]="${THEME_HIGH_CONTRAST:-false}"
    THEME_ACCESSIBILITY[reduced_motion]="${THEME_REDUCED_MOTION:-false}"
    THEME_ACCESSIBILITY[screen_reader_friendly]="${THEME_SCREEN_READER_FRIENDLY:-true}"
    THEME_ACCESSIBILITY[enable_emojis]="${THEME_ENABLE_EMOJIS:-true}"
    THEME_ACCESSIBILITY[enable_animations]="${THEME_ENABLE_ANIMATIONS:-true}"
    THEME_ACCESSIBILITY[enable_sounds]="${THEME_ENABLE_SOUNDS:-false}"
    THEME_ACCESSIBILITY[enable_hints]="${THEME_ENABLE_HINTS:-true}"
}

# Get current theme name
get_current_theme() {
    if [[ -f "$CURRENT_THEME_FILE" ]]; then
        cat "$CURRENT_THEME_FILE"
    else
        echo "$DEFAULT_THEME"
    fi
}

# List available themes
list_themes() {
    local themes=()
    
    # Add themes from user config
    if [[ -d "$THEME_CONFIG_DIR" ]]; then
        for theme_file in "$THEME_CONFIG_DIR"/*.conf; do
            if [[ -f "$theme_file" ]]; then
                local theme_name=$(basename "$theme_file" .conf)
                themes+=("$theme_name (custom)")
            fi
        done
    fi
    
    # Add themes from framework
    if [[ -d "$THEME_DIR" ]]; then
        for theme_file in "$THEME_DIR"/*.conf; do
            if [[ -f "$theme_file" ]]; then
                local theme_name=$(basename "$theme_file" .conf)
                themes+=("$theme_name")
            fi
        done
    fi
    
    printf '%s\n' "${themes[@]}"
}

# Create a custom theme
create_custom_theme() {
    local theme_name="$1"
    local base_theme="${2:-$DEFAULT_THEME}"
    
    if [[ -z "$theme_name" ]]; then
        gui_log_error "Theme name is required"
        return 1
    fi
    
    # Create config directory if it doesn't exist
    mkdir -p "$THEME_CONFIG_DIR"
    
    local custom_theme_file="$THEME_CONFIG_DIR/$theme_name.conf"
    
    if [[ -f "$custom_theme_file" ]]; then
        gui_log_warning "Theme '$theme_name' already exists. Overwriting..."
    fi
    
    # Copy base theme
    local base_theme_file=""
    if [[ -f "$THEME_CONFIG_DIR/$base_theme.conf" ]]; then
        base_theme_file="$THEME_CONFIG_DIR/$base_theme.conf"
    elif [[ -f "$THEME_DIR/$base_theme.conf" ]]; then
        base_theme_file="$THEME_DIR/$base_theme.conf"
    else
        gui_log_error "Base theme '$base_theme' not found"
        return 1
    fi
    
    cp "$base_theme_file" "$custom_theme_file"
    
    # Add custom theme header
    local header="# Custom Theme: $theme_name (based on $base_theme)
# Created: $(date)
# Edit this file to customize your theme

"
    
    # Prepend header to file
    echo -e "$header$(cat "$custom_theme_file")" > "$custom_theme_file"
    
    gui_log_success "Custom theme '$theme_name' created from '$base_theme'"
    gui_log_info "Edit: $custom_theme_file"
}

# Delete a custom theme
delete_custom_theme() {
    local theme_name="$1"
    
    if [[ -z "$theme_name" ]]; then
        gui_log_error "Theme name is required"
        return 1
    fi
    
    local custom_theme_file="$THEME_CONFIG_DIR/$theme_name.conf"
    
    if [[ ! -f "$custom_theme_file" ]]; then
        gui_log_error "Custom theme '$theme_name' not found"
        return 1
    fi
    
    if show_gui_confirmation "Delete custom theme '$theme_name'?"; then
        rm "$custom_theme_file"
        gui_log_success "Custom theme '$theme_name' deleted"
        
        # If this was the current theme, switch to default
        if [[ "$(get_current_theme)" == "$theme_name" ]]; then
            load_theme "$DEFAULT_THEME"
        fi
    fi
}

# Get theme color
get_theme_color() {
    local color_name="$1"
    echo "${THEME_COLORS[$color_name]:-}"
}

# Get theme layout property
get_theme_layout() {
    local property_name="$1"
    echo "${THEME_LAYOUT[$property_name]:-}"
}

# Get theme component style
get_theme_component() {
    local component_name="$1"
    echo "${THEME_COMPONENTS[$component_name]:-}"
}

# Get theme accessibility setting
get_theme_accessibility() {
    local setting_name="$1"
    echo "${THEME_ACCESSIBILITY[$setting_name]:-}"
}

# Apply theme to gum configuration
apply_theme_to_gum() {
    # Set gum environment variables based on theme
    export GUM_CHOOSE_CURSOR_FOREGROUND="${THEME_COLORS[primary]}"
    export GUM_CHOOSE_CURSOR_BACKGROUND="${THEME_COLORS[bg_primary]}"
    export GUM_CHOOSE_SELECTED_FOREGROUND="${THEME_COLORS[text_light]}"
    export GUM_CHOOSE_SELECTED_BACKGROUND="${THEME_COLORS[primary]}"
    export GUM_INPUT_CURSOR_FOREGROUND="${THEME_COLORS[primary]}"
    export GUM_INPUT_BORDER_FOREGROUND="${THEME_COLORS[border_primary]}"
    export GUM_INPUT_BORDER_FOREGROUND_FOCUSED="${THEME_COLORS[border_focus]}"
    export GUM_SPINNER_SPINNER="${THEME_COLORS[primary]}"
    export GUM_PROGRESS_FILL_CHAR="█"
    export GUM_PROGRESS_EMPTY_CHAR="░"
    export GUM_PROGRESS_FILL_FOREGROUND="${THEME_COLORS[primary]}"
    export GUM_PROGRESS_EMPTY_FOREGROUND="${THEME_COLORS[text_muted]}"
    
    gui_log_debug "Gum theme configuration applied"
}

# Initialize theme system
init_theme_system() {
    # Create theme directories if they don't exist
    mkdir -p "$THEME_CONFIG_DIR"
    
    # Load current theme or default
    local current_theme=$(get_current_theme)
    if ! load_theme "$current_theme"; then
        gui_log_warning "Failed to load theme '$current_theme', falling back to default"
        load_theme "$DEFAULT_THEME"
    fi
    
    # Apply theme to gum
    apply_theme_to_gum
    
    gui_log_debug "Theme system initialized with theme: $(get_current_theme)"
}

# Theme management menu
show_theme_manager() {
    local current_theme=$(get_current_theme)
    local themes=($(list_themes))
    
    echo -e "${C_BLUE}🎨 Theme Manager${C_NC}"
    echo -e "${C_GRAY}Current theme: $current_theme${C_NC}"
    echo
    
    local options=(
        "Change Theme"
        "Create Custom Theme"
        "Delete Custom Theme"
        "List Available Themes"
        "Back to Main Menu"
    )
    
    local choice=$(show_gui_menu \
        "Theme Manager" \
        "Manage visual themes and customization" \
        "Select an option:" \
        "${options[@]}")
    
    case "$choice" in
        "Change Theme")
            _change_theme_menu
            ;;
        "Create Custom Theme")
            _create_theme_menu
            ;;
        "Delete Custom Theme")
            _delete_theme_menu
            ;;
        "List Available Themes")
            _list_themes_detailed
            ;;
        "Back to Main Menu")
            return 0
            ;;
    esac
}

# Change theme menu
_change_theme_menu() {
    local themes=($(list_themes))
    local current_theme=$(get_current_theme)
    
    echo -e "${C_BLUE}🔄 Change Theme${C_NC}"
    echo -e "${C_GRAY}Current: $current_theme${C_NC}"
    echo
    
    local choice=$(show_gui_menu \
        "Select Theme" \
        "Choose a theme to apply" \
        "Available themes:" \
        "${themes[@]}")
    
    if [[ -n "$choice" ]]; then
        local theme_name=$(echo "$choice" | sed 's/ (custom)//')
        if load_theme "$theme_name"; then
            apply_theme_to_gum
            gui_log_success "Theme changed to: $theme_name"
        fi
    fi
}

# Create theme menu
_create_theme_menu() {
    local theme_name=$(show_gui_input \
        "Custom Theme Name" \
        "Enter a name for your custom theme")
    
    if [[ -n "$theme_name" ]]; then
        local base_themes=($(list_themes | grep -v " (custom)"))
        local base_theme=$(show_gui_menu \
            "Select Base Theme" \
            "Choose a theme to base your custom theme on" \
            "Base themes:" \
            "${base_themes[@]}")
        
        if [[ -n "$base_theme" ]]; then
            create_custom_theme "$theme_name" "$base_theme"
        fi
    fi
}

# Delete theme menu
_delete_theme_menu() {
    local custom_themes=($(list_themes | grep " (custom)" | sed 's/ (custom)//'))
    
    if [[ ${#custom_themes[@]} -eq 0 ]]; then
        gui_log_info "No custom themes found"
        return
    fi
    
    local choice=$(show_gui_menu \
        "Delete Custom Theme" \
        "Select a custom theme to delete" \
        "Custom themes:" \
        "${custom_themes[@]}")
    
    if [[ -n "$choice" ]]; then
        delete_custom_theme "$choice"
    fi
}

# List themes with details
_list_themes_detailed() {
    echo -e "${C_BLUE}📋 Available Themes${C_NC}"
    echo
    
    local themes=($(list_themes))
    for theme in "${themes[@]}"; do
        local theme_name=$(echo "$theme" | sed 's/ (custom)//')
        local is_custom=$(echo "$theme" | grep -q " (custom)" && echo " (Custom)")
        local is_current=""
        
        if [[ "$theme_name" == "$(get_current_theme)" ]]; then
            is_current=" ${C_GREEN}← Current${C_NC}"
        fi
        
        echo -e "  • $theme_name$is_custom$is_current"
    done
    echo
}

# --- END OF THEME MANAGER --- 