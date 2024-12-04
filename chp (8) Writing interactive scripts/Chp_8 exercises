1.  
    # Write a script that asks for the user's age. If it is equal to or higher than 16, print a message saying that
    # this user is allowed to drink alcohol. If the user's age is below 16, print a message telling the user how
    # many years he or she has to wait before legally being allowed to drink.
    # As an extra, calculate how much beer an 18+ user has drunk statistically (100 liters/year) and print
    # this information for the user.
-------------------------------------------------------------------------------------------
#!/bin/bash

# Ask for the user's age
read -p "Please enter your age: " age

# Check if the age is valid (positive integer)
if ! [[ "$age" =~ ^[0-9]+$ ]] || [ "$age" -lt 0 ]; then
    echo "Invalid input. Please enter a positive number for age."
    exit 1
fi

# Check if the user is 16 or older
if [ "$age" -ge 16 ]; then
    echo "You are allowed to drink alcohol."
    
    # If the user is 18 or older, calculate beer consumption
    if [ "$age" -ge 18 ]; then
        # Calculate beer consumption for an 18+ user
        beer_consumed=$(( (age - 18) * 100 ))  # 100 liters per year
        echo "Statistically, you have drunk approximately $beer_consumed liters of beer."
    fi
else
    # If the user is below 16, tell them how many years they have to wait
    years_to_wait=$((16 - age))
    echo "You need to wait $years_to_wait more years to be allowed to drink alcohol."
fi
-------------------------------------------------------------------------------------------

2.
    # Write a script that takes one file as an argument. Use a here document that presents the user with a
    # couple of choices for compressing the file. Possible choices could be gzip, bzip2, compress and zip.
-------------------------------------------------------------------------------------------
#!/bin/bash

# Check if a file was provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_to_compress>"
    exit 1
fi

# Check if the provided file exists
file=$1
if [ ! -f "$file" ]; then
    echo "Error: $file does not exist."
    exit 1
fi

# Present the user with compression options using a here document
echo "Choose a compression method for the file '$file':"
cat << EOF
1) gzip
2) bzip2
3) compress
4) zip
EOF

# Read user choice
read -p "Enter your choice (1-4): " choice

# Perform the compression based on the user's choice
case $choice in
    1)
        echo "Compressing using gzip..."
        gzip "$file"
        ;;
    2)
        echo "Compressing using bzip2..."
        bzip2 "$file"
        ;;
    3)
        echo "Compressing using compress..."
        compress "$file"
        ;;
    4)
        echo "Compressing using zip..."
        zip "${file}.zip" "$file"
        ;;
    *)
        echo "Invalid choice. Please select a valid option (1-4)."
        exit 1
        ;;
esac

echo "Compression complete."
-------------------------------------------------------------------------------------------

3.
    # Write a script called homebackup that automates tar so the person executing the script always uses
    # the desired options (cvp) and backup destination directory (/var/backups) to make a backup of
    # his or her home directory. Implement the following features:
        # Test for the number of arguments. The script should run without arguments. If any arguments
        # are present, exit after printing a usage message.

        # Determine whether the backups directory has enough free space to hold the backup.
        
        # Ask the user whether a full or an incremental backup is wanted. If the user does not have a
        # full backup file yet, print a message that a full backup will be taken. In case of an incremental
        # backup, only do this if the full backup is not older than a week.
        
        # Compress the backup using any compression tool. Inform the user that the script is doing this,
        # because it might take some time, during which the user might start worrying if no output
        # appears on the screen.
        
        # Print a message informing the user about the size of the compressed backup.

    homebackup.sh
