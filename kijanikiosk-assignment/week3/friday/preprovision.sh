#!/bin/bash

# ============================
# Step 0: prep
# ============================
audit_file=pre-provisioning-audit.txt
rm -f "$audit_file"

echo "=== Simulating dirty VM state ==="

# ----------------------------
# Step 1: Create service accounts (from Tuesday)
# ----------------------------
for user in kk-api kk-payments kk-logs; do
  if id "$user" &>/dev/null; then
    echo "Already exists: $user" | tee -a "$audit_file"
  else
    sudo useradd -m "$user"
    echo "Created user: $user" | tee -a "$audit_file"
  fi
done

# Create group if missing and assign users
if ! getent group kijanikiosk &>/dev/null; then
  sudo groupadd kijanikiosk
  echo "Created group: kijanikiosk" | tee -a "$audit_file"
fi
for user in kk-api kk-payments kk-logs; do
  sudo usermod -aG kijanikiosk "$user"
done

# ----------------------------
# Step 2: Create directories with wrong permissions (dirty state)
# ----------------------------
sudo mkdir -p /opt/kijanikiosk/shared/logs
sudo mkdir -p /opt/kijanikiosk/config
sudo chmod 777 /opt/kijanikiosk/config
echo "Created /opt/kijanikiosk dirs and set wrong permissions on config" | tee -a "$audit_file"

# ----------------------------
# Step 3: Add a spurious firewall rule
# ----------------------------
sudo ufw --force reset
sudo ufw deny 3001
echo "Added spurious ufw deny 3001 rule" | tee -a "$audit_file"

# ----------------------------
# Step 4: Hold a package
# ----------------------------
sudo apt update -y
sudo apt install -y curl
sudo apt-mark hold curl
echo "Held package: curl" | tee -a "$audit_file"

# ----------------------------
# Step 5: Run audit commands
# ----------------------------
echo "=== Running audit commands ===" | tee -a "$audit_file"

{
getent passwd kk-api kk-payments kk-logs
getent group kijanikiosk
ls -la /opt/kijanikiosk/
getfacl /opt/kijanikiosk/shared/logs/ 2>/dev/null
getfacl /opt/kijanikiosk/config/ 2>/dev/null
sudo ufw status numbered
apt-mark showhold
systemctl list-unit-files | grep kk-
sudo systemd-analyze security kk-api.service 2>/dev/null | head -5
du -sh /opt/kijanikiosk/shared/logs/
journalctl --disk-usage
} >> "$audit_file"

echo "=== Audit complete ==="
echo "Saved output to $audit_file"

# ----------------------------
# Step 6: Add dirty-state interpretation template
# ----------------------------
cat <<EOT >> "$audit_file"

# Expected dirty conditions found:
# - Service accounts may already exist: handled by idempotent user creation in script
# - /opt/kijanikiosk/config has incorrect permissions: will reset ACLs in provisioning script Phase 3
# - spurious ufw rules exist: firewall reset and rebuild in Phase 5
# - curl is held: check version and handle package hold in Phase 1
# - Directories pre-exist: provisioning script will verify existence and skip creation if present
# - Log files may already exist in shared/logs: provisioning script will verify permissions

EOT

echo " Dirty VM simulated, audit run, and interpretation template added to $audit_file"

