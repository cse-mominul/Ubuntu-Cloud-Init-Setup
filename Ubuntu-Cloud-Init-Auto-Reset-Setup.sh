#!/bin/bash

# Title: Ubuntu-Cloud-Init Auto-Reset Setup (Full Auto)
# Description: Automates cloud-init reset and configuration updates

echo "----------------------------------------------------"
echo "   Ubuntu-Cloud-Init Auto-Reset Setup Starting      "
echo "----------------------------------------------------"

# --- STEP 1: Update cloud.cfg settings automatically ---
echo "[>] Updating /etc/cloud/cloud.cfg settings..."

# Set preserve_hostname to false
sudo sed -i 's/preserve_hostname: true/preserve_hostname: false/g' /etc/cloud/cloud.cfg

# Set ssh_deletekeys to true
if grep -q "ssh_deletekeys" /etc/cloud/cloud.cfg; then
    sudo sed -i 's/ssh_deletekeys: .*/ssh_deletekeys: true/g' /etc/cloud/cloud.cfg
else
    echo "ssh_deletekeys: true" | sudo tee -a /etc/cloud/cloud.cfg > /dev/null
fi
echo "[✔] cloud.cfg updated (preserve_hostname: false, ssh_deletekeys: true)"


# --- STEP 2: Create the Reset Script ---
cat << 'EOF' | sudo tee /usr/local/bin/reset-cloud-init.sh > /dev/null
#!/bin/bash
# Remove cloud-init instance data
rm -rf /var/lib/cloud/instance
rm -rf /var/lib/cloud/instances/*

# Clear the authorized_keys file for fresh deployment
truncate -s 0 /home/ubuntu/.ssh/authorized_keys

# Clean cloud-init logs and cache
cloud-init clean --logs
EOF

sudo chmod +x /usr/local/bin/reset-cloud-init.sh
echo "[✔] Reset script created at /usr/local/bin/reset-cloud-init.sh"


# --- STEP 3: Create the Systemd Service ---
cat << 'EOF' | sudo tee /etc/systemd/system/cloud-init-reset.service > /dev/null
[Unit]
Description=Reset Cloud-Init on every boot
Before=cloud-init-local.service
DefaultDependencies=no

[Service]
Type=oneshot
ExecStart=/usr/local/bin/reset-cloud-init.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
echo "[✔] Systemd service created"


# --- STEP 4: Enable and Start ---
sudo systemctl daemon-reload
sudo systemctl enable cloud-init-reset.service
echo "[✔] Service enabled"

echo "----------------------------------------------------"
echo "Setup Complete! Your golden image is ready for Cloud."
echo "----------------------------------------------------"