-------------------------------------------------------------------------------------------
        #!/bin/bash

        # 1. Check for arguments (it should run without arguments)
        if [ $# -gt 0 ]; then
            echo "Usage: $0 (No arguments are required)"
            exit 1
        fi

        # 2. Define variables
        BACKUP_DIR="/var/backups"
        HOME_DIR="$HOME"
        BACKUP_FILE="$BACKUP_DIR/$(whoami)_backup.tar"
        INCREMENTAL_FILE="$BACKUP_DIR/$(whoami)_incremental.snar"
        FULL_BACKUP_FILE="$BACKUP_DIR/$(whoami)_full_backup.tar"

        # 3. Check if the backup directory has enough space
        AVAILABLE_SPACE=$(df "$BACKUP_DIR" | tail -1 | awk '{print $4}')
        BACKUP_SIZE=$(du -s "$HOME_DIR" | awk '{print $1}')
        if [ "$AVAILABLE_SPACE" -lt "$BACKUP_SIZE" ]; then
            echo "Error: Not enough free space in $BACKUP_DIR to complete the backup."
            exit 1
        fi

        # 4. Ask user whether a full or incremental backup is wanted
        if [ ! -f "$FULL_BACKUP_FILE" ]; then
            # If there is no full backup, we have to do a full backup
            echo "No full backup found. A full backup will be taken."
            BACKUP_TYPE="full"
        else
            echo "Do you want to take a full backup or an incremental backup?"
            echo "1) Full backup"
            echo "2) Incremental backup"
            read -p "Choose (1 or 2): " CHOICE

            if [ "$CHOICE" -eq 1 ]; then
                BACKUP_TYPE="full"
            elif [ "$CHOICE" -eq 2 ]; then
                # Check if the full backup is older than a week
                FULL_BACKUP_DATE=$(stat -c %Y "$FULL_BACKUP_FILE")
                CURRENT_DATE=$(date +%s)
                AGE=$(( (CURRENT_DATE - FULL_BACKUP_DATE) / 86400 )) # age in days

                if [ "$AGE" -le 7 ]; then
                    BACKUP_TYPE="incremental"
                else
                    echo "Full backup is older than a week. A full backup will be taken."
                    BACKUP_TYPE="full"
                fi
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
        fi

        # 5. Perform the backup with compression
        if [ "$BACKUP_TYPE" == "full" ]; then
            echo "Creating a full backup of $HOME_DIR..."

            # Create the full backup with compression
            tar -cvpzf "$BACKUP_FILE" "$HOME_DIR" > /dev/null 2>&1
            BACKUP_PATH="$BACKUP_FILE"
        elif [ "$BACKUP_TYPE" == "incremental" ]; then
            echo "Creating an incremental backup of $HOME_DIR..."

            # Create the incremental backup
            tar -cvpzf "$BACKUP_FILE" --listed-incremental="$INCREMENTAL_FILE" "$HOME_DIR" > /dev/null 2>&1
            BACKUP_PATH="$BACKUP_FILE"
        fi

        # 6. Inform the user that compression is done and show the size
        echo "Backup completed."
        BACKUP_SIZE_COMPRESSED=$(du -sh "$BACKUP_PATH" | awk '{print $1}')
        echo "The size of the compressed backup is $BACKUP_SIZE_COMPRESSED."
-------------------------------------------------------------------------------------------

4.
    # Write a script called simple-useradd.sh that adds a local user to the system. This script should:
    #     Take only one argument, or else exit after printing a usage message.
        
    #     Check /etc/passwd and decide on the first free user ID. Print a message containing this
    #     ID.
        
    #     Create a private group for this user, checking the /etc/group file. Print a message
    #     containing the group ID.

    #     Gather information from the operator user: a comment describing this user, choice from a list
    #     of shells (test for acceptability, else exit printing a message), expiration date for this account,
    #     extra groups of which the new user should be a member.

    #     With the obtained information, add a line to /etc/passwd, /etc/group and
    #     /etc/shadow; create the user's home directory (with correct permissions!); add the user to
    #     the desired secondary groups.

    #     Set the password for this user to a default known string.
-------------------------------------------------------------------------------------------
#!/bin/bash

# 1. Check for the number of arguments (the script should only take one argument)
if [ $# -ne 1 ]; then
    echo "Usage: $0 username"
    exit 1
fi

# 2. Set the username and the home directory
USERNAME=$1
HOMEDIR="/home/$USERNAME"
USERID=$(awk -F: '{if($3>=1000) print $3}' /etc/passwd | sort -n | tail -1)
USERID=$((USERID + 1))

# 3. Print the assigned user ID
echo "The assigned user ID for $USERNAME is: $USERID"

# 4. Check for the first available group ID
GROUPID=$(awk -F: '{if($3>=1000) print $3}' /etc/group | sort -n | tail -1)
GROUPID=$((GROUPID + 1))

# 5. Print the assigned group ID
echo "The assigned group ID for $USERNAME is: $GROUPID"

# 6. Create a private group for the user
groupadd -g $GROUPID $USERNAME

# 7. Gather information from the operator user
echo "Enter a comment for this user (e.g., Full Name):"
read COMMENT

# Choose the shell from a predefined list
echo "Choose a shell for $USERNAME:"
echo "1) /bin/bash"
echo "2) /bin/zsh"
echo "3) /bin/dash"
read -p "Enter the number of your choice (1, 2, or 3): " SHELL_CHOICE

case $SHELL_CHOICE in
    1) SHELL="/bin/bash" ;;
    2) SHELL="/bin/zsh" ;;
    3) SHELL="/bin/dash" ;;
    *) 
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Expiration date input
echo "Enter the expiration date for the account (format: YYYY-MM-DD):"
read EXPIRATION_DATE

