#!/bin/bash
# Universal Shell GUI Framework Installer

set -e

# Colors
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_BLUE='\033[0;34m'
readonly C_YELLOW='\033[0;93m'
readonly C_NC='\033[0m'

# Logging
log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }

# Configuration
readonly FRAMEWORK_NAME="universal-shell-gui-framework"
readonly INSTALL_DIR="$HOME/.local/share/$FRAMEWORK_NAME"
readonly BIN_DIR="$HOME/.local/bin"

# Check dependencies
check_dependencies() {
    log_info "Checking dependencies..."
    
    if ! command -v gum >/dev/null; then
        log_warning "Gum is not installed"
        log_info "Installing Gum..."
        
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install gum
        elif command -v apt-get >/dev/null; then
            sudo apt-get update && sudo apt-get install -y gum
        elif command -v yum >/dev/null; then
            sudo yum install -y gum
        else
            log_error "Cannot install Gum automatically. Please install it manually."
            exit 1
        fi
    fi
    
    log_success "All dependencies are installed"
}

# Install framework
install_framework() {
    log_info "Installing Universal Shell GUI Framework..."
    
    # Create directories
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"
    
    # Copy framework files
    cp gui_framework.sh "$INSTALL_DIR/"
    cp theme_manager.sh "$INSTALL_DIR/"
    cp error_handler.sh "$INSTALL_DIR/"
    cp shell_compatibility.sh "$INSTALL_DIR/"
    cp integrations.sh "$INSTALL_DIR/"
    cp enhanced_menu.sh "$INSTALL_DIR/"
    
    # Copy themes
    cp -r themes "$INSTALL_DIR/"
    
    # Create launcher script
    cat > "$BIN_DIR/gui-framework" << 'EOF'
#!/bin/bash
source "$HOME/.local/share/universal-shell-gui-framework/gui_framework.sh"
init_gui_framework
show_enhanced_main_menu "$@"
EOF
    
    chmod +x "$BIN_DIR/gui-framework"
    
    log_success "Framework installed successfully!"
    log_info "Run 'gui-framework' to start"
}

# Main
main() {
    echo "🎨 Universal Shell GUI Framework Installer"
    echo
    
    check_dependencies
    install_framework
}

main "$@" 