#!/bin/bash

# Directory where backups are stored
vcd_backup="/opt/vmware/vcloud-director/data/transfer/backups"

# Function to check and delete the backups which are older than 30 days
remove_old_backups() {
  # Find files older than 30 days
  older_backups=$(find "$vcd_backup" -type f -mtime +30)

  if [ -n "$older_backups" ]; then
    # If older backups are found, delete them
    echo "Deleting older backups:"
    echo "$older_backups" | xargs -t rm -f
  else
    # If no older backups are found, print a message
    echo "No backups older than 30 days found."
  fi
}

# Check if the current node is the Primary VCD Cell
if sudo -i -u postgres repmgr node check --role | grep -q primary; then
  echo "Running Backup Job"
  # Execute the backup script
  /opt/vmware/appliance/bin/create-backup.sh
  # Call the function to remove old backups
  remove_old_backups
else
  echo "This is not the Primary cell"
fi