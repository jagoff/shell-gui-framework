# Universal Shell GUI Framework

> **The definitive standard for beautiful, modern CLI interfaces in shell projects**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash/Zsh/Fish](https://img.shields.io/badge/Shell-Bash%2FZsh%2FFish-blue.svg)](https://www.gnu.org/software/bash/)
[![GUI: Gum](https://img.shields.io/badge/GUI-Gum-green.svg)](https://github.com/charmbracelet/gum)

A universal framework for creating stunning, interactive command-line interfaces using `gum`. This framework provides a standardized approach to building modern, user-friendly shell applications with consistent design patterns, robust error handling, and enterprise-level features.

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
├── install.sh                # Installation script
├── demo-usage.sh             # Interactive demo
└── LICENSE                   # MIT License
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

All documentation is included in the README and the interactive demo. The framework is self-documenting with clear function names and comprehensive examples.

## 🛠️ Development

### Testing
```bash
# Run the demo to test functionality
./demo-usage.sh
```

### Code Quality
```bash
# Check script syntax
bash -n gui_framework.sh
bash -n theme_manager.sh
bash -n error_handler.sh
bash -n shell_compatibility.sh
bash -n integrations.sh
bash -n enhanced_menu.sh
```

## 🔧 Installation

### 🚀 Quick Installation
```bash
# Install from GitHub
curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/install.sh | bash
```

### 📦 Manual Installation
```bash
# Clone the repository
git clone https://github.com/jagoff/shell-gui-framework.git
cd shell-gui-framework

# Install dependencies
brew install gum  # macOS
# or
sudo apt-get install gum  # Ubuntu/Debian
```

### 🔄 Direct Usage
```bash
# Include directly in your script
source <(curl -sSL https://raw.githubusercontent.com/jagoff/shell-gui-framework/main/gui_framework.sh)
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

## 🆕 Enhanced Features

### 🎨 Theme System
- Customizable colors, fonts, and layouts
- Multiple themes: Default, Dark, and High Contrast
- User theme creation and management
- Accessibility support

### 🔧 Multi-Shell Compatibility
- Full support for bash, zsh, and fish
- Automatic shell detection and configuration
- Cross-shell function adaptations

### 🛠️ Tool Integrations
- Git repository browser and management
- Docker container and image management
- FZF file browsing and search
- GitHub CLI integration
- Package manager support

### 📊 Advanced Error Handling
- Categorized error types with user-friendly messages
- Detailed error reports and logging
- Automatic log rotation and cleanup

### 🌐 Accessibility
- High contrast themes for visual impairments
- Screen reader support and keyboard navigation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Guidelines
- Follow shell scripting best practices
- Add error handling for new functions
- Test on multiple shells (bash, zsh, fish)
- Ensure accessibility compliance

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Made with ❤️ for the shell community** 