# Extra groups input
echo "Enter any extra groups to which this user should belong (comma separated, no spaces):"
read EXTRA_GROUPS

# 8. Add the user to /etc/passwd, /etc/group, and /etc/shadow
useradd -m -u $USERID -g $USERNAME -c "$COMMENT" -s $SHELL -e $EXPIRATION_DATE -G $EXTRA_GROUPS $USERNAME

# 9. Create the user's home directory with correct permissions
mkdir -p $HOMEDIR
chown $USERNAME:$USERNAME $HOMEDIR
chmod 700 $HOMEDIR

# 10. Set a default password for the user (e.g., "password123")
echo "$USERNAME:password123" | chpasswd

# 11. Display the user information
echo "User $USERNAME has been successfully added."
echo "Home directory: $HOMEDIR"
echo "Shell: $SHELL"
echo "Expiration date: $EXPIRATION_DATE"
echo "Extra groups: $EXTRA_GROUPS"

-------------------------------------------------------------------------------------------

5.
# Rewrite the script so that it reads input from the user instead of taking it from the first argument.

#     #!/bin/bash
#     # This script gives information about a file.
#     FILENAME="$1"
#     echo "Properties for $FILENAME:"
#     if [ -f $FILENAME ]; then
#         echo "Size is $(ls -lh $FILENAME | awk '{ print $5 }')"
#         echo "Type is $(file $FILENAME | cut -d":" -f2 -)"
#         echo "Inode number is $(ls -i $FILENAME | cut -d" " -f1 -)"
#         echo "$(df -h $FILENAME | grep -v Mounted | awk '{ print "On",$1", \
#     which is mounted as the",$6,"partition."}')"
#     else
#         echo "File does not exist."
#     fi
-------------------------------------------------------------------------------------------
#!/bin/bash
# This script gives information about a file.

# Ask the user for the filename
read -p "Please enter the filename: " FILENAME

# Check if the file exists and provide information about it
echo "Properties for $FILENAME:"
if [ -f "$FILENAME" ]; then
    echo "Size is $(ls -lh "$FILENAME" | awk '{ print $5 }')"
    echo "Type is $(file "$FILENAME" | cut -d":" -f2 -)"
    echo "Inode number is $(ls -i "$FILENAME" | cut -d" " -f1 -)"
    echo "$(df -h "$FILENAME" | grep -v Mounted | awk '{ print "On",$1", which is mounted as the",$6,"partition."}')"
else
    echo "File does not exist."
fi
-------------------------------------------------------------------------------------------
