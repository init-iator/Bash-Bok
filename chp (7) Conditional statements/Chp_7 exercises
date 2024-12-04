1.  Use an if/then/elif/else construct that prints information about the current month. The script should
    print the number of days in this month, and give information about leap years if the current month is
    February.

        ----------------------------------------------------------------------------------------------
        #!/usr/bin/bash
        echo "Beginning of the script"
        date +%Y
        date +%B
        month=$(date +%m)
        year=$(date +%Y)
        #if statement [] used for test the expression "$variable" -eq comparision operator
        #2 if date +%m is 2 then runs then code block

        if [ "$month" -eq 2 ]; then
            #(()) is used for aritmetic operations and logical tests
            #() command replacement
            #% modulus operator
            #== != comparition operator for equality
            #&& logical AND || logical OR

            if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
                echo "February have 29 days (leap year)."
            else
                echo "February have 28 days."
            fi
        #[[]]Advanced test operator
        #=~ RegEx controlls if month matches one of then
        #^(04|05)$ RegEx
        elif [[ "$month" =~ ^(04|06|09|11)$ ]]; then
            echo "This month have 30 days."
        else
            echo "This month have 31 days."
        fi
        ----------------------------------------------------------------------------------------------

2.  Do the same, using a case statement and an alternative use of the date command.

        ----------------------------------------------------------------------------------------------
        #!/usr/bin/bash

        # Get the current month's full name and year
        month=$(date +%B) # Full month name, e.g., "January"
        year=$(date +%Y)  # Year, e.g., "2024"

        # Use a case statement to determine the number of days in the month
        case "$month" in
            "February")
                # Check if it's a leap year
                if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
                    echo "February has 29 days (leap year)."
                else
                    echo "February has 28 days."
                fi
                ;;
            "April"|"June"|"September"|"November")
                echo "This month ($month) has 30 days."
                ;;
            *)
                echo "This month ($month) has 31 days."
                ;;
        esac
        ----------------------------------------------------------------------------------------------

3.  Modify /etc/profile so that you get a special greeting message when you connect to your
    system as root.

----------------------------------------------------------------------------------------------
#!/usr/bin/bash

# Backup the original /etc/profile file
# Creates a backup of the original /etc/profile in case something goes wrong.
cp /etc/profile /etc/profile.bak

# Append the custom greeting code to /etc/profile
cat << 'EOF' >> /etc/profile

# Custom greeting for root user
# This block checks if the user is root (user ID 0) and displays a special message.
if [ "$(id -u)" -eq 0 ]; then
    # "$(id -u)" fetches the current user's ID.
    # The "-eq 0" condition checks if the user ID is 0, which indicates the root user.

    echo "------------------------------------------"
    echo " Welcome, mighty Root! Be careful out there."
    echo "------------------------------------------"
fi
# End of custom root greeting block

EOF

# Notify the user that the script has successfully modified /etc/profile
# Displays a confirmation message after appending the custom code.
echo "Custom greeting for root user has been added to /etc/profile."
----------------------------------------------------------------------------------------------

4.  Edit the leaptest.sh script from Section 7.2.4 so that it requires one argument, the year. Test that
    exactly one argument is supplied.

----------------------------------------------------------------------------------------------
        #!/usr/bin/bash

        # Check if exactly one argument is provided
        if [ "$#" -ne 1 ]; then
            echo "Usage: $0 <year>"
            exit 1
        fi

        # Store the argument as the year
        year=$1

        # Validate that the argument is a number
        if ! [[ "$year" =~ ^[0-9]+$ ]]; then
            echo "Error: Year must be a numeric value."
            exit 1
        fi

        # Determine if the year is a leap year
        if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
            echo "$year is a leap year."
        else
            echo "$year is not a leap year."
        fi
----------------------------------------------------------------------------------------------

5.  Write a script called whichdaemon.sh that checks if the httpd and init daemons are running on
    your system. If an httpd is running, the script should print a message like, "This machine is running a
    web server." Use ps to check on processes.

----------------------------------------------------------------------------------------------
    #!/usr/bin/bash

    # Check if httpd is running
    if ps aux | grep -q "[h]ttpd"; then
        echo "This machine is running a web server."
    else
        echo "No web server (httpd) is running on this machine."
    fi

    # Check if init is running
    if ps aux | grep -q "[i]nit"; then
        echo "The init daemon is running on this machine."
    else
        echo "The init daemon is not running on this machine."
    fi
