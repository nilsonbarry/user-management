#!/bin/bash

LOGFILE="logs/user_report.log"
mkdir -p logs

echo "===== User Management Report =====" >> $LOGFILE
date >> $LOGFILE

# Create User
create_user() {
    read -p "Enter username: " username
    sudo useradd $username

    if [ $? -eq 0 ]; then
        echo "✅ User $username created successfully"
        echo "User $username created" >> $LOGFILE
    else
        echo "❌ Failed to create user"
    fi
}

# Delete User
delete_user() {
    read -p "Enter username to delete: " username
    sudo userdel $username

    if [ $? -eq 0 ]; then
        echo "✅ User $username deleted"
        echo "User $username deleted" >> $LOGFILE
    else
        echo "❌ Failed to delete user"
    fi
}

# Set Password
set_password() {
    read -p "Enter username: " username
    sudo passwd $username
    echo "Password updated for $username" >> $LOGFILE
}

# Add to Group
add_to_group() {
    read -p "Enter username: " username
    read -p "Enter group: " group
    sudo usermod -aG $group $username

    if [ $? -eq 0 ]; then
        echo "✅ $username added to $group"
        echo "$username added to $group" >> $LOGFILE
    else
        echo "❌ Failed to add user to group"
    fi
}

# List Users
list_users() {
    echo "📋 System Users:"
    cut -d: -f1 /etc/passwd
}

# Menu
while true; do
    echo ""
    echo "===== User Management Menu ====="
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Set Password"
    echo "4. Add User to Group"
    echo "5. List Users"
    echo "6. Exit"

    read -p "Choose option: " option

    case $option in
        1) create_user ;;
        2) delete_user ;;
        3) set_password ;;
        4) add_to_group ;;
        5) list_users ;;
        6) exit ;;
        *) echo "Invalid option" ;;
    esac
done
