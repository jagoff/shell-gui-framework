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

# Initialize the framework
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