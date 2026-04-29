#!/bin/bash

# Title: Ubuntu-Cloud-Init Auto-Reset Setup (Full Auto)
# Description: Automates cloud-init reset and configuration updates

echo "----------------------------------------------------"
echo "   Ubuntu-Cloud-Init Auto-Reset Setup Starting      "
echo "----------------------------------------------------"

# --- STEP 1: Update cloud.cfg settings automatically ---
echo "[>] Updating /etc/cloud/cloud.cfg settings..."

# preserve_hostname: false set kora
sudo sed -i 's/preserve_hostname: true/preserve_hostname: false/g' /etc/cloud/cloud.cfg
# ssh_deletekeys: true set kora[cite: 1]
if grep -q "ssh_deletekeys" /etc/cloud/cloud.cfg; then
    sudo sed -i 's/ssh_deletekeys: .*/ssh_deletekeys: true/g' /etc/cloud/cloud.cfg
else
    echo "ssh_deletekeys: true" | sudo tee -a /etc/cloud/cloud.cfg > /dev/null
fi
echo "[✔] cloud.cfg updated (preserve_hostname: false, ssh_deletekeys: true)[cite: 1]"


# --- STEP 2: Create the Reset Script ---
cat << 'EOF' | sudo tee /usr/local/bin/reset-cloud-init.sh > /dev/null
#!/bin/bash
# Remove cloud-init instance data[cite: 1]
rm -rf /var/lib/cloud/instance[cite: 1]
rm -rf /var/lib/cloud/instances/*[cite: 1]

# Clear the authorized_keys file[cite: 1]
truncate -s 0 /home/ubuntu/.ssh/authorized_keys[cite: 1]

# Clean cloud-init logs and cache[cite: 1]
cloud-init clean --logs[cite: 1]
EOF

sudo chmod +x /usr/local/bin/reset-cloud-init.sh[cite: 1]
echo "[✔] Reset script created at /usr/local/bin/reset-cloud-init.sh[cite: 1]"


# --- STEP 3: Create the Systemd Service ---
cat << 'EOF' | sudo tee /etc/systemd/system/cloud-init-reset.service > /dev/null
[Unit]
Description=Reset Cloud-Init on every boot[cite: 1]
Before=cloud-init-local.service[cite: 1]
DefaultDependencies=no[cite: 1]

[Service]
Type=oneshot[cite: 1]
ExecStart=/usr/local/bin/reset-cloud-init.sh[cite: 1]
RemainAfterExit=yes[cite: 1]

[Install]
WantedBy=multi-user.target[cite: 1]
EOF
echo "[✔] Systemd service created[cite: 1]"


# --- STEP 4: Enable and Start ---
sudo systemctl daemon-reload[cite: 1]
sudo systemctl enable cloud-init-reset.service[cite: 1]
echo "[✔] Service enabled[cite: 1]"

echo "----------------------------------------------------"
echo "Setup Complete! Your golden image is ready for Cloud.[cite: 1]"
echo "----------------------------------------------------"
