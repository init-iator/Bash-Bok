1.
    # Create a script that will take a (recursive) copy of files in /etc so that a beginning system
    # administrator can edit files without fear.

    Script: backup_etc.sh
    ------------------------------------------------------------------------------------------------------
    #!/bin/bash
    # This script creates a backup of the /etc directory.
    # It is designed to help system administrators safely edit files without fear of losing the originals.

    # Define the backup destination directory
    BACKUP_DIR="/var/backups/etc_backup"

    # Display a start message
    echo "Starting the backup process..."

    # Check if the backup directory exists, and create it if not
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup directory: $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
    fi

    # Generate a timestamped backup folder
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    BACKUP_DEST="$BACKUP_DIR/backup_$TIMESTAMP"

    # Copy /etc to the backup directory recursively
    echo "Copying files from /etc to $BACKUP_DEST..."
    cp -r /etc "$BACKUP_DEST"

    # Verify the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully!"
        echo "Your backup is located at: $BACKUP_DEST"
    else
        echo "Error: Backup failed!"
        exit 1
    fi

    # Display the size of the backup
    echo "The size of your backup is: $(du -sh "$BACKUP_DEST" | awk '{print $1}')"

    # Optional: Cleanup old backups (e.g., backups older than 7 days)
    echo "Cleaning up backups older than 7 days..."
    find "$BACKUP_DIR" -type d -mtime +7 -exec rm -rf {} \;

    echo "Backup process completed. You can safely edit /etc files now."
    ------------------------------------------------------------------------------------------------------

2.
    # Write a script that takes exactly one argument, a directory name. If the number of arguments is more
    # or less than one, print a usage message. If the argument is not a directory, print another message. For
    # the given directory, print the five biggest files and the five files that were most recently modified.

    Script: analyze_directory.sh
    ------------------------------------------------------------------------------------------------------
    #!/bin/bash
    # This script analyzes a directory and provides information about:
    # - The five largest files
    # - The five most recently modified files

    # Function to print usage
    print_usage() {
        echo "Usage: $0 <directory>"
        echo "Provide exactly one argument, which must be a valid directory."
    }

    # Check the number of arguments
    if [ "$#" -ne 1 ]; then
        print_usage
        exit 1
    fi

    # Check if the argument is a valid directory
    DIR="$1"
    if [ ! -d "$DIR" ]; then
        echo "Error: '$DIR' is not a valid directory."
        exit 2
    fi

    # Display the five largest files in the directory
    echo "The five largest files in '$DIR':"
    find "$DIR" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 5

    echo ""
    # Display the five most recently modified files in the directory
    echo "The five most recently modified files in '$DIR':"
    find "$DIR" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n -r | head -n 5 | awk '{print $2}'

    echo ""
    echo "Analysis complete."
    ------------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------------------------
    chmod +x analyze_directory.sh
    ------------------------------------------------------------------------------------------------------
    ./analyze_directory.sh /path/to/directory
    ------------------------------------------------------------------------------------------------------

3.
    # Can you explain why it is so important to put the variables in between double quotes in this example

    # #!/bin/bash
    # # This script creates a subdirectory in the current directory, to which old
    # # files are moved.
    # # Might be something for cron (if slightly adapted) to execute weekly or
    # # monthly.
    # ARCHIVENR=`date +%Y%m%d`
    # DESTDIR="$PWD/archive-$ARCHIVENR"
    # mkdir "$DESTDIR"
    # # using quotes to catch file names containing spaces, using read -d for more
    # # fool-proof usage:
    # find "$PWD" -type f -a -mtime +5 | while read -d $'\000' file
    # do
    # gzip "$file"; mv "$file".gz "$DESTDIR"
    # echo "$file archived"
    # done
    ------------------------------------------------------------------------------------------------------
    #!/bin/bash
    # This script creates a subdirectory in the current directory and archives old files.

    ARCHIVENR=`date +%Y%m%d`
    DESTDIR="$PWD/archive-$ARCHIVENR"  # Quote $PWD to handle paths with spaces
    mkdir "$DESTDIR"                  # Quote $DESTDIR to ensure it's treated as a single string

    # Use find to locate files older than 5 days
    find "$PWD" -type f -a -mtime +5 | while read -d $'\000' file
    do
        gzip "$file"                  # Quote $file to correctly handle filenames with spaces or special characters
        mv "$file".gz "$DESTDIR"      # Quote $DESTDIR and $file for the same reason
        echo "$file archived"         # Quote $file to ensure proper output even with complex filenames
    done
    ------------------------------------------------------------------------------------------------------

