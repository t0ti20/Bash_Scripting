# Git Repository Management Script

A **Bash utility** to manage multiple Git repositories within a specified directory.
This script provides an interactive menu to list, filter, reset, execute commands, and export changes across all detected repositories.

---

## 📌 Features

* **Auto-discovery** of Git repositories (recursive search)
* **Interactive menu** for easy navigation
* **Repository filtering** – ignore unwanted repos in operations
* **Detect changed repos** – only work with repositories containing updates
* **Execute custom Git commands** across all repositories
* **Hard reset** repositories to `HEAD`
* **List changed and untracked files**
* **Export changed/untracked files** into a separate folder
* **Force execution mode** to skip confirmations

---

## 📂 Project Structure

```
.
├── Manual_Merge.sh    # The main Bash script
└── README.md          # Documentation (this file)
```

---

## ⚙️ Requirements

* **Bash** (v4+ recommended)
* **Git** installed and available in `$PATH`
* **Linux / macOS** terminal (or WSL on Windows)

---

## 🚀 Usage

```bash
chmod +x Manual_Merge.sh
./Manual_Merge.sh <base_directory> [-f]
```

**Arguments:**

* `<base_directory>` → Root folder to start scanning for `.git` repositories
* `-f` (optional) → Force execution mode (skip confirmations for commands)

---

## 📖 Example

**Scan and manage repos in `/projects` with confirmation prompts:**

```bash
./Manual_Merge.sh /projects
```

**Force execute without prompts:**

```bash
./Manual_Merge.sh /projects -f
```

---

## 📜 Menu Options

| Option | Description                                               |
| ------ | --------------------------------------------------------- |
| **1**  | Ignore selected repositories                              |
| **2**  | Update repo list to changed ones only                     |
| **3**  | Execute custom command in all repositories                |
| **4**  | Reset repositories (`git reset --hard` + `git clean -fd`) |
| **5**  | List changed and untracked files                          |
| **6**  | Export changed/untracked files to `./Changes`             |
| **q**  | Quit the tool                                             |

---

## 🛠 Example Workflows

**1. List all changed files in `/dev` projects:**

```bash
./Manual_Merge.sh /dev
# Choose option 5 in the menu
```

**2. Reset all repos under `/work` to HEAD:**

```bash
./Manual_Merge.sh /work
# Choose option 4 in the menu
```

**3. Export all changes from repos under `/src`:**

```bash
./Manual_Merge.sh /src
# Choose option 6 in the menu
```

---

## ⚠️ Warnings

* **Resetting repositories** will discard **all uncommitted changes**.
* **Force mode (`-f`)** runs commands without confirmation – use with caution.
* Ensure you have **backups** before running destructive commands.

---

## 👤 Author

**Khaled El-Sayed**
📧 Email: [Khaled.3bdulaziz@gmail.com](mailto:Khaled.3bdulaziz@gmail.com)
🌐 GitHub: [t0ti20](https://github.com/t0ti20)
💼 LinkedIn: [khaled3bdulaziz](https://www.linkedin.com/in/khaled3bdulaziz/)
