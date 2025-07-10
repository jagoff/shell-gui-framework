# 🤝 Contributing to Universal Shell GUI Framework

Thank you for your interest in contributing to the Universal Shell GUI Framework! We're excited to have you join our community of developers building the future of shell scripting.

## 🎯 Quick Start

### 1. **Fork & Clone**
```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/universal-shell-gui-framework.git
cd universal-shell-gui-framework

# Add upstream remote
git remote add upstream https://github.com/jagoff/shell-gui-framework.git
```

### 2. **Setup Development Environment**
```bash
# Install dependencies
brew install gum  # macOS
# or
sudo apt-get install gum  # Ubuntu/Debian

# Test the framework
./demo-usage.sh
```

### 3. **Create Your Branch**
```bash
git checkout -b feature/amazing-feature
# or
git checkout -b fix/bug-fix
```

## 🚀 How to Contribute

### 🐛 **Bug Reports**
Found a bug? Help us fix it!

**Before reporting:**
- [ ] Check if the bug is already reported
- [ ] Test with the latest version
- [ ] Provide steps to reproduce
- [ ] Include system information

**Bug report template:**
```markdown
## Bug Description
Brief description of the issue

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## System Information
- OS: [e.g., macOS 14.0]
- Shell: [e.g., zsh 5.9]
- Gum Version: [e.g., 0.13.0]
- Framework Version: [e.g., 1.1.0]

## Additional Context
Any other relevant information
```

### 💡 **Feature Requests**
Have an idea? We'd love to hear it!

**Before requesting:**
- [ ] Check if the feature is already planned
- [ ] Think about the use case
- [ ] Consider implementation complexity
- [ ] Check if it aligns with our vision

**Feature request template:**
```markdown
## Feature Description
Brief description of the feature

## Problem Statement
What problem does this solve?

## Proposed Solution
How should this work?

## Use Cases
Who would use this feature?

## Implementation Ideas
Any thoughts on how to implement?

## Priority
High/Medium/Low
```

### 🔧 **Code Contributions**
Ready to code? Here's how to contribute:

#### **Development Workflow**
1. **Choose an issue** from our [Issues](https://github.com/jagoff/shell-gui-framework/issues) or [Roadmap](ROADMAP.md)
2. **Comment on the issue** to let us know you're working on it
3. **Create a branch** with a descriptive name
4. **Write your code** following our standards
5. **Test thoroughly** on multiple shells
6. **Update documentation** if needed
7. **Submit a pull request**

#### **Coding Standards**
```bash
# Code style
- Use 2 spaces for indentation
- Maximum line length: 80 characters
- Use descriptive variable names
- Add comments for complex logic
- Follow shell scripting best practices

# File organization
- One function per logical block
- Group related functions together
- Use consistent naming conventions
- Add headers for major sections

# Error handling
- Always check return codes
- Provide meaningful error messages
- Use our error handling system
- Log errors appropriately
```

#### **Testing Requirements**
```bash
# Test on multiple shells
bash -n your_script.sh  # Syntax check
zsh -n your_script.sh   # Syntax check
fish -n your_script.sh  # Syntax check (if applicable)

# Test functionality
./demo-usage.sh         # Run demo
# Test your specific feature
# Test error conditions
# Test edge cases
```

#### **Pull Request Process**
1. **Update your branch** with latest changes
2. **Write a clear description** of your changes
3. **Include tests** if applicable
4. **Update documentation** if needed
5. **Request review** from maintainers

**PR template:**
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Refactoring

## Testing
- [ ] Tested on bash
- [ ] Tested on zsh
- [ ] Tested on fish (if applicable)
- [ ] All tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes
- [ ] Error handling added
```

## 🎨 **Documentation Contributions**

### **Writing Guidelines**
- Use clear, concise language
- Include practical examples
- Add screenshots for UI changes
- Keep documentation up-to-date
- Use consistent formatting

### **Documentation Types**
- **README updates**: Main documentation
- **API documentation**: Function references
- **Tutorials**: Step-by-step guides
- **Examples**: Real-world use cases
- **Troubleshooting**: Common issues and solutions

## 🏆 **Recognition & Rewards**

### **Contributor Levels**
- 🌱 **Newcomer**: First contribution
- 🌿 **Contributor**: 5+ contributions
- 🌳 **Maintainer**: 20+ contributions
- 🌲 **Core Team**: 50+ contributions

### **Recognition**
- **Contributor Hall of Fame**: Listed on our website
- **Feature Credits**: Your name on features you build
- **Swag & Rewards**: Exclusive merchandise
- **Speaking Opportunities**: Present at conferences
- **Mentorship**: Help guide new contributors

### **Badges & Achievements**
- 🎯 **Bug Hunter**: Fixed 10+ bugs
- 🚀 **Feature Creator**: Added 5+ features
- 📚 **Documentation Hero**: Improved docs significantly
- 🧪 **Test Champion**: Added comprehensive tests
- 🌍 **Community Builder**: Helped grow the community

## 🛠️ **Development Setup**

### **Advanced Setup**
```bash
# Install development tools
brew install shellcheck  # Code linting
brew install bats        # Testing framework
brew install shfmt       # Code formatting

# Setup pre-commit hooks
cp .github/hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### **Testing Framework**
```bash
# Run all tests
./tests/run_tests.sh

# Run specific test categories
./tests/test_core.sh
./tests/test_themes.sh
./tests/test_integrations.sh

# Performance testing
./tests/benchmark.sh
```

### **Debugging**
```bash
# Enable debug mode
export GUI_DEBUG=true
export GUI_VERBOSE=true

# Run with debug output
./demo-usage.sh

# Check logs
tail -f ~/.cache/gui-framework/errors.log
```

## 📞 **Getting Help**

### **Community Channels**
- **GitHub Discussions**: General questions and ideas
- **GitHub Issues**: Bug reports and feature requests
- **Discord**: Real-time chat and support
- **Email**: security@shell-gui-framework.com (security issues only)

### **Resources**
- **Documentation**: [README.md](README.md)
- **Roadmap**: [ROADMAP.md](ROADMAP.md)
- **Examples**: [demo-usage.sh](demo-usage.sh)
- **API Reference**: Inline documentation in source files

## 🚨 **Security**

### **Reporting Security Issues**
If you find a security vulnerability, please report it privately:

1. **Email**: security@shell-gui-framework.com
2. **Subject**: [SECURITY] Brief description
3. **Include**: Detailed description and proof-of-concept
4. **Do not**: Open a public issue

### **Security Guidelines**
- Never commit sensitive information
- Use environment variables for secrets
- Validate all user input
- Follow security best practices
- Report vulnerabilities responsibly

## 📋 **Code of Conduct**

### **Our Standards**
- Be respectful and inclusive
- Use welcoming and inclusive language
- Be collaborative and constructive
- Focus on what is best for the community
- Show empathy towards other community members

### **Unacceptable Behavior**
- Harassment or discrimination
- Trolling or insulting comments
- Publishing others' private information
- Other conduct inappropriate in a professional setting

## 🎉 **Thank You!**

Your contributions make this project better for everyone. Whether you're:
- 🐛 Reporting bugs
- 💡 Suggesting features
- 🔧 Writing code
- 📚 Improving documentation
- 🌍 Building community

**You're helping transform how developers build shell applications!**

---

**Ready to contribute?** [Pick an issue](https://github.com/jagoff/shell-gui-framework/issues) and get started! 🚀 