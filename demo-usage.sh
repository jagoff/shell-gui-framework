#!/bin/bash
# demo-usage.sh - Demonstration of Universal Shell GUI Framework Usage
# This script shows how to use the framework in any project

# --- FRAMEWORK INCLUSION ---
# Method 1: Direct inclusion from Git (no installation needed)
echo "🎨 Loading Universal Shell GUI Framework Enhanced Edition..."
source <(curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/gui_framework.sh)

# Method 2: Local inclusion (if you have the framework locally)
# source ./gui_framework.sh

# Method 3: System installation (if you installed it)
# source ~/.local/bin/gui_framework.sh

# --- INITIALIZE FRAMEWORK ---
init_gui_framework

# --- CHECK FOR ENHANCED FEATURES ---
if command -v show_enhanced_main_menu >/dev/null; then
    ENHANCED_MENU_AVAILABLE=true
    echo "✨ Enhanced features available!"
else
    ENHANCED_MENU_AVAILABLE=false
    echo "ℹ️  Using basic framework features"
fi

# --- DEMONSTRATION FUNCTIONS ---

# Function to demonstrate basic menu
demo_basic_menu() {
    gui_log_info "Demonstrating menu system..."
    
    if [[ "$ENHANCED_MENU_AVAILABLE" == "true" ]]; then
        # Use enhanced menu if available
        show_enhanced_main_menu
    else
        # Fallback to basic menu
        local choice=$(show_gui_menu \
            "Demo Application" \
            "Select a demonstration to run" \
            "Choose an option:" \
            "📊 System Information" \
            "🔧 Configuration" \
            "📝 Data Entry" \
            "🔄 Multi-Select" \
            "🎨 Theme Demo" \
            "🔧 Integration Demo" \
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
            "🔧 Integration Demo")
                demo_integration_features
                ;;
            "❌ Exit Demo")
                gui_log_success "Demo completed!"
                exit 0
                ;;
        esac
    fi
}

# Function to demonstrate system information
demo_system_info() {
    gui_log_info "System Information:"
    echo "Operating System: $(uname -s)"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "Shell: $SHELL"
    echo "User: $USER"
    echo "Home Directory: $HOME"
    
    if show_gui_confirmation "Show detailed system info?"; then
        gui_log_info "Detailed System Information:"
        echo "Kernel: $(uname -r)"
        echo "Platform: $(uname -i)"
        echo "Processor: $(uname -p)"
        echo "Uptime: $(uptime)"
    fi
}

# Function to demonstrate configuration
demo_configuration() {
    gui_log_info "Configuration Demo:"
    
    local setting_name=$(show_gui_input "Enter setting name:" "demo_setting")
    local setting_value=$(show_gui_input "Enter setting value:" "demo_value")
    
    gui_log_success "Configuration saved:"
    echo "Setting: $setting_name"
    echo "Value: $setting_value"
    
    if show_gui_confirmation "Save this configuration?"; then
        # In a real application, you would save to a file
        echo "$setting_name=$setting_value" >> /tmp/demo-config.txt
        gui_log_success "Configuration saved to /tmp/demo-config.txt"
    else
        gui_log_warning "Configuration not saved"
    fi
}

