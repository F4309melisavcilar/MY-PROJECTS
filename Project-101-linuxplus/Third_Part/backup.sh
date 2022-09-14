#!/bin/bash
# Check if we are root privilage or not
if [[ $(id -u) -ne 0 ]]
then
        echo "Please run as root"
        exit 1
fi
# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
backup_files="/home/ec2-user/data /etc /boot /usr"
# Where do we backup to. Please crete this file before execute this script
dest="/mnt/backup"
# Create archive filename based on time
time_part=$(date +%Y_%m_%d_%H_%M)
hostname=$(hostname -s)
archive_file="${hostname}_${time_part}.tgz"
# Print start status message.
echo "Starting backup of ${backup_files} to ${dest}/${archive_file}"
# Backup the files using tar.
tar -cf "${dest}/${archive_file}" $backup_files &> /dev/null
# Print end status message.
echo "Done backup!"
# Long listing of files in $dest to check file sizes.
ls -l "${dest}/${archive_file}"
# Crontab entry
# */5 * * * * /home/ec2-user/my-repository/ThirdPart/backup.sh
