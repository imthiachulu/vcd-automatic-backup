
<img src="http://imthiyaz.cloud/wp-content/uploads/2024/03/Automatic-Backup-VCD.png" alt="VCD Automatic Backup" width="100%" height="100%">

# VCD Automatic Backup
This script is to automate the backup process for VMware Cloud Director (VCD). It includes functionality to create backups and manage the retention of older backups. I have written a [blog post](https://imthiyaz.cloud/how-to-schedule-automatic-backup-for-vmware-cloud-director/) on this.

### Script Overview
Backup Directory: The script specifies the directory where backups are stored <code>(vcd_backup="/opt/vmware/vcloud-director/data/transfer/backups")</code>

Remove Old Backups Function: A function named <code>remove_old_backups()</code> is defined to find and delete backups that are older than 15 days. If no backups are found older than 15 days, it prints a message indicating so.

Primary VCD Cell Check: The script checks if the current node is the Primary VCD Cell by using <code>sudo -i -u postgres repmgr node check --role | grep -q primary</code>. If it detects the primary cell, it proceeds to execute the backup job and removes backups older than 15 days. If not, it prints a message indicating that it's not the primary cell.

**Supported VCD Version:**
10.3, 10.4.x, 10.5.x

<img src="http://imthiyaz.cloud/wp-content/uploads/2024/03/Automatic-Backup-VCD-inaction.png" alt="VCD Automatic Backup" width="100%" height="100%">

### How to Use
Clone the Repository: Clone the repository containing the script to your local machine.

Edit Script (Optional): If needed, modify the script to specify the correct backup directory or adjust any other settings according to your environment.

Set Execute Permissions: Ensure the script has execute permissions. If not, run:
> chmod +x vcd_backup_script.sh

Test the Script: Before adding it to a cron job, test the script to ensure it functions as expected:

Run the script
> ./vcd_backup_script.sh

Add to Cron Job: To schedule the script to run automatically at specific intervals, add it to the cron job. For example, to run the script daily, use:

> 0 0 * * * /path/to/vcd_backup_script.sh > /dev/null 2>&1


**Important Notes**

Ensure that the script is executed with appropriate permissions to access VCD directories and perform backup operations.
Regularly monitor backup logs and verify the success of backup operations.
Adjust the cron schedule according to your backup requirements and server load.
By following these steps, you can automate the backup process for VMware Cloud Director installations and ensure the retention of backups for disaster recovery purposes.
