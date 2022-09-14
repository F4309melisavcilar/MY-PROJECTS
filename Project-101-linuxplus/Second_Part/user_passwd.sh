#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.


# Get the username (login).

# Get the real name (contents for the description field).

# Get the password.

# Create the account.

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.

# Set the password.

# Check to see if the passwd command succeeded.

# Force password change on first login.

# Display the username, password, and the host where the user was created.


whoami
sudowhoami
id
nano user_passwd.sh 


if [[ $(whoami) != "root" ]]
then
       echo "Please run this script as root user"
       exit 1
fi

read -p "Enter the username to creat: " USER_NAME
read -p "Enter the user FIRST and LAST name" COMMENT
read -sp "Enter the password: " PASSWORD
useradd -C "${COMMENT}" ${USER_NAME} 2> /dev/null

#check user added or not
if [[ $? -ne 0 ]]
then
        echo "Could not add user. Check for duplicate."
        exit 2  
fi

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ $? -ne 0 ]]
then
       echo "Could not set the password."
       exit 3
fi


passwd -e {$USER_NAME}

echo "Username is: ${USER_NAME}"
echo "Password is: ${PASSWORD}"
echo "Hostname is: $(hostname)"

#
chmod +x user_passwd.sh
./user_passwd.sh
sudo ./user_passwd.sh
