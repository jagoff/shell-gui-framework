#!/bin/bash
# Universal Shell GUI Framework Demo

# Load framework
echo "🎨 Loading Universal Shell GUI Framework..."
source ./gui_framework.sh

# Initialize framework
init_gui_framework

# Main demo function
demo_main() {
    while true; do
        local choice=$(show_gui_menu \
            "Universal Shell GUI Framework Demo" \
            "Select a demonstration to run" \
            "Choose an option:" \
            "📊 System Information" \
            "🔧 Configuration" \
            "📝 Data Entry" \
            "🔄 Multi-Select" \
            "🎨 Theme Demo" \
            "❌ Exit Demo")
        
        case "$choice" in
            "📊 System Information")
                demo_system_info
                ;;
            "🔧 Configuration")
                demo_configuration
                ;;
            "📝 Data Entry")
                demo_data_entry
                ;;
            "🔄 Multi-Select")
                demo_multi_select
                ;;
            "🎨 Theme Demo")
                demo_theme_features
                ;;
            "❌ Exit Demo")
                gui_log_success "Demo completed!"
                exit 0
                ;;
        esac
    done
}

# System information demo
demo_system_info() {
    gui_log_info "System Information:"
    echo "OS: $(uname -s)"
    echo "Architecture: $(uname -m)"
    echo "Shell: $SHELL"
    echo "User: $USER"
    
    if show_gui_confirmation "Show detailed system info?"; then
        echo "Kernel: $(uname -r)"
        echo "Uptime: $(uptime)"
    fi
}

# Configuration demo
demo_configuration() {
    gui_log_info "Configuration Demo:"
    
    local setting_name=$(show_gui_input "Enter setting name:" "demo_setting")
    local setting_value=$(show_gui_input "Enter setting value:" "demo_value")
    
    gui_log_success "Configuration: $setting_name = $setting_value"
    
    if show_gui_confirmation "Save this configuration?"; then
        echo "$setting_name=$setting_value" >> /tmp/demo-config.txt
        gui_log_success "Configuration saved"
    fi
}

# Data entry demo
demo_data_entry() {
    gui_log_info "Data Entry Demo:"
    
    local email=$(show_gui_input "Enter email:" "user@example.com")
    local age=$(show_gui_input "Enter age:" "25")
    local name=$(show_gui_input "Enter name:" "John Doe")
    
    gui_log_success "Data collected: $name ($age) - $email"
}

# Multi-select demo
demo_multi_select() {
    gui_log_info "Multi-Select Demo:"
    
    local selected_tools=$(show_gui_multi_select \
        "Development Tools" \
        "Select tools to install" \
        "Available tools:" \
        5 \
        "Git" \
        "Docker" \
        "Node.js" \
        "Python" \
        "Rust")
    
    if [[ -n "$selected_tools" ]]; then
        gui_log_success "Selected: $selected_tools"
    else
        gui_log_warning "No tools selected"
    fi
}

# Theme demo
demo_theme_features() {
    gui_log_info "Theme Demo:"
    
    local theme_choice=$(show_gui_menu \
        "Theme Selection" \
        "Choose a theme to apply" \
        "Select theme:" \
        "Default" \
        "Dark" \
        "High Contrast")
    
    case "$theme_choice" in
        "Default")
            gui_log_success "Applied default theme"
            ;;
        "Dark")
            gui_log_success "Applied dark theme"
            ;;
        "High Contrast")
            gui_log_success "Applied high contrast theme"
            ;;
    esac
}

# Run demo
demo_main 