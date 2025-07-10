# 🎨 Universal Shell GUI Framework

> **The definitive standard for beautiful, modern CLI interfaces in shell projects**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash/Zsh](https://img.shields.io/badge/Shell-Bash%2FZsh-blue.svg)](https://www.gnu.org/software/bash/)
[![GUI: Gum](https://img.shields.io/badge/GUI-Gum-green.svg)](https://github.com/charmbracelet/gum)

A universal framework for creating stunning, interactive command-line interfaces using `gum`. This framework provides a standardized approach to building modern, user-friendly shell applications with consistent design patterns and robust error handling.

## ✨ Features

- 🎯 **Universal**: Works with any shell project (bash, zsh, etc.)
- 🎨 **Beautiful**: Modern, colorful interfaces with emojis and icons
- 🔧 **Robust**: Compatible with all versions of `gum`
- 📱 **Interactive**: Menus, confirmations, multi-select, and more
- 🛡️ **Safe**: TTY detection and error handling
- 📚 **Well-documented**: Complete examples and best practices
- 🚀 **Fast**: Lightweight and efficient

## 🚀 Quick Start

### 1. Install Dependencies
```bash
# Install gum (required)
brew install gum

# Verify installation
gum --version
```

### 2. Include the Framework
```bash
#!/bin/bash
# Your script with beautiful GUI

# Include the framework
source ./gui_framework.sh

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

## 📁 Repository Structure

```
universal-shell-gui-framework/
├── README.md                 # This file
├── gui_framework.sh          # Core framework
├── examples/
│   ├── basic_example.sh      # Simple example
│   ├── advanced_example.sh   # Complex example
│   └── project_template.sh   # Project template
├── docs/
│   ├── FRAMEWORK_GUIDE.md    # Complete framework guide
│   ├── BEST_PRACTICES.md     # Best practices
│   ├── COMPONENTS.md         # Available components
│   └── EXAMPLES.md           # More examples
└── templates/
    └── new_project.sh        # Template for new projects
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

- **[Framework Guide](docs/FRAMEWORK_GUIDE.md)** - Complete implementation guide
- **[Best Practices](docs/BEST_PRACTICES.md)** - Design and coding standards
- **[Components](docs/COMPONENTS.md)** - All available GUI components
- **[Examples](docs/EXAMPLES.md)** - Real-world usage examples

## 🔧 Installation

### Option 1: Direct Download
```bash
# Download the framework
curl -O https://raw.githubusercontent.com/your-username/universal-shell-gui-framework/main/gui_framework.sh

# Make it executable
chmod +x gui_framework.sh

# Include in your script
source ./gui_framework.sh
```

### Option 2: Git Clone
```bash
# Clone the repository
git clone https://github.com/your-username/universal-shell-gui-framework.git

# Copy the framework to your project
cp universal-shell-gui-framework/gui_framework.sh ./gui_framework.sh

# Include in your script
source ./gui_framework.sh
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

### Multi-Step Process
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
        # Step 3: Progress
        show_gui_spinner "Deploying to $env..." sleep 5
        log_success "Deployment completed!"
    fi
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Charmbracelet](https://charm.sh/) for the amazing `gum` tool
- The shell scripting community for best practices
- All contributors who help improve this framework

---

**Made with ❤️ for the shell community**

> *"Beautiful interfaces shouldn't be limited to web apps"* 