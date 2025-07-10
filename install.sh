#!/bin/bash
# install.sh - Universal Shell GUI Framework Installer
# Version: 1.0.0

set -e

# --- CONFIGURATION ---
readonly FRAMEWORK_NAME="universal-shell-gui-framework"
readonly DEFAULT_INSTALL_DIR="$HOME/.local/share/$FRAMEWORK_NAME"
readonly DEFAULT_BIN_DIR="$HOME/.local/bin"
readonly DEFAULT_CONFIG_DIR="$HOME/.config"

# --- COLOR VARIABLES ---
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_BLUE='\033[0;34m'
readonly C_YELLOW='\033[0;93m'
readonly C_NC='\033[0m'

# --- LOGGING FUNCTIONS ---
log_success() { echo -e "${C_GREEN}✅ $1${C_NC}"; }
log_error() { echo -e "${C_RED}❌ $1${C_NC}" >&2; }
log_warning() { echo -e "${C_YELLOW}⚠️  $1${C_NC}"; }
log_info() { echo -e "${C_BLUE}ℹ️  $1${C_NC}"; }

# --- USAGE ---
show_usage() {
    cat << EOF
🎨 Universal Shell GUI Framework Installer

Usage: $0 [OPTIONS]

Options:
    -r, --repo URL       Git repository URL (default: current repo)
    -d, --dir PATH       Installation directory (default: $DEFAULT_INSTALL_DIR)
    -b, --bin PATH       Binary directory (default: $DEFAULT_BIN_DIR)
    -c, --config PATH    Config directory (default: $DEFAULT_CONFIG_DIR)
    -f, --force          Force reinstallation
    -u, --update         Update existing installation
    -h, --help           Show this help

Examples:
    # Install from current repository
    $0

    # Install from specific Git repository
    $0 -r https://github.com/username/universal-shell-gui-framework

    # Install to custom directory
    $0 -d /opt/gui-framework

    # Update existing installation
    $0 -u

EOF
}

# --- PARSE ARGUMENTS ---
REPO_URL=""
INSTALL_DIR="$DEFAULT_INSTALL_DIR"
BIN_DIR="$DEFAULT_BIN_DIR"
CONFIG_DIR="$DEFAULT_CONFIG_DIR"
FORCE=false
UPDATE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--repo)
            REPO_URL="$2"
            shift 2
            ;;
        -d|--dir)
            INSTALL_DIR="$2"
            shift 2
            ;;
        -b|--bin)
            BIN_DIR="$2"
            shift 2
            ;;
        -c|--config)
            CONFIG_DIR="$2"
            shift 2
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -u|--update)
            UPDATE=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# --- DETECT CURRENT REPO ---
if [[ -z "$REPO_URL" ]]; then
    if [[ -d ".git" ]]; then
        REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
        if [[ -z "$REPO_URL" ]]; then
            log_error "Could not detect Git repository URL"
            log_info "Please specify with -r option"
            exit 1
        fi
    else
        # Default to the actual repository URL
        REPO_URL="https://github.com/jagoff/shell-gui-framework.git"
    fi
fi

# --- CHECK DEPENDENCIES ---
check_dependencies() {
    log_info "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v git >/dev/null; then
        missing_deps+=("git")
    fi
    
    if ! command -v gum >/dev/null; then
        missing_deps+=("gum")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_warning "Missing dependencies: ${missing_deps[*]}"
        
        read -p "Install missing dependencies? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_dependencies "${missing_deps[@]}"
        else
            log_error "Cannot proceed without dependencies"
            exit 1
        fi
    else
        log_success "All dependencies are installed"
    fi
}

# --- INSTALL DEPENDENCIES ---
install_dependencies() {
    local deps=("$@")
    
    for dep in "${deps[@]}"; do
        case "$dep" in
            "git")
                log_info "Installing Git..."
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    brew install git
                elif command -v apt-get >/dev/null; then
                    sudo apt-get update && sudo apt-get install -y git
                elif command -v yum >/dev/null; then
                    sudo yum install -y git
                else
                    log_error "Cannot install Git automatically"
                    exit 1
                fi
                ;;
            "gum")
                log_info "Installing Gum..."
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    brew install gum
                elif command -v apt-get >/dev/null; then
                    sudo apt-get update && sudo apt-get install -y gum
                elif command -v yum >/dev/null; then
                    sudo yum install -y gum
                else
                    log_error "Cannot install Gum automatically"
                    exit 1
                fi
                ;;
        esac
    done
    
    log_success "Dependencies installed"
}

# --- CREATE DIRECTORIES ---
create_directories() {
    log_info "Creating directories..."
    
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"
    mkdir -p "$CONFIG_DIR"
    
    log_success "Directories created"
}

# --- CLONE/UPDATE REPOSITORY ---
clone_repository() {
    if [[ -d "$INSTALL_DIR" ]] && [[ "$UPDATE" == true ]]; then
        log_info "Updating existing installation..."
        cd "$INSTALL_DIR"
        if git pull origin main >/dev/null 2>&1 || git pull origin master >/dev/null 2>&1; then
            log_success "Repository updated"
        else
            log_error "Failed to update repository"
            exit 1
        fi
    elif [[ -d "$INSTALL_DIR" ]] && [[ "$FORCE" == true ]]; then
        log_info "Removing existing installation..."
        rm -rf "$INSTALL_DIR"
        clone_fresh
    elif [[ -d "$INSTALL_DIR" ]]; then
        log_warning "Installation directory already exists: $INSTALL_DIR"
        read -p "Remove and reinstall? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$INSTALL_DIR"
            clone_fresh
        else
            log_info "Installation cancelled"
            exit 0
        fi
    else
        clone_fresh
    fi
}

