#!/bin/bash
# test_gui_framework.sh - Test suite for Universal Shell GUI Framework
# Version: 1.0.0

set -e

# Source the framework
source "$(dirname "$0")/gui_framework.sh"

# Test configuration
readonly TEST_TEMP_DIR="/tmp/gui-framework-test"
readonly TEST_RESULTS_FILE="$TEST_TEMP_DIR/results.log"

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# --- TEST UTILITIES ---
test_log() {
    echo "[TEST] $1" | tee -a "$TEST_RESULTS_FILE"
}

test_assert() {
    local test_name="$1"
    local condition="$2"
    local message="${3:-Test failed}"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if eval "$condition"; then
        test_log "✅ PASS: $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        test_log "❌ FAIL: $test_name - $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_setup() {
    mkdir -p "$TEST_TEMP_DIR"
    > "$TEST_RESULTS_FILE"
    test_log "Starting GUI Framework Test Suite"
    test_log "Test started at: $(date)"
}

test_teardown() {
    test_log "Test completed at: $(date)"
    test_log "Results: $TESTS_PASSED passed, $TESTS_FAILED failed out of $TESTS_RUN total"
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        test_log "🎉 All tests passed!"
        exit 0
    else
        test_log "💥 Some tests failed!"
        exit 1
    fi
}

# --- TEST CASES ---
test_color_variables() {
    test_log "Testing color variables..."
    
    test_assert "Color variables defined" \
        "[[ -n '$C_RED' && -n '$C_GREEN' && -n '$C_BLUE' ]]" \
        "Color variables should be defined"
    
    test_assert "Color reset defined" \
        "[[ -n '$C_NC' ]]" \
        "Color reset should be defined"
}

test_logging_functions() {
    test_log "Testing logging functions..."
    
    # Test that logging functions don't crash
    test_assert "Success logging" \
        "gui_log_success 'test message' >/dev/null 2>&1" \
        "Success logging should work"
    
    test_assert "Error logging" \
        "gui_log_error 'test error' >/dev/null 2>&1" \
        "Error logging should work"
    
    test_assert "Warning logging" \
        "gui_log_warning 'test warning' >/dev/null 2>&1" \
        "Warning logging should work"
}

test_gum_version_detection() {
    test_log "Testing Gum version detection..."
    
    local version=$(get_gum_version)
    test_assert "Gum version detection" \
        "[[ -n '$version' ]]" \
        "Should detect Gum version"
    
    test_assert "Version format" \
        "echo '$version' | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$|^0\.0\.0$'" \
        "Version should be in semver format or 0.0.0 if not installed"
}

test_configuration_loading() {
    test_log "Testing configuration loading..."
    
    # Test with non-existent config file
    GUI_CONFIG_FILE="/tmp/nonexistent.conf"
    test_assert "Non-existent config handling" \
        "load_gui_config >/dev/null 2>&1" \
        "Should handle missing config file gracefully"
}

test_dependency_checking() {
    test_log "Testing dependency checking..."
    
    # Test that the function exists and can be called
    test_assert "Dependency check function" \
        "type check_gui_dependencies >/dev/null 2>&1" \
        "Dependency check function should exist"
}

test_tty_detection() {
    test_log "Testing TTY detection..."
    
    # Test that the function exists
    test_assert "TTY detection function" \
        "type require_tty >/dev/null 2>&1" \
        "TTY detection function should exist"
}

test_gui_components_exist() {
    test_log "Testing GUI component functions..."
    
    local components=(
        "show_gui_menu"
        "show_gui_multi_select"
        "show_gui_confirmation"
        "show_gui_input"
        "show_gui_spinner"
        "show_gui_progress"
        "show_gui_menu_with_quit"
    )
    
    for component in "${components[@]}"; do
        test_assert "Component $component exists" \
            "type $component >/dev/null 2>&1" \
            "GUI component $component should exist"
    done
}

test_framework_initialization() {
    test_log "Testing framework initialization..."
    
    test_assert "Framework init function" \
        "type init_gui_framework >/dev/null 2>&1" \
        "Framework initialization function should exist"
}

# --- MAIN TEST RUNNER ---
main() {
    test_setup
    
    # Run all test suites
    test_color_variables
    test_logging_functions
    test_gum_version_detection
    test_configuration_loading
    test_dependency_checking
    test_tty_detection
    test_gui_components_exist
    test_framework_initialization
    
    test_teardown
}

# Run tests if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 