4.
    # Write a script similar to the one in Section 9.5.1, but think of a way of quitting after the user has
    # executed 3 loops.
    ------------------------------------------------------------------------------------------------------
        #!/bin/bash
        # This script provides wisdom and quits after 3 loops.
        FORTUNE=/usr/games/fortune
        loop_count=0  # Initialize the loop counter

        while true; do
            echo "On which topic do you want advice?"
            echo "1. politics"
            echo "2. startrek"
            echo "3. kernelnewbies"
            echo "4. sports"
            echo "5. bofh-excuses"
            echo "6. magic"
            echo "7. love"
            echo "8. literature"
            echo "9. drugs"
            echo "10. education"
            echo
            echo -n "Enter your choice, or 0 for exit: "
            read choice
            echo

            case $choice in
                1)
                    $FORTUNE politics
                    ;;
                2)
                    $FORTUNE startrek
                    ;;
                3)
                    $FORTUNE kernelnewbies
                    ;;
                4)
                    echo "Sports are a waste of time, energy and money."
                    echo "Go back to your keyboard."
                    echo -e "\t\t\t\t -- \"Unhealthy is my middle name\" Soggie."
                    ;;
                5)
                    $FORTUNE bofh-excuses
                    ;;
                6)
                    $FORTUNE magic
                    ;;
                7)
                    $FORTUNE love
                    ;;
                8)
                    $FORTUNE literature
                    ;;
                9)
                    $FORTUNE drugs
                    ;;
                10)
                    $FORTUNE education
                    ;;
                0)
                    echo "OK, see you!"
                    break
                    ;;
                *)
                    echo "That is not a valid choice, try a number from 0 to 10."
                    ;;
            esac

            ((loop_count++))  # Increment the loop counter
            if [ $loop_count -ge 3 ]; then
                echo "You have reached the maximum number of attempts. Goodbye!"
                break
            fi
        done
    ------------------------------------------------------------------------------------------------------

5.
    # Think of a better solution than move -b for the script to prevent overwriting of 
    # existing files. For instance, test whether or not a file exists. Don't do unnecessary work!

    # #!/bin/bash
    # # Script to convert filenames in the current directory to lowercase.

    # LIST=$(ls)  # Get the list of files in the current directory.

    # for FILE in $LIST; do
    #     # Skip files that are already in lowercase.
    #     if [[ $FILE != *[[:upper:]]* ]]; then
    #         continue
    #     fi

    #     ORIG="$FILE"                # Original filename.
    #     NEW=$(echo "$FILE" | tr A-Z a-z)  # Convert filename to lowercase.

    #     # Rename the file to its lowercase version.
    #     mv -b "$ORIG" "$NEW"

    #     echo "new name for $ORIG is $NEW"  # Inform the user about the change.
    # done

    ------------------------------------------------------------------------------------------------------
    #!/bin/bash
    # Script to convert filenames in the current directory to lowercase.

    # Loop through files in the current directory.
    for FILE in *; do
        # Skip directories and files that are already in lowercase.
        if [[ -d "$FILE" || $FILE != *[[:upper:]]* ]]; then
            continue
        fi

        ORIG="$FILE"                        # Original filename.
        NEW=$(echo "$FILE" | tr 'A-Z' 'a-z')  # Convert filename to lowercase.

        # Check if the target file already exists.
        if [[ -e "$NEW" ]]; then
            echo "File $NEW already exists. Skipping $ORIG."
            continue
        fi

        # Rename the file to its lowercase version.
        mv "$ORIG" "$NEW"

        echo "Renamed $ORIG to $NEW"  # Inform the user about the change.
    done
    ------------------------------------------------------------------------------------------------------
    Output:
        File test already exists. Skipping Test.
        or
        Renamed Test to test