# Function to demonstrate data entry
demo_data_entry() {
    gui_log_info "Data Entry Demo:"
    
    # Email validation example
    local email=$(show_gui_input "Enter email address:" "user@example.com" "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 100)
    gui_log_success "Email entered: $email"
    
    # Number validation example
    local age=$(show_gui_input "Enter age:" "25" "^[0-9]+$" 3)
    gui_log_success "Age entered: $age"
    
    # Text validation example
    local name=$(show_gui_input "Enter name:" "John Doe" "^[a-zA-Z ]+$" 50)
    gui_log_success "Name entered: $name"
    
    gui_log_info "All data collected successfully!"
}

# Function to demonstrate multi-select
demo_multi_select() {
    gui_log_info "Multi-Select Demo:"
    
    local selected_tools=$(show_gui_multi_select \
        "Development Tools" \
        "Select the tools you want to install" \
        "Available tools (space to select, enter to confirm):" \
        5 \
        "Git [Version Control]" \
        "Docker [Containerization]" \
        "Node.js [JavaScript Runtime]" \
        "Python [Programming Language]" \
        "Rust [Systems Programming]" \
        "Go [Programming Language]" \
        "PostgreSQL [Database]" \
        "Redis [Cache/DB]")
    
    if [[ -n "$selected_tools" ]]; then
        gui_log_success "Selected tools:"
        for tool in $selected_tools; do
            echo "  - $tool"
        done
        
        if show_gui_confirmation "Proceed with installation?"; then
            gui_log_info "Starting installation..."
            for tool in $selected_tools; do
                show_gui_spinner "Installing $tool..." sleep 1
                gui_log_success "Installed: $tool"
            done
        else
            gui_log_warning "Installation cancelled"
        fi
    else
        gui_log_warning "No tools selected"
    fi
}

# Function to demonstrate progress
demo_progress() {
    gui_log_info "Progress Demo:"
    
    for i in {1..10}; do
        local percent=$((i * 10))
        show_gui_progress "Processing..." "$percent"
        sleep 0.5
    done
    
    gui_log_success "Progress completed!"
}

# Function to demonstrate performance monitoring
demo_performance() {
    gui_log_info "Performance Monitoring Demo:"
    
    gui_perf_start "demo_operation"
    
    # Simulate some work
    show_gui_spinner "Performing operation..." sleep 2
    
    gui_perf_end "demo_operation"
    
    gui_log_success "Performance monitoring completed!"
}

# Function to demonstrate error handling
demo_error_handling() {
    gui_log_info "Error Handling Demo:"
    
    # Simulate an error condition
    if [[ ! -f "/nonexistent/file" ]]; then
        gui_log_error "File not found: /nonexistent/file"
        
        if show_gui_confirmation "Create a test file instead?"; then
            echo "test content" > /tmp/test-file.txt
            gui_log_success "Test file created: /tmp/test-file.txt"
        else
            gui_log_warning "No action taken"
        fi
    fi
}

# Function to demonstrate theme features
demo_theme_features() {
    gui_log_info "Theme Features Demo:"
    
    if command -v show_theme_manager >/dev/null; then
        echo "🎨 Theme system is available!"
        echo "You can customize colors, fonts, and layouts."
        
        if show_gui_confirmation "Open theme manager?"; then
            show_theme_manager
        fi
    else
        echo "ℹ️  Theme system not available in this demo"
        echo "Install the full framework for theme support."
    fi
    
    # Show current theme information
    if command -v get_current_theme >/dev/null; then
        local current_theme=$(get_current_theme)
        echo "Current theme: $current_theme"
    fi
}

# Function to demonstrate integration features
demo_integration_features() {
    gui_log_info "Integration Features Demo:"
    
    if command -v show_integration_manager >/dev/null; then
        echo "🔧 Integration system is available!"
        echo "You can use tools like Git, Docker, FZF, and more."
        
        if show_gui_confirmation "Open integration manager?"; then
            show_integration_manager
        fi
    else
        echo "ℹ️  Integration system not available in this demo"
        echo "Install the full framework for integration support."
    fi
    
    # Show available integrations
    if command -v get_available_integrations >/dev/null; then
        local available_integrations=($(get_available_integrations))
        if [[ ${#available_integrations[@]} -gt 0 ]]; then
            echo "Available integrations:"
            for integration in "${available_integrations[@]}"; do
                echo "  ✅ $integration"
            done
        fi
    fi
}

# Function to demonstrate shell compatibility
demo_shell_compatibility() {
    gui_log_info "Shell Compatibility Demo:"
    
    if command -v get_shell_name >/dev/null; then
        local shell_name=$(get_shell_name)
        local shell_version=$(get_shell_version)
        
        echo "Current shell: $shell_name"
        echo "Shell version: $shell_version"
        
        if command -v is_shell_supported >/dev/null; then
            if is_shell_supported; then
                echo "✅ Shell is fully supported"
            else
                echo "⚠️  Shell has limited support"
            fi
        fi
        
        if command -v get_shell_capabilities >/dev/null; then
            local capabilities=($(get_shell_capabilities))
            if [[ ${#capabilities[@]} -gt 0 ]]; then
                echo "Shell capabilities:"
                for capability in "${capabilities[@]}"; do
                    echo "  • $capability"
                done
            fi
        fi
    else
        echo "ℹ️  Shell compatibility system not available"
    fi
}

# --- MAIN DEMO LOOP ---
main() {
    gui_log_success "🎨 Universal Shell GUI Framework Demo Started!"
    echo ""
    echo "This demo shows how to use the framework in any project."
    echo "Each option demonstrates different features of the framework."
    echo ""
    
    while true; do
        demo_basic_menu
        
        # Ask if user wants to continue
        if show_gui_confirmation "Run another demonstration?"; then
            continue
        else
            gui_log_success "Demo completed! Thanks for trying the framework!"
            break
        fi
    done
}

# --- RUN DEMO ---
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 