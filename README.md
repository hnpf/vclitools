# Virex CLI Tools!

A collection of useful CLI tools for humans who hate typing (like me)

## Installation

Clone and run the installer:
```bash
git clone https://github.com/hnpf/vclitools && cd vclitools
```
```bash
chmod +x install.sh && ./install.sh
```

The installer will automatically add the necessary paths to your `.bashrc` or `.zshrc`. Then, just restart your shell or run `source ~/.bashrc` (or `~/.zshrc`) to start using the tools!

## 🧰 The Tools

| Command | Description |
|---------|-------------|
| `base [-e/-d]` | Base64 encode/decode utility. `-e` to encode, `-d` to decode. |
| `b64 [-e/-d]` | Alias for `base`. |
| `up [n]` | Go back `n` directories. Default is 1. No more `cd ../../../` |
| `mkcd <dir>` | Create a directory and `cd` into it instantly. |
| `to [target]` | Smart jump. No args: lists all folders. With arg: fuzzy-jumps to matching folder. |
| `o <pattern>` | Smart open. Matches file: opens in editor. Matches folder: jumps inside. |
| `bak <file>` | Instantly create a `.bak` copy of a file. |
| `forget [n]` | Wipes the last `n` commands from your history file. |
| `port-kill <port>` | Kills whatever process is squatting on that port. |
| `size` | Lists and sorts the largest folders in the current directory with colors. |
| `vfetch` | Prints system specs with a side of sass about your USB devices. |
| `x <file>` | Universal extractor. Works for .tar.gz, .zip, .rar, etc. |
| `serve [port]` | Instantly starts a static web server in the current folder. |
| `nah` | Nukes all Git changes and cleans untracked files. Use with caution. |
| `please` | Re-runs the last command with `sudo`. |
| `myip` | Shows your local and public IP addresses. |
| `retry <cmd>` | Runs a command repeatedly until it succeeds. |
| `path` | Pretty-prints `$PATH` and flags broken directories. |
| `human <time>` | Converts a Unix timestamp to human-readable date. |
| `cheat <topic>` | Fetches quick cheat sheets from cheat.sh. |
| `todo [msg]` | Dead-simple todo list. `-d <idx>` to delete, `-c` to clear. |
| `transfer <f>` | Instantly uploads a file and gives you a shareable link. |
| `weather [c]` | Beautiful ASCII weather. Auto-detects or uses last city. |
| `f [flags] <p>` | Smart search. (none): files. `-c`: current dir. `-f`/`-fw`: text/whole word. `-fc`/`-fcw`: current dir text/whole word. |
| `heat` | Checks if your GPU is chilling or mining crypto. |
| `dust` | A reminder to clean your fans (triggers every 30 days-ish). |
| `core` | Shows all available commands and what they do. |

## 🛠️ Requirements
- `curl` (for `cheat`, `myip`)
- `lsof` (for `port-kill`)
- `du`, `sort` (for `size`)
- `base64` (for `base`, `b64`)
- `lsusb` (optional, for `vfetch`)
