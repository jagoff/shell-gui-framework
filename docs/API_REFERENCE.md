# 🎨 Universal Shell GUI Framework - API Reference

## 📋 Overview

This document provides a complete reference for all functions and components available in the Universal Shell GUI Framework.

## 🔧 Core Functions

### Initialization

#### `init_gui_framework()`
Initializes the GUI framework, loads configuration, checks dependencies, and sets up Gum configuration.

**Usage:**
```bash
source ./gui_framework.sh
init_gui_framework
```

**Returns:** None

**Side Effects:**
- Loads configuration from `$GUI_CONFIG_FILE`
- Checks for Gum installation
- Sets up Gum theme configuration
- Logs initialization status

---

### Logging Functions

#### `gui_log_success(message)`
Logs a success message with green color and checkmark emoji.

**Parameters:**
- `message` (string): The message to log

**Usage:**
```bash
gui_log_success "Operation completed successfully"
```

**Output:** `✅ Operation completed successfully`

---

#### `gui_log_error(message)`
Logs an error message with red color and X emoji to stderr.

**Parameters:**
- `message` (string): The error message to log

**Usage:**
```bash
gui_log_error "Failed to connect to server"
```

**Output:** `❌ Failed to connect to server` (to stderr)

---

#### `gui_log_warning(message)`
Logs a warning message with yellow color and warning emoji.

**Parameters:**
- `message` (string): The warning message to log

**Usage:**
```bash
gui_log_warning "Configuration file not found, using defaults"
```

**Output:** `⚠️ Configuration file not found, using defaults`

---

#### `gui_log_info(message)`
Logs an informational message with blue color and info emoji.

**Parameters:**
- `message` (string): The info message to log

**Usage:**
```bash
gui_log_info "Starting installation process"
```

**Output:** `ℹ️ Starting installation process`

---

#### `gui_log_debug(message)`
Logs a debug message with gray color.

**Parameters:**
- `message` (string): The debug message to log

**Usage:**
```bash
gui_log_debug "Processing configuration file"
```

**Output:** `[DEBUG] Processing configuration file`

---

#### `gui_log_verbose(message)`
Logs a verbose message only if `$GUI_VERBOSE` is set to `true`.

**Parameters:**
- `message` (string): The verbose message to log

**Usage:**
```bash
GUI_VERBOSE=true
gui_log_verbose "Detailed step-by-step information"
```

**Output:** `[VERBOSE] Detailed step-by-step information` (only if verbose mode is enabled)

---

### Utility Functions

#### `gui_handle_quit([message])`
Handles graceful exit with optional message.

**Parameters:**
- `message` (string, optional): Exit message (default: "Exiting...")

**Usage:**
```bash
gui_handle_quit "User cancelled operation"
```

**Side Effects:** Exits with code 0

---

#### `get_gum_version()`
Gets the installed Gum version with caching for performance.

**Returns:** Version string (e.g., "0.13.0") or "0.0.0" if not installed

**Usage:**
```bash
version=$(get_gum_version)
echo "Gum version: $version"
```

---

#### `supports_gum_unselected_flags()`
Checks if the installed Gum version supports unselected flags.

**Returns:** 0 (true) if supported, 1 (false) if not

**Usage:**
```bash
if supports_gum_unselected_flags; then
    echo "Advanced Gum features available"
else
    echo "Using basic Gum features"
fi
```

---

#### `check_gui_dependencies()`
Checks and optionally installs required dependencies (Gum).

**Returns:** 0 on success, 1 on failure

**Usage:**
```bash
if ! check_gui_dependencies; then
    exit 1
fi
```

---

#### `require_tty()`
Ensures the script is running in an interactive terminal.

**Side Effects:** Exits with code 2 if not in TTY

**Usage:**
```bash
require_tty
```

---

## 🎨 GUI Components

### Menu Components

#### `show_gui_menu(title, subtitle, header, ...options)`
Displays a single-selection menu using Gum.

**Parameters:**
- `title` (string): Menu title
- `subtitle` (string): Menu subtitle
- `header` (string): Menu header text
- `...options` (strings): Menu options

**Returns:** Selected option string

**Usage:**
```bash
choice=$(show_gui_menu \
    "Main Menu" \
    "Select an option" \
    "Choose:" \
    "Option 1" \
    "Option 2" \
    "Option 3")
```

**Features:**
- TTY detection
- 'q' to quit functionality
- Color-coded output
- Error handling

---

#### `show_gui_multi_select(title, subtitle, header, limit, ...options)`
Displays a multi-selection menu using Gum.

**Parameters:**
- `title` (string): Menu title
- `subtitle` (string): Menu subtitle
- `header` (string): Menu header text
- `limit` (number): Maximum selections allowed
- `...options` (strings): Menu options

**Returns:** Space-separated list of selected options

**Usage:**
```bash
selections=$(show_gui_multi_select \
    "Select Tools" \
    "Choose multiple tools" \
    "Tools:" \
    3 \
    "Git" \
    "Docker" \
    "Node.js" \
    "Python")
```

**Features:**
- TTY detection
- Selection limit enforcement
- 'q' to quit functionality
- Color-coded output

---

#### `show_gui_menu_with_quit(title, subtitle, header, ...options)`
Displays a menu with an explicit quit option.

