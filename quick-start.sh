#!/bin/bash
# quick-start.sh - Universal Shell GUI Framework Quick Start
# This script provides one-liner examples for using the framework

# --- CONFIGURATION ---
readonly FRAMEWORK_REPO="https://raw.githubusercontent.com/jagoff/shell-gui-framework/main"
readonly FRAMEWORK_FILE="gui_framework.sh"

# --- COLOR VARIABLES ---
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_BLUE='\033[0;34m'
readonly C_YELLOW='\033[0;93m'
readonly C_CYAN='\033[0;36m'
readonly C_NC='\033[0m'

# --- LOGGING FUNCTIONS ---
log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }
log_code() { echo -e "${C_CYAN}$1${C_NC}"; }

# --- SHOW QUICK START GUIDE ---
show_quick_start() {
    cat << EOF
🎨 Universal Shell GUI Framework - Quick Start Guide

📋 Prerequisites:
   - Git installed
   - Gum installed (brew install gum)

🚀 Installation Options:

1️⃣ One-liner installation:
$(log_code "curl -sSL $FRAMEWORK_REPO/install.sh | bash")

2️⃣ Clone and install:
$(log_code "git clone https://github.com/your-username/universal-shell-gui-framework.git && cd universal-shell-gui-framework && ./install.sh")

3️⃣ Direct inclusion in your script:
$(log_code "source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)")

📝 Usage Examples:

🔹 Basic menu in your script:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

choice=$(show_gui_menu "My App" "Select action" "Choose:" "Install" "Configure" "Exit")
echo "Selected: $choice"')

🔹 Multi-select with validation:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

tools=$(show_gui_multi_select "Tools" "Select tools" "Tools:" 3 "Git" "Docker" "Node.js" "Python")
echo "Selected tools: $tools"')

🔹 Input with validation:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

name=$(show_gui_input "Enter name:" "John Doe" "^[a-zA-Z ]+$" 50)
echo "Hello, $name!"')

🔹 Confirmation dialog:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

if show_gui_confirmation "Continue with installation?"; then
    echo "Proceeding..."
else
    echo "Cancelled"
fi')

🔹 Progress indicator:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

show_gui_spinner "Installing..." sleep 3
echo "Done!"')

📚 Advanced Usage:

🔹 Custom configuration:
$(log_code '#!/bin/bash
# Set configuration before sourcing
export GUI_VERBOSE=true
export GUI_CONFIG_FILE="$HOME/.config/my-app.conf"

source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework')

🔹 Error handling:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)

if ! init_gui_framework; then
    echo "Failed to initialize framework"
    exit 1
fi

# Your code here...')

🔹 Performance monitoring:
$(log_code '#!/bin/bash
source <(curl -sSL $FRAMEWORK_REPO/gui_framework.sh)
init_gui_framework

gui_perf_start "operation"
# Your slow operation here
sleep 2
gui_perf_end "operation"')

📁 Project Structure:
$(log_code 'my-project/
├── my-script.sh          # Your main script
├── lib/                  # Optional: local framework copy
│   └── gui_framework.sh
└── config/               # Optional: project config
    └── gui-framework.conf')

🔧 Development:

🔹 Run tests:
$(log_code "curl -sSL $FRAMEWORK_REPO/test_gui_framework.sh | bash")

🔹 Check framework info:
$(log_code "curl -sSL $FRAMEWORK_REPO/gui_framework.sh | grep -A 5 'Version:'")

🔹 View documentation:
$(log_code "curl -sSL $FRAMEWORK_REPO/docs/API_REFERENCE.md")

💡 Tips:
- Always call init_gui_framework after sourcing
- Use gui_log_* functions for consistent logging
- Handle user cancellation gracefully
- Test in both interactive and non-interactive environments

🎯 Next Steps:
1. Choose an installation method
2. Create your first script
3. Explore the examples in the repository
4. Customize the configuration
5. Share your projects!

EOF
}

# --- DOWNLOAD FRAMEWORK ---
download_framework() {
    local target="${1:-gui_framework.sh}"
    
    log_info "Downloading framework to $target..."
    
    if curl -sSL "$FRAMEWORK_REPO/gui_framework.sh" -o "$target"; then
        chmod +x "$target"
        log_success "Framework downloaded to $target"
        return 0
    else
        log_error "Failed to download framework"
        return 1
    fi
}

# --- CREATE EXAMPLE SCRIPT ---
create_example() {
    local script_name="${1:-example.sh}"
    
    log_info "Creating example script: $script_name"
    
    cat > "$script_name" << 'EOF'
#!/bin/bash
# Example script using Universal Shell GUI Framework

# Include the framework (replace with your actual repository URL)
source <(curl -sSL https://raw.githubusercontent.com/your-username/universal-shell-gui-framework/main/gui_framework.sh)

# Initialize the framework
init_gui_framework

# Main application logic
main() {
    while true; do
        local choice=$(show_gui_menu \
            "Example Application" \
            "What would you like to do?" \
            "Select an action:" \
            "📊 Show System Info" \
            "🔧 Configure Settings" \
            "📝 Enter Data" \
            "❌ Exit")
        
        case "$choice" in
            "📊 Show System Info")
                show_system_info
                ;;
            "🔧 Configure Settings")
                configure_settings
                ;;
            "📝 Enter Data")
                enter_data
                ;;
            "❌ Exit")
                gui_log_success "Goodbye!"
                exit 0
                ;;
        esac
        
        # Ask if user wants to continue
        if show_gui_confirmation "Do you want to perform another action?"; then
            continue
        else
            gui_log_success "Goodbye!"
            exit 0
        fi
    done
}

# Example functions
show_system_info() {
    gui_log_info "System Information:"
    echo "OS: $(uname -s)"
    echo "Architecture: $(uname -m)"
    echo "Shell: $SHELL"
    echo "User: $USER"
}

configure_settings() {
    local setting=$(show_gui_input "Enter setting name:" "default_setting")
    local value=$(show_gui_input "Enter setting value:" "default_value")
    
    gui_log_success "Setting configured: $setting = $value"
}

enter_data() {
    local tools=$(show_gui_multi_select \
        "Select Tools" \
        "Choose the tools you want to install" \
        "Available tools:" \
        3 \
        "Git" \
        "Docker" \
        "Node.js" \
        "Python" \
        "Rust")
    
    gui_log_success "Selected tools: $tools"
}

# Run the application
main "$@"
EOF
    
    chmod +x "$script_name"
    log_success "Example script created: $script_name"
    log_info "Run it with: ./$script_name"
}

# --- MAIN ---
main() {
    case "${1:-help}" in
        "help"|"-h"|"--help")
            show_quick_start
            ;;
        "download"|"-d"|"--download")
            download_framework "$2"
            ;;
        "example"|"-e"|"--example")
            create_example "$2"
            ;;
        "install"|"-i"|"--install")
            log_info "Installing framework..."
            if download_framework; then
                log_success "Installation completed!"
                log_info "Run: ./gui_framework.sh to test"
            fi
            ;;
        *)
            log_error "Unknown command: $1"
            log_info "Run: $0 help for usage"
            exit 1
            ;;
    esac
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 