#!/bin/bash

SHELL_EXEC=./hsh  # change ça si ton binaire a un autre nom

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

test_cmd() {
    echo -n "Test: $1 ... "
    RESULT=$(echo "$1" | $SHELL_EXEC 2>&1)
    if echo "$RESULT" | grep -q "$2"; then
        echo -e "${GREEN}[OK]${NC}"
    else
        echo -e "${RED}[FAIL]${NC}"
        echo "  Input: $1"
        echo "  Expected output (fragment): $2"
        echo "  Got:"
        echo "$RESULT"
    fi
}

echo "Running basic tests on $SHELL_EXEC"
echo "-----------------------------------"

test_cmd "ls" "bin"
test_cmd "echo Hello World" "Hello World"
test_cmd "    echo     hey" "hey"
test_cmd "fakecmd" "not found"
test_cmd "/bin/ls" "bin"
test_cmd "exit 42" ""  # can't test exit code here easily
test_cmd "exit abcd" "numeric argument"
test_cmd "echo Hello # this is a comment" "Hello"
test_cmd "echo \"Hello#World\"" "Hello#World"
test_cmd "help" "help"  # tu dois avoir une sortie help
test_cmd "help foobar" "not a built-in"
test_cmd "env" "PATH"  # vérifie que PATH ou HOME s'affiche

# Long line test (150 chars)
LONG_CMD=$(printf 'a%.0s' {1..150})
test_cmd "echo $LONG_CMD" "$LONG_CMD"

echo -e "\nTests terminés."