**Parameters:**
- `title` (string): Menu title
- `subtitle` (string): Menu subtitle
- `header` (string): Menu header text
- `...options` (strings): Menu options

**Returns:** Selected option string

**Usage:**
```bash
choice=$(show_gui_menu_with_quit \
    "Settings" \
    "Configure your application" \
    "Settings:" \
    "Theme" \
    "Language" \
    "Notifications")
```

**Features:**
- Automatic "Quit (q)" option addition
- TTY detection
- Graceful exit handling

---

### Input Components

#### `show_gui_input(prompt, [placeholder])`
Displays an input prompt using Gum.

**Parameters:**
- `prompt` (string): Input prompt text
- `placeholder` (string, optional): Placeholder text

**Returns:** User input string

**Usage:**
```bash
name=$(show_gui_input "Enter your name:" "John Doe")
```

**Features:**
- TTY detection
- 'q' to quit functionality
- Placeholder support
- Input validation

---

#### `show_gui_confirmation(message, [affirmative], [negative])`
Displays a confirmation dialog using Gum.

**Parameters:**
- `message` (string): Confirmation message
- `affirmative` (string, optional): Affirmative button text (default: "Yes, continue")
- `negative` (string, optional): Negative button text (default: "No, cancel")

**Returns:** 0 for affirmative, exits for negative/quit

**Usage:**
```bash
if show_gui_confirmation "Do you want to continue?"; then
    echo "User confirmed"
else
    echo "User cancelled"
fi
```

**Features:**
- TTY detection
- Custom button text support
- 'q' to quit functionality
- Graceful exit handling

---

### Progress Components

#### `show_gui_spinner(title, command, [args...])`
Displays a spinner while executing a command.

**Parameters:**
- `title` (string): Spinner title
- `command` (string): Command to execute
- `args...` (strings): Command arguments

**Returns:** Command exit code

**Usage:**
```bash
show_gui_spinner "Installing packages..." npm install
```

**Features:**
- Animated spinner
- Command execution
- Exit code preservation

---

#### `show_gui_progress(title, percent)`
Displays a progress bar.

**Parameters:**
- `title` (string): Progress title
- `percent` (number): Progress percentage (0-100)

**Usage:**
```bash
show_gui_progress "Downloading..." 75
```

**Features:**
- Visual progress bar
- Percentage display
- Fixed width formatting

---

## ⚙️ Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `GUI_CONFIG_FILE` | `$HOME/.config/gui-framework.conf` | Path to configuration file |
| `GUI_THEME_NAME` | `default` | Theme name to use |
| `GUI_VERBOSE` | `false` | Enable verbose logging |
| `GUI_DEBUG` | `false` | Enable debug mode |

### Configuration File Format

The configuration file should be a bash script that can be sourced:

```bash
# ~/.config/gui-framework.conf

# Custom color overrides
C_RED='\033[1;31m'
C_GREEN='\033[1;32m'

# Custom Gum theme
GUM_THEME=(
    --selected.foreground="#00ff00"
    --selected.background="#000000"
)

# Custom settings
GUI_VERBOSE=true
```

---

## 🎨 Color Constants

| Constant | ANSI Code | Hex | Usage |
|----------|-----------|-----|-------|
| `C_RED` | `\033[0;31m` | `#ff0000` | Errors and critical alerts |
| `C_GREEN` | `\033[0;32m` | `#00ff00` | Success and confirmations |
| `C_BLUE` | `\033[0;34m` | `#0000ff` | Information and titles |
| `C_YELLOW` | `\033[0;93m` | `#ffff00` | Warnings and prompts |
| `C_CYAN` | `\033[0;36m` | `#00ffff` | Technical info |
| `C_MAGENTA` | `\033[0;35m` | `#ff00ff` | Special highlights |
| `C_WHITE` | `\033[1;37m` | `#ffffff` | Main text |
| `C_GRAY` | `\033[0;90m` | `#808080` | Secondary text |
| `C_NC` | `\033[0m` | - | Reset color |

---

## 🔍 Error Handling

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | TTY required but not available |

### Error Recovery

The framework provides several error recovery mechanisms:

1. **Graceful Degradation**: Falls back to basic functionality when advanced features aren't available
2. **TTY Detection**: Prevents crashes in non-interactive environments
3. **Dependency Auto-Installation**: Attempts to install missing dependencies
4. **Version Compatibility**: Adapts to different Gum versions

---

## 📝 Best Practices

### 1. Always Initialize the Framework
```bash
source ./gui_framework.sh
init_gui_framework
```

### 2. Use Proper Error Handling
```bash
if ! check_gui_dependencies; then
    gui_log_error "Failed to initialize GUI framework"
    exit 1
fi
```

### 3. Check TTY for Interactive Components
```bash
require_tty  # Called automatically by GUI components
```

### 4. Use Consistent Logging
```bash
gui_log_info "Starting operation"
# ... perform operation ...
gui_log_success "Operation completed"
```

### 5. Handle User Cancellation
```bash
choice=$(show_gui_menu "Menu" "Select" "Choose:" "Option 1" "Option 2")
# Framework handles 'q' exit automatically
```

---

## 🧪 Testing

Run the test suite to verify framework functionality:

```bash
chmod +x test_gui_framework.sh
./test_gui_framework.sh
```

The test suite covers:
- Color variable definitions
- Logging function functionality
- Gum version detection
- Configuration loading
- Component existence
- Framework initialization 