6.
    # Rewrite the whichdaemon.sh script,so that it:

    # Prints a list of servers to check, such as Apache, the SSH server, the NTP daemon, a name
    # daemon, a power management daemon, and so on.
    
    # For each choice the user can make, print some sensible information, like the name of the web
    # server, NTP trace information, and so on.
    
    # Optionally, build in a possibility for users to check other servers than the ones listed. For such
    # cases, check that at least the given process is running.
    
    # Rebuild this script so that it prints a message if characters are given as input.

    #     #!/usr/bin/bash

    #     # Check if httpd is running
    #     if ps aux | grep -q "[h]ttpd"; then
    #         echo "This machine is running a web server."
    #     else
    #         echo "No web server (httpd) is running on this machine."
    #     fi

    #     # Check if init is running
    #     if ps aux | grep -q "[i]nit"; then
    #         echo "The init daemon is running on this machine."
    #     else
    #         echo "The init daemon is not running on this machine."
    #     fi

    ------------------------------------------------------------------------------------------------------
    #!/bin/bash

    # Function to check if a process is running
    check_daemon() {
        local daemon_name=$1
        if ps aux | grep -q "[${daemon_name:0:1}]${daemon_name:1}"; then
            echo "$daemon_name is running."
        else
            echo "$daemon_name is not running."
        fi
    }

    # Print the list of available services to check
    echo "Select a daemon to check or enter a custom process name:"
    echo "1. Apache (httpd)"
    echo "2. SSH (sshd)"
    echo "3. NTP (ntpd)"
    echo "4. Power Management (acpid)"
    echo "5. Custom Daemon"
    echo "0. Exit"
    echo

    # Read user choice
    read -p "Enter your choice (0-5): " choice

    # Function to print information for each daemon
    case $choice in
        1)
            echo "Checking Apache (httpd) service..."
            check_daemon "httpd"
            # Optionally, print more information about Apache
            if ps aux | grep -q "[h]ttpd"; then
                echo "Web server (Apache) is running."
                echo "Apache version:"
                apache2 -v 2>/dev/null || echo "Unable to get Apache version."
            fi
            ;;
        2)
            echo "Checking SSH (sshd) service..."
            check_daemon "sshd"
            # Optionally, print more information about SSH
            if ps aux | grep -q "[s]shd"; then
                echo "SSH server is running."
                echo "SSH version:"
                ssh -V 2>&1 | head -n 1 || echo "Unable to get SSH version."
            fi
            ;;
        3)
            echo "Checking NTP (ntpd) service..."
            check_daemon "ntpd"
            # Optionally, print more information about NTP
            if ps aux | grep -q "[n]tpd"; then
                echo "NTP server is running."
                echo "NTP trace information:"
                ntpq -p || echo "Unable to get NTP information."
            fi
            ;;
        4)
            echo "Checking Power Management (acpid) service..."
            check_daemon "acpid"
            # Optionally, print more information about Power Management
            if ps aux | grep -q "[a]cpid"; then
                echo "Power management daemon (acpid) is running."
            fi
            ;;
        5)
            # Ask for custom process
            read -p "Enter the name of the process you want to check: " custom_process
            if [[ -z "$custom_process" || "$custom_process" =~ [^a-zA-Z0-9_] ]]; then
                echo "Invalid input. Please enter a valid process name."
            else
                check_daemon "$custom_process"
            fi
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 0 and 5."
            ;;
    esac
    ------------------------------------------------------------------------------------------------------