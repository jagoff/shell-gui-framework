#!/bin/bash
# demo-usage.sh - Demonstration of Universal Shell GUI Framework Usage
# This script shows how to use the framework in any project

# --- FRAMEWORK INCLUSION ---
# Method 1: Direct inclusion from Git (no installation needed)
echo "🎨 Loading Universal Shell GUI Framework..."
source <(curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/gui_framework.sh)

# Method 2: Local inclusion (if you have the framework locally)
# source ./gui_framework.sh

# Method 3: System installation (if you installed it)
# source ~/.local/bin/gui_framework.sh

# --- INITIALIZE FRAMEWORK ---
init_gui_framework

# --- DEMONSTRATION FUNCTIONS ---

# Function to demonstrate basic menu
demo_basic_menu() {
    gui_log_info "Demonstrating basic menu..."
    
    local choice=$(show_gui_menu \
        "Demo Application" \
        "Select a demonstration to run" \
        "Choose an option:" \
        "📊 System Information" \
        "🔧 Configuration" \
        "📝 Data Entry" \
        "🔄 Multi-Select" \
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
        "❌ Exit Demo")
            gui_log_success "Demo completed!"
            exit 0
            ;;
    esac
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