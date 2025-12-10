# SSH Host Selector

An interactive **Bash-based SSH Host Selector** that reads from your `~/.ssh/config` file and provides a simple **keyboard-navigable menu** to quickly connect to your configured SSH hosts.

---

## 📌 Features

* **Automatic Host Detection** – Reads and lists all defined SSH hosts (ignoring wildcard `*`).
* **Interactive Menu** – Navigate with **arrow keys**, select with **Enter**, quit with **q**.
* **Color-Coded UI** – Highlights the currently selected host for better visibility.
* **Keyboard-Only Workflow** – No need to type host names manually.
* **Error Handling** – Gracefully exits if no hosts are found in the SSH config.

---

## 📂 Requirements

* **Bash** (version 4+ recommended)
* A properly configured SSH configuration file (`~/.ssh/config`)
* `tput` command (commonly available in most Unix/Linux distributions)

---

## ⚙️ Installation

1. Save the script as `ssh-selector.sh`.
2. Make the script executable:

   ```bash
   chmod +x ssh-selector.sh
   ```
3. (Optional) Move it to a directory in your `PATH` for global use:

   ```bash
   sudo mv ssh-selector.sh /usr/local/bin/ssh-selector
   ```

---

## 🚀 Usage

Run the script:

```bash
./ssh-selector.sh
```

Or, if installed globally:

```bash
ssh-selector
```

### Controls:

* **↑ / ↓** – Navigate through SSH host list
* **Enter** – Connect to selected host
* **q** – Quit the script

---

## 🛠 Example SSH Config

The script pulls data from your `~/.ssh/config`.
Example:

```ssh
Host myserver
    HostName 192.168.1.100
    User myuser
    Port 22

Host github
    HostName github.com
    User git
```

When you run the script, you’ll see:

```
=================================================================
Select an SSH Host:
 > myserver
   github
=================================================================
```

---

## 📜 License

This project is released under the **MIT License** – free to use, modify, and distribute.

---

## 👤 Author

**Khaled El-Sayed**
📧 Email: [Khaled.3bdulaziz@gmail.com](mailto:Khaled.3bdulaziz@gmail.com)
💻 GitHub: [t0ti20](https://github.com/t0ti20)
🔗 LinkedIn: [Khaled El-Sayed](https://www.linkedin.com/in/khaled3bdulaziz/)

---