----------------------------------------------------------------------------------------------

6.  
    # Write a script that makes a backup of your home directory on a remote machine using scp. The script
    # should report in a log file, for instance ~/log/homebackup.log. If you don't have a second
    # machine to copy the backup to, use scp to test copying it to the localhost. This requires SSH keys
    # between the two hosts, or else you have to supply a password. The creation of SSH keys is explained
    # in man ssh-keygen.

----------------------------------------------------------------------------------------------
#!/usr/bin/bash

# Variables
REMOTE_USER="remote_user"            # Replace with your remote username
REMOTE_HOST="remote_host"            # Replace with the remote machine's hostname or IP
REMOTE_DIR="/path/to/remote/backup"  # Replace with the backup directory on the remote machine
LOG_FILE="$HOME/log/homebackup.log"  # Log file location
HOME_DIR="$HOME"                     # Local home directory
DATE=$(date +"%Y-%m-%d_%H-%M-%S")    # Timestamp for logs

# Ensure the log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Log start
echo "[$DATE] Backup started..." >> "$LOG_FILE"

# Perform the backup using scp
scp -r "$HOME_DIR" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" &>> "$LOG_FILE"

# Check the success of the operation
if [ $? -eq 0 ]; then
    echo "[$DATE] Backup completed successfully." >> "$LOG_FILE"
else
    echo "[$DATE] Backup failed." >> "$LOG_FILE"
fi
----------------------------------------------------------------------------------------------
6.1
----------------------------------------------------------------------------------------------
#!/usr/bin/bash

# Usage message
usage() {
    echo "Usage: $0 <REMOTE_USER> <REMOTE_HOST> <REMOTE_DIR>"
    echo "  REMOTE_USER  - Username for the remote machine"
    echo "  REMOTE_HOST  - Hostname or IP of the remote machine"
    echo "  REMOTE_DIR   - Directory on the remote machine for backup"
    exit 1
}

# Check if the correct number of arguments is supplied
if [ "$#" -ne 3 ]; then
    echo "Error: Incorrect number of arguments."
    usage
fi

# Assign arguments to variables
REMOTE_USER=$1
REMOTE_HOST=$2
REMOTE_DIR=$3

# Other variables
LOG_FILE="$HOME/log/homebackup.log"
HOME_DIR="$HOME"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Ensure the log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Log start
echo "[$DATE] Backup started..." >> "$LOG_FILE"

# Perform the backup using scp
scp -r "$HOME_DIR" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" &>> "$LOG_FILE"

# Check the success of the operation
if [ $? -eq 0 ]; then
    echo "[$DATE] Backup completed successfully." >> "$LOG_FILE"
else
    echo "[$DATE] Backup failed." >> "$LOG_FILE"
fi
----------------------------------------------------------------------------------------------

7.
    # Adapt the script from the first example in Section 7.3.1 to include the case of exactly 90% disk space
    # usage, and lower than 10% disk space usage.

----------------------------------------------------------------------------------------------
#!/bin/bash
# This script does a very simple test for checking disk space.

# Creates a .tar -> .zip and stores it in /tmp/
# If backup already exists delete it first

SOURCE=~/dev/bash-linux-doe24
TARGET=/tmp/ex7-7.tar.gz

# Check if file exists
if [ -e $TARGET ];then
    rm $TARGET;
    echo "Compressed archive found, deleting"
    if [ $? -eq 0 ] ;then   # Check if rm ran succesfully
        echo "Successfully deleted $TARGET";
    else
        echo "Deletion failed";
        exit 1
    fi
fi

echo "Compressing $SOURCE and storing under $TARGET"
tar czf $TARGET $SOURCE



space=`df -h | awk '{print $5}' | grep -v Use | sort -n | tail -1 | cut -d "%" -f1`

case $space in
    [1-9])      # <10%
        Message="Lower than 10%"
        ;;
    [1-6]*)     # 10% ≤ space < 70
        Message="All is quiet."
        ;;
    [7-8]*)     # 70% ≤ space < 90
        Message="Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
        ;;
    90)
        Message="Exactly $space"
        ;;
    9[1-8])     # 90% ≤ space < 99
        Message="Better hurry with that new disk...  One partition is $space % full."
        ;;
    99)         # 99% ≤ space
        Message="I'm drowning here!  There's a partition at $space %!"
        ;;
    *)
        Message="I seem to be running with an nonexistent amount of disk space..."
        ;;
esac

echo $Message
----------------------------------------------------------------------------------------------