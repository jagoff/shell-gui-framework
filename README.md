# 🎨 Universal Shell GUI Framework

> **The definitive standard for beautiful, modern CLI interfaces in shell projects**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash/Zsh](https://img.shields.io/badge/Shell-Bash%2FZsh-blue.svg)](https://www.gnu.org/software/bash/)
[![GUI: Gum](https://img.shields.io/badge/GUI-Gum-green.svg)](https://github.com/charmbracelet/gum)

A universal framework for creating stunning, interactive command-line interfaces using `gum`. This framework provides a standardized approach to building modern, user-friendly shell applications with consistent design patterns and robust error handling.

## ✨ Features

### Core Features
- 🎯 **Universal**: Works with any shell project (bash, zsh, fish, etc.)
- 🎨 **Beautiful**: Modern, colorful interfaces with emojis and icons
- 🔧 **Robust**: Compatible with all versions of `gum`
- 📱 **Interactive**: Menus, confirmations, multi-select, and more
- 🛡️ **Safe**: TTY detection and comprehensive error handling
- 📚 **Well-documented**: Complete examples and best practices
- 🚀 **Fast**: Lightweight and efficient

### Enhanced Features (New!)
- 🎨 **Theme System**: Customizable colors, fonts, and layouts
- 🔧 **Multi-Shell Support**: Full compatibility with bash, zsh, and fish
- 🛠️ **Tool Integrations**: Built-in support for Git, Docker, FZF, GitHub CLI, and more
- 📊 **Advanced Error Handling**: Detailed error reporting and recovery
- 🌐 **Accessibility**: High contrast themes and screen reader support
- 📦 **Package Manager Integration**: Support for Homebrew, apt, yum, pacman
- 🔍 **Enhanced File Operations**: FZF-powered file browsing and search
- 📈 **System Monitoring**: Process management and system information

## 🚀 Quick Start

### 1. Install Dependencies
```bash
# Option A: Using Makefile (recommended)
make install-deps

# Option B: Manual installation
brew install gum  # macOS
# or
sudo apt-get install gum  # Ubuntu/Debian
# or
sudo yum install gum  # CentOS/RHEL

# Verify installation
gum --version
```

### 2. Include the Framework
```bash
#!/bin/bash
# Your script with beautiful GUI

# Include the framework
source ./gui_framework.sh

# Initialize the framework (now includes enhanced features)
init_gui_framework

# Use the functions
main() {
    local action=$(show_gui_menu \
        "My Project" \
        "Select the action you want to perform" \
        "Choose an option:" \
        "🚀 Install" \
        "⚙️  Configure" \
        "▶️  Run" \
        "❌ Exit")
    
    case "$action" in
        "🚀 Install") install_project ;;
        "⚙️  Configure") configure_project ;;
        "▶️  Run") run_project ;;
        "❌ Exit") exit 0 ;;
    esac
}

main "$@"
```

### 3. Enhanced Usage (New!)
```bash
#!/bin/bash
# Your script with enhanced features

# Include the framework
source ./gui_framework.sh

# Initialize with enhanced features
init_gui_framework

# Use enhanced menu system
if command -v show_enhanced_main_menu >/dev/null; then
    show_enhanced_main_menu
else
    # Fallback to basic menu
    show_gui_menu "Basic Menu" "Select option:" "Option 1" "Option 2"
fi
```

### 3. Run Tests
```bash
# Run the test suite
make test

# Or manually
./test_gui_framework.sh
```

## 📁 Repository Structure

```
universal-shell-gui-framework/
├── README.md                 # This file
├── gui_framework.sh          # Core framework
├── theme_manager.sh          # Theme management system
├── error_handler.sh          # Enhanced error handling
├── shell_compatibility.sh    # Multi-shell compatibility
├── integrations.sh           # Tool integrations
├── enhanced_menu.sh          # Enhanced main menu
├── themes/                   # Theme configurations
│   ├── default.conf          # Default theme
│   ├── dark.conf             # Dark theme
│   └── high-contrast.conf    # High contrast theme
├── examples/
│   └── basic_example.sh      # Basic example
├── docs/
│   ├── FRAMEWORK_GUIDE.md    # Complete framework guide
│   ├── BEST_PRACTICES.md     # Best practices
│   ├── COMPONENTS.md         # Available components
│   └── EXAMPLES.md           # More examples
├── install.sh                # Installation script
├── include.sh                # One-liner inclusion
├── quick-start.sh            # Quick start guide
├── demo-usage.sh             # Interactive demo
├── test_gui_framework.sh     # Test suite
├── Makefile                  # Build automation
└── package.json              # Project metadata
```

## 🎯 Core Components

### Menus
```bash
# Single selection menu
local choice=$(show_gui_menu \
    "Title" \
    "Subtitle" \
    "Header:" \
    "Option 1" \
    "Option 2" \
    "Option 3")

# Multi-selection menu
local selections=$(show_gui_multi_select \
    "Title" \
    "Subtitle" \
    "Header:" \
    3 \
    "Feature 1" \
    "Feature 2" \
    "Feature 3")
```

### Confirmations
```bash
if show_gui_confirmation "Do you want to continue?"; then
    echo "User confirmed"
else
    echo "User cancelled"
fi
```

### Input
```bash
local name=$(show_gui_input "Enter your name:" "John Doe")
```

### Progress
```bash
show_gui_spinner "Installing..." sleep 3
```

## 🎨 Enhanced Features

### Theme System
```bash
# Load a theme
load_theme "dark"

# Create custom theme
create_custom_theme "my-theme" "default"

# Apply theme to gum
apply_theme_to_gum
```

### Tool Integrations
```bash
# Git repository browser
show_git_repo_browser

# Docker container manager
show_docker_manager

# FZF file browser
show_fzf_file_browser

# GitHub repository browser
show_github_browser
```

### Multi-Shell Support
```bash
# Detect current shell
get_shell_name  # Returns: bash, zsh, or fish

# Check shell capabilities
get_shell_capabilities

# Validate shell environment
validate_shell_environment
```

### Enhanced Error Handling
```bash
# Log errors with categories
log_error "validation" "high" "Invalid input" "User entered invalid email"

# Show user-friendly error messages
show_error_message "Installation Failed" "Could not install package" "Network error" "Check your internet connection"

# Generate error reports
generate_error_report
```

## 🎨 Design Principles

### Color Scheme
- 🔴 **Red**: Errors and critical alerts
- 🟢 **Green**: Success and confirmations  
- 🔵 **Blue**: Information and titles
- 🟡 **Yellow**: Warnings and prompts
- 🟣 **Purple**: Special highlights
- ⚪ **Gray**: Secondary text

### Icons & Emojis
- 📋 Section headers
- ✅ Success indicators
- ❌ Error indicators
- ⚠️  Warnings
- 🔧 Configuration
- 🚀 Actions
- 🎯 Targets

## 📚 Documentation

- **[API Reference](docs/API_REFERENCE.md)** - Complete function reference
- **[Framework Guide](docs/FRAMEWORK_GUIDE.md)** - Complete implementation guide
- **[Best Practices](docs/BEST_PRACTICES.md)** - Design and coding standards
- **[Components](docs/COMPONENTS.md)** - All available GUI components
- **[Examples](docs/EXAMPLES.md)** - Real-world usage examples

## 🛠️ Development

### Testing
```bash
# Run all tests
make test

# Run specific test categories
./test_gui_framework.sh
```

### Code Quality
```bash
# Lint shell scripts
make lint

# Format code
make format

# Full validation
make validate
```

### Building
```bash
# Create distribution package
make package

# Create release archive
make release
```

### Development Setup
```bash
# Set up development environment
make dev-setup
```

## 🔧 Installation

### 🚀 Quick Installation (Recommended)

#### Option 1: One-liner Installation
```bash
# Install from any Git repository
curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/install.sh | bash
```

#### Option 2: Clone and Install
```bash
# Clone and install
git clone https://github.com/jagoff/shell-gui-framework.git
cd shell-gui-framework
./install.sh
```

#### Option 3: Direct Inclusion in Scripts
```bash
# Include directly in your script (no installation needed)
source <(curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/gui_framework.sh)
```

### 📦 Manual Installation

#### Option 1: Direct Download
```bash
# Download the framework
curl -O https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/gui_framework.sh

# Make it executable
chmod +x gui_framework.sh

# Include in your script
source ./gui_framework.sh
```

#### Option 2: Git Clone
```bash
# Clone the repository
git clone https://github.com/jagoff/shell-gui-framework.git

# Copy the framework to your project
cp shell-gui-framework/gui_framework.sh ./gui_framework.sh

# Include in your script
source ./gui_framework.sh
```

### 🔄 Updating
```bash
# Update existing installation
gui-framework update

# Or manually
./install.sh -u
```

## 🎯 Usage Examples

### Basic Menu
```bash
#!/bin/bash
source ./gui_framework.sh

main() {
    local action=$(show_gui_menu \
        "My Application" \
        "What would you like to do?" \
        "Select an action:" \
        "🚀 Start" \
        "⚙️  Settings" \
        "📊 Status" \
        "❌ Quit")
    
    case "$action" in
        "🚀 Start") start_app ;;
        "⚙️  Settings") open_settings ;;
        "📊 Status") show_status ;;
        "❌ Quit") exit 0 ;;
    esac
}

main "$@"
```

### Enhanced Menu with Themes and Integrations
```bash
#!/bin/bash
source ./gui_framework.sh

# Initialize with enhanced features
init_gui_framework

main() {
    # Use enhanced menu if available
    if command -v show_enhanced_main_menu >/dev/null; then
        show_enhanced_main_menu
    else
        # Fallback to basic menu
        local action=$(show_gui_menu \
            "My Application" \
            "What would you like to do?" \
            "Select an action:" \
            "🚀 Start" \
            "⚙️  Settings" \
            "📊 Status" \
            "❌ Quit")
        
        case "$action" in
            "🚀 Start") start_app ;;
            "⚙️  Settings") open_settings ;;
            "📊 Status") show_status ;;
            "❌ Quit") exit 0 ;;
        esac
    fi
}

main "$@"
```

### Multi-Step Process with Error Handling
```bash
#!/bin/bash
source ./gui_framework.sh

deploy_app() {
    # Step 1: Environment selection
    local env=$(show_gui_menu \
        "Deployment" \
        "Select deployment environment" \
        "Environment:" \
        "🟢 Development" \
        "🟡 Staging" \
        "🔴 Production")
    
    # Step 2: Confirmation
    if show_gui_confirmation "Deploy to $env?"; then
        # Step 3: Progress with error handling
        if show_gui_spinner "Deploying to $env..." sleep 5; then
            gui_log_success "Deployment completed!"
        else
            gui_log_error "Deployment failed"
            # Generate error report
            if command -v generate_error_report >/dev/null; then
                generate_error_report
            fi
        fi
    fi
}
```

### Git Integration Example
```bash
#!/bin/bash
source ./gui_framework.sh

git_workflow() {
    # Check if Git integration is available
    if command -v show_git_repo_browser >/dev/null; then
        show_git_repo_browser
    else
        gui_log_warning "Git integration not available"
    fi
}
```

## 🆕 What's New in Enhanced Edition

### 🎨 Theme System
- **Customizable Colors**: Full color scheme customization
- **Multiple Themes**: Default, Dark, and High Contrast themes
- **User Themes**: Create and manage custom themes
- **Accessibility**: High contrast mode for visual impairments

### 🔧 Multi-Shell Compatibility
- **Bash Support**: Full compatibility with bash 4.0+
- **Zsh Support**: Optimized for zsh 5.0+
- **Fish Support**: Limited compatibility with fish 3.0+
- **Auto-Detection**: Automatic shell detection and configuration

### 🛠️ Tool Integrations
- **Git Integration**: Repository browser, branch manager, status viewer
- **Docker Integration**: Container and image management
- **FZF Integration**: Enhanced file browsing and search
- **GitHub CLI**: Repository browsing and issue management
- **Package Managers**: Homebrew, apt, yum, pacman support

### 📊 Advanced Error Handling
- **Categorized Errors**: Dependency, permission, network, validation errors
- **User-Friendly Messages**: Clear, actionable error messages
- **Error Reports**: Detailed error reports for debugging
- **Log Rotation**: Automatic log management and cleanup

### 🌐 Accessibility Features
- **High Contrast Themes**: Optimized for visual impairments
- **Screen Reader Support**: ARIA-compliant output
- **Reduced Motion**: Support for users with motion sensitivity
- **Keyboard Navigation**: Full keyboard accessibility

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

### Development Guidelines
- Follow shell scripting best practices
- Add error handling for all new functions
- Include documentation for new features
- Test on multiple shells (bash, zsh, fish)
- Ensure accessibility compliance

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Charmbracelet](https://charm.sh/) for the amazing `gum` tool
- The shell scripting community for best practices
- All contributors who help improve this framework

---

**Made with ❤️ for the shell community**

> *"Beautiful interfaces shouldn't be limited to web apps"* 