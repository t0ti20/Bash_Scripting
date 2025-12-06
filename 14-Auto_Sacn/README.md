# Auto Script Discovery & Alias Generator

This project provides a fully automated Bash utility that scans trusted directories, discovers all `.sh` (Bash) scripts, and generates shell aliases based on the script filenames. The tool is designed to streamline workflow efficiency, reduce repetitive typing, and maintain a clean working environment when interacting with frequently used scripts.

---

## 🚀 Overview

This script analyzes one or more predefined "trusted directories," identifies every `.sh` file found within them, and automatically creates a terminal alias that maps directly to each script. For example:

```
/path/to/scripts/fixbugs/fixbugs.sh
```

Automatically becomes:

```
fixbugs
```

This allows you to execute the script simply by typing the alias name—no need for full paths or manual alias creation.

---

## ✨ Features

* **Automatic Script Discovery**: Recursively scans directories for all `.sh` files.
* **Auto Alias Creation**: Alias names are generated from script file names.
* **Trusted Directory Control**: Users can specify exactly where to scan.
* **Debug Mode**: Toggle verbosity on/off for cleaner or more detailed output.
* **Color-Coded Messages**: Clean and readable terminal feedback.
* **Modular Design**: Easy to extend, maintain, and integrate.

---

## 📁 Directory Scanning Logic

The script scans the directories listed in the `TRUSTED_DIRS` array:

```bash
TRUSTED_DIRS=(
    "$HOME/Documents/Github/Bash_Scripting/"
)
```

Each `.sh` file found within these directories results in the creation of an alias based on the base filename.

---

## 🧩 Alias Naming Convention

If the script is:

```
~/scripts/tools/update_system.sh
```

The generated alias becomes:

```
update_system
```

Aliases are created during script execution using:

```bash
alias <alias_name>="bash \"<script_path>\""
```

> ⚠️ **Note**: Aliases created inside a script will exist only for the lifetime of that shell unless the script is sourced.

---

## 🔧 Debug Mode

Debugging is controlled by the `DEBUG` variable:

```bash
DEBUG=false
```

When `DEBUG=true`, the script prints:

* INFO messages
* SUCCESS messages
* CHECK warnings
* DEBUG details

When disabled, only **ERROR messages** are displayed.

---

## 📦 Installation & Usage

### 1. Clone or copy the script

Place the script anywhere you prefer.

### 2. Make it executable

```bash
chmod +x Auto_Scan.sh
```

### 3. (Recommended) Source it instead of executing

Aliases created by a script do **not** persist unless sourced:

```bash
source ./Auto_Scan.sh
```

### 4. Verify alias creation

```bash
alias
```

---

## 📌 Recommended Setup for Persistent Aliases

To ensure aliases persist across shell sessions:

1. Modify the script to output aliases to a file (e.g., `~/.auto_aliases`).
2. Add the following to `~/.bashrc`:

```bash
source ~/.auto_aliases
```

Feel free to ask if you'd like an automatic export feature added!

---

## 🧱 Code Structure

* **Color variables** for consistent output styling
* **Header printing** with decorative formatting
* **Debug-friendly logging functions**
* **Modular logic** for scanning and alias generation
* **Error handling** for missing directories

---

## 👤 Author

**Khaled El-Sayed**
- 📧 Email: *[Khaled.3bdulaziz@gmail.com](mailto:Khaled.3bdulaziz@gmail.com)*
- 🐙 GitHub: *[https://github.com/t0ti20](https://github.com/t0ti20)*
- 💼 LinkedIn: *[https://www.linkedin.com/in/khaled3bdulaziz/](https://www.linkedin.com/in/khaled3bdulaziz/)*

---

## 📝 License

This project is free to use, modify, and integrate into your workflow.
