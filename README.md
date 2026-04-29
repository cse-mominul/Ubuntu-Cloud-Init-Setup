# 🚀 Ubuntu Cloud-Init Auto-Reset Setup

This repository provides an automated solution for Ubuntu systems to reset **cloud-init** data and logs on every boot[cite: 1]. It is ideal for building **Golden Images** or VM templates in cloud environments like **Proxmox**, **XCP-ng**, or **Apache CloudStack** where a fresh initialization is required after every restart[cite: 1].

---

## 🛠️ Key Features

The script automates these critical steps to keep your system in a "template-ready" state:

*   **Wipe Instance Data**: Removes all existing cloud-init instance data and logs from `/var/lib/cloud/`[cite: 1].
*   **Clear SSH Keys**: Truncates the `authorized_keys` file for the default user (`/home/ubuntu/`) to prevent old key persistence[cite: 1].
*   **Auto-Configure `cloud.cfg`**: Updates `/etc/cloud/cloud.cfg` to ensure `preserve_hostname: false` and `ssh_deletekeys: true`[cite: 1].
*   **Systemd Integration**: Sets up a custom service that runs **before** the cloud-init local service starts[cite: 1].

---

## 💻 How to Run

### 1. Direct Execution (Recommended)
Run this single command to download and execute the setup immediately. Replace the placeholders with your GitHub details:
```bash
curl -s [https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh](https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh) | bash
wget [https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh](https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh)
    ```
2.  **Grant Permissions**:
    You must make the script executable[cite: 1]:
    ```bash
    chmod +x Ubuntu-Cloud-Init-Auto-Reset-Setup.sh
    ```
3.  **Run with Sudo**:
    ```bash
    sudo ./Ubuntu-Cloud-Init-Auto-Reset-Setup.sh
    ```

---

## 📋 Step-by-Step Installation Process

Once executed, the script performs the following[cite: 1]:
1.  **Script Creation**: Generates the reset logic at `/usr/local/bin/reset-cloud-init.sh`[cite: 1].
2.  **Permissions**: Grants executable rights to the reset script[cite: 1].
3.  **Service Configuration**: Creates `/etc/systemd/system/cloud-init-reset.service`[cite: 1].
4.  **Activation**: Reloads the systemd daemon and enables the service to persist across reboots[cite: 1].

---

## ⚠️ Important Notes

*   **SSH Access**: This script clears the `authorized_keys` file on every boot[cite: 1]. Ensure your cloud environment provides a new SSH key via metadata services to avoid losing access[cite: 1].
*   **Golden Images Only**: This is intended for **template systems only**[cite: 1]. Do not use this on production servers where local configurations must persist[cite: 1].

---
> **Generated for Ubuntu Systems Administration | Cloud Configuration Guide**[cite: 1]
