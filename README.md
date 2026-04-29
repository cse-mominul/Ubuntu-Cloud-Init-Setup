# 🚀 Ubuntu Cloud-Init Auto-Reset Setup
This repository provides an automated solution for Ubuntu systems to reset **cloud-init** data and logs on every boot. It is ideal for building **Golden Images** or VM templates in cloud environments like **Proxmox**, **XCP-ng**, or **Apache CloudStack** where a fresh initialization is required after every restart.

## 🛠️ Key Features
The script automates these critical steps to keep your system in a "template-ready" state:
*   **Wipe Instance Data**: Removes all existing cloud-init instance data and logs from `/var/lib/cloud/`.
*   **Clear SSH Keys**: Truncates the `authorized_keys` file for the default user (`/home/ubuntu/`) to prevent old key             persistence.
*   **Auto-Configure `cloud.cfg`**: Updates `/etc/cloud/cloud.cfg` to ensure `preserve_hostname: false` and `ssh_deletekeys:       true`.
*   **Systemd Integration**: Sets up a custom service that runs **before** the cloud-init local service starts.


## 💻 How to Run
### 1. Direct Execution (Quickest Method)
Run this single command to download, set permissions, and execute the setup immediately from your repository:
```bash
curl -s [https://raw.githubusercontent.com/cse-mominul/Ubuntu-Cloud-Init-Setup/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh](https://raw.githubusercontent.com/cse-mominul/Ubuntu-Cloud-Init-Setup/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh) | sudo bash
wget [https://raw.githubusercontent.com/cse-mominul/Ubuntu-Cloud-Init-Setup/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh](https://raw.githubusercontent.com/cse-mominul/Ubuntu-Cloud-Init-Setup/main/Ubuntu-Cloud-Init-Auto-Reset-Setup.sh)
chmod +x Ubuntu-Cloud-Init-Auto-Reset-Setup.sh
sudo ./Ubuntu-Cloud-Init-Auto-Reset-Setup.sh