clone_fresh() {
    log_info "Cloning repository from $REPO_URL..."
    if git clone "$REPO_URL" "$INSTALL_DIR" >/dev/null 2>&1; then
        log_success "Repository cloned"
    else
        log_error "Failed to clone repository"
        exit 1
    fi
}

# --- INSTALL FRAMEWORK ---
install_framework() {
    log_info "Installing framework..."
    
    # Copy main framework file
    if [[ -f "$INSTALL_DIR/gui_framework.sh" ]]; then
        cp "$INSTALL_DIR/gui_framework.sh" "$BIN_DIR/"
        chmod +x "$BIN_DIR/gui_framework.sh"
        log_success "Framework installed to $BIN_DIR/gui_framework.sh"
    else
        log_error "Framework file not found in repository"
        exit 1
    fi
    
    # Copy configuration template
    if [[ -f "$INSTALL_DIR/templates/gui-framework.conf" ]]; then
        if [[ ! -f "$CONFIG_DIR/gui-framework.conf" ]]; then
            cp "$INSTALL_DIR/templates/gui-framework.conf" "$CONFIG_DIR/"
            log_success "Configuration template installed to $CONFIG_DIR/gui-framework.conf"
        else
            log_info "Configuration file already exists, skipping"
        fi
    fi
    
    # Create launcher script
    create_launcher
}

# --- CREATE LAUNCHER SCRIPT ---
create_launcher() {
    local launcher="$BIN_DIR/gui-framework"
    
    cat > "$launcher" << 'EOF'
#!/bin/bash
# GUI Framework Launcher

# Source the framework
source "$(dirname "$0")/gui_framework.sh"

# Initialize if not already done
if ! type init_gui_framework >/dev/null 2>&1; then
    echo "❌ Framework not properly installed"
    exit 1
fi

# Show help if no arguments
if [[ $# -eq 0 ]]; then
    echo "🎨 Universal Shell GUI Framework"
    echo ""
    echo "Usage: gui-framework <command>"
    echo ""
    echo "Commands:"
    echo "  init     - Initialize framework in current shell"
    echo "  test     - Run test suite"
    echo "  info     - Show framework information"
    echo "  update   - Update framework"
    echo "  help     - Show this help"
    exit 0
fi

case "$1" in
    "init")
        init_gui_framework
        echo "✅ Framework initialized"
        ;;
    "test")
        if [[ -f "$(dirname "$0")/../share/universal-shell-gui-framework/test_gui_framework.sh" ]]; then
            "$(dirname "$0")/../share/universal-shell-gui-framework/test_gui_framework.sh"
        else
            echo "❌ Test suite not found"
            exit 1
        fi
        ;;
    "info")
        echo "🎨 Universal Shell GUI Framework"
        echo "Version: 1.1.0"
        echo "Installation: $(dirname "$0")"
        echo "Configuration: $HOME/.config/gui-framework.conf"
        ;;
    "update")
        echo "🔄 Updating framework..."
        "$(dirname "$0")/../share/universal-shell-gui-framework/install.sh" -u
        ;;
    "help"|*)
        echo "🎨 Universal Shell GUI Framework"
        echo ""
        echo "Usage: gui-framework <command>"
        echo ""
        echo "Commands:"
        echo "  init     - Initialize framework in current shell"
        echo "  test     - Run test suite"
        echo "  info     - Show framework information"
        echo "  update   - Update framework"
        echo "  help     - Show this help"
        ;;
esac
EOF
    
    chmod +x "$launcher"
    log_success "Launcher created: $launcher"
}

# --- SETUP SHELL INTEGRATION ---
setup_shell_integration() {
    log_info "Setting up shell integration..."
    
    local shell_rc=""
    case "$SHELL" in
        */zsh)
            shell_rc="$HOME/.zshrc"
            ;;
        */bash)
            shell_rc="$HOME/.bashrc"
            ;;
        *)
            log_warning "Unknown shell: $SHELL"
            return
            ;;
    esac
    
    # Check if already configured
    if grep -q "gui_framework.sh" "$shell_rc" 2>/dev/null; then
        log_info "Shell integration already configured in $shell_rc"
        return
    fi
    
    # Add to shell config
    cat >> "$shell_rc" << EOF

# Universal Shell GUI Framework
if [[ -f "$BIN_DIR/gui_framework.sh" ]]; then
    export GUI_FRAMEWORK_PATH="$BIN_DIR/gui_framework.sh"
    # Uncomment the line below to auto-initialize the framework
    # source "\$GUI_FRAMEWORK_PATH" && init_gui_framework
fi
EOF
    
    log_success "Shell integration added to $shell_rc"
    log_info "Restart your shell or run: source $shell_rc"
}

# --- MAIN INSTALLATION ---
main() {
    log_info "🎨 Installing Universal Shell GUI Framework"
    log_info "Repository: $REPO_URL"
    log_info "Installation directory: $INSTALL_DIR"
    log_info "Binary directory: $BIN_DIR"
    
    check_dependencies
    create_directories
    clone_repository
    install_framework
    setup_shell_integration
    
    log_success "🎉 Installation completed!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Restart your shell or run: source ~/.zshrc (or ~/.bashrc)"
    echo "2. Initialize the framework: gui-framework init"
    echo "3. Test the installation: gui-framework test"
    echo "4. Configure the framework: edit ~/.config/gui-framework.conf"
    echo ""
    echo "📚 Documentation: $INSTALL_DIR/docs/"
    echo "💡 Examples: $INSTALL_DIR/examples/"
}

# Run installation
main "$@" 