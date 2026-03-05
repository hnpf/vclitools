#!/bin/bash
# Installer for Virex CLI Tools

DEST_BIN="$HOME/.local/bin"
DEST_LIB="$HOME/.local/share/vclitools"

echo "Installing Virex CLI Tools..."


mkdir -p "$DEST_BIN"
mkdir -p "$DEST_LIB"
cp bin/* "$DEST_BIN/"
chmod +x "$DEST_BIN/"*
cp scripts/core.sh "$DEST_LIB/core.sh"
echo -e "\n--- Installation has finished! ---"

SHELL_NAME=$(basename "$SHELL")
if [ "$SHELL_NAME" == "bash" ]; then
    RC_FILE="$HOME/.bashrc"
elif [ "$SHELL_NAME" == "zsh" ]; then
    RC_FILE="$HOME/.zshrc"
else
    RC_FILE=""
fi
if [ -n "$RC_FILE" ] && [ -f "$RC_FILE" ]; then
    echo "Updating $RC_FILE..."
    if ! grep -q "$DEST_BIN" "$RC_FILE"; then
        echo "Adding $DEST_BIN to PATH in $RC_FILE"
        echo -e "\n# vclitools PATH\nexport PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$RC_FILE"
    fi
    if ! grep -q "$DEST_LIB/core.sh" "$RC_FILE"; then
        echo "Adding source $DEST_LIB/core.sh to $RC_FILE"
        echo "source $DEST_LIB/core.sh" >> "$RC_FILE"
    fi
    
    echo -e "\033[1;32mConfig updated successfully!\033[0m"
    echo "Note: To apply changes to this current terminal, run: source $RC_FILE"
else
    echo -e "\033[1;33mNotice:\033[0m Could not automatically detect your shell config file."
    echo "Please manually add these lines to your .bashrc or .zshrc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "  source $DEST_LIB/core.sh"
fi

echo -e "\nRestart your shell to start using Virex CLI Tools! :3"
