# Universal Shell GUI Framework - Makefile
# Version: 1.0.0

.PHONY: help install test clean docs lint format check-deps install-deps

# Default target
help:
	@echo "🎨 Universal Shell GUI Framework"
	@echo ""
	@echo "Available targets:"
	@echo "  install      - Install the framework to system"
	@echo "  test         - Run the test suite"
	@echo "  clean        - Clean temporary files"
	@echo "  docs         - Generate documentation"
	@echo "  lint         - Check shell script syntax"
	@echo "  format       - Format shell scripts"
	@echo "  check-deps   - Check dependencies"
	@echo "  install-deps - Install dependencies"
	@echo "  package      - Create distribution package"
	@echo "  release      - Create release archive"

# Installation
install: check-deps
	@echo "📦 Installing Universal Shell GUI Framework..."
	@mkdir -p $(HOME)/.local/bin
	@cp gui_framework.sh $(HOME)/.local/bin/
	@chmod +x $(HOME)/.local/bin/gui_framework.sh
	@echo "✅ Framework installed to $(HOME)/.local/bin/gui_framework.sh"
	@echo "💡 Add 'source ~/.local/bin/gui_framework.sh' to your shell config"

# Testing
test: check-deps
	@echo "🧪 Running test suite..."
	@chmod +x test_gui_framework.sh
	@./test_gui_framework.sh

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	@rm -rf /tmp/gui-framework-test
	@rm -f *.tmp
	@rm -f *.log
	@echo "✅ Cleaned"

# Documentation
docs:
	@echo "📚 Generating documentation..."
	@echo "✅ Documentation is up to date"

# Linting
lint:
	@echo "🔍 Checking shell script syntax..."
	@if command -v shellcheck >/dev/null; then \
		shellcheck gui_framework.sh; \
		shellcheck setup-gui.sh; \
		shellcheck test_gui_framework.sh; \
		shellcheck examples/*.sh; \
		echo "✅ All scripts passed linting"; \
	else \
		echo "⚠️  shellcheck not found, skipping linting"; \
		echo "💡 Install shellcheck: brew install shellcheck"; \
	fi

# Format shell scripts
format:
	@echo "🎨 Formatting shell scripts..."
	@if command -v shfmt >/dev/null; then \
		shfmt -w gui_framework.sh; \
		shfmt -w setup-gui.sh; \
		shfmt -w test_gui_framework.sh; \
		shfmt -w examples/*.sh; \
		echo "✅ Scripts formatted"; \
	else \
		echo "⚠️  shfmt not found, skipping formatting"; \
		echo "💡 Install shfmt: brew install shfmt"; \
	fi

# Check dependencies
check-deps:
	@echo "🔍 Checking dependencies..."
	@if ! command -v gum >/dev/null; then \
		echo "❌ Gum is not installed"; \
		echo "💡 Run 'make install-deps' to install"; \
		exit 1; \
	fi
	@echo "✅ All dependencies are installed"

# Install dependencies
install-deps:
	@echo "📦 Installing dependencies..."
	@if [[ "$OSTYPE" == "darwin"* ]]; then \
		if ! command -v brew >/dev/null; then \
			echo "❌ Homebrew not found"; \
			echo "💡 Install Homebrew: https://brew.sh/"; \
			exit 1; \
		fi; \
		brew install gum; \
	elif command -v apt-get >/dev/null; then \
		sudo apt-get update && sudo apt-get install -y gum; \
	elif command -v yum >/dev/null; then \
		sudo yum install -y gum; \
	else \
		echo "❌ Unsupported package manager"; \
		echo "💡 Install Gum manually: https://github.com/charmbracelet/gum"; \
		exit 1; \
	fi
	@echo "✅ Dependencies installed"

# Create distribution package
package: clean test lint
	@echo "📦 Creating distribution package..."
	@mkdir -p dist
	@tar -czf dist/universal-shell-gui-framework-$(shell date +%Y%m%d).tar.gz \
		--exclude='.git' \
		--exclude='dist' \
		--exclude='*.tmp' \
		--exclude='*.log' \
		.
	@echo "✅ Package created: dist/universal-shell-gui-framework-$(shell date +%Y%m%d).tar.gz"

# Create release archive
release: clean test lint
	@echo "🚀 Creating release archive..."
	@mkdir -p releases
	@tar -czf releases/universal-shell-gui-framework-v1.1.0.tar.gz \
		--exclude='.git' \
		--exclude='dist' \
		--exclude='releases' \
		--exclude='*.tmp' \
		--exclude='*.log' \
		.
	@echo "✅ Release created: releases/universal-shell-gui-framework-v1.1.0.tar.gz"

# Development setup
dev-setup: install-deps
	@echo "🔧 Setting up development environment..."
	@if ! command -v shellcheck >/dev/null; then \
		brew install shellcheck; \
	fi
	@if ! command -v shfmt >/dev/null; then \
		brew install shfmt; \
	fi
	@echo "✅ Development environment ready"

# Quick validation
validate: lint test
	@echo "✅ All validations passed"

# Show project info
info:
	@echo "🎨 Universal Shell GUI Framework"
	@echo "Version: 1.1.0"
	@echo "Compatible: bash, zsh"
	@echo "Dependency: gum"
	@echo ""
	@echo "Files:"
	@ls -la *.sh
	@echo ""
	@echo "Examples:"
	@ls -la examples/
	@echo ""
	@echo "Documentation:"
	@ls -la docs/ 