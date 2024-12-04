1.  Step 1: Create the awk script
    Save the following content into a file named convert_to_ldap.awk

        #!/usr/bin/awk -f

        # Convert lines in the format Username:Firstname:Lastname:Telephone number
        # into LDAP records.

        BEGIN {
            # Inform the user that processing has started
            print "Converting to LDAP format..."
        }

        # Process each input line
        {
            split($0, fields, ":")    # Split the line using ':' as the delimiter
            username = fields[1]
            firstname = fields[2]
            lastname = fields[3]
            telephone = fields[4]

            # Print the LDAP record
            print "dn: uid=" username ", dc=example, dc=com"
            print "cn: " firstname " " lastname
            print "sn: " lastname
            print "telephoneNumber: " telephone
            print ""  # Blank line between records
        }

        END {
            # Inform the user that processing is complete
            print "Conversion complete."
        }
    
    Step 2: Create a test file
        Create a file named test_records.txt with sample input lines:
            jdoe:John:Doe:123456789
            asmith:Alice:Smith:987654321
            bjohnson:Bob:Johnson:555123456

    Step 3: Run the script
        ./convert_to_ldap.awk test_records.txt

2.  
    Step 1: Command Line Execution

        systemctl status quota
        sudo repquota /home
        sudo repquota /
        
        If the Quota daemon is not running:
            sudo find /home -type f -exec du -h {} + | awk '{print $2, $1}' | sort -n -r | head -n 3
                find /home -type f — Finds all files in /home.
                du -h {} — Displays disk usage in human-readable format.
                awk '{print $2, $1}' — Reverses the columns to have the username first and disk space second.
                sort -n -r — Sorts by disk space in descending order.
                head -n 3 — Displays the top 3 users.
    
    Step 2: Creating the Bash Script
        ------------------------------------------------------------------------------------------------------------------
        #!/bin/bash

        # Define the directory to check (use /home or / if /home is not on a separate partition)
        DIRECTORY="/home"

        # Check if quota is available (quota daemon running)
        if systemctl is-active --quiet quota; then
            echo "Quota daemon is running. Checking disk usage using repquota..."
            sudo repquota "$DIRECTORY" | awk 'NR>2 {print $1, $3, $4}' | sort -n -k2 | tail -n 3
        else
            echo "Quota daemon is not running. Checking disk usage using find and du..."
            sudo find "$DIRECTORY" -type f -exec du -h {} + | awk '{print $2, $1}' | sort -n -r | head -n 3
        fi

        # Save the result to a temporary file
        RESULT_FILE="/tmp/top_users_disk_space.txt"
        {
            echo "Disk space usage for top users in $DIRECTORY"
            echo "---------------------------------------------"
            if systemctl is-active --quiet quota; then
                sudo repquota "$DIRECTORY" | awk 'NR>2 {print $1, $3, $4}' | sort -n -k2 | tail -n 3
            else
                sudo find "$DIRECTORY" -type f -exec du -h {} + | awk '{print $2, $1}' | sort -n -r | head -n 3
            fi
        } > "$RESULT_FILE"

        # Send the result via email
        MAIL_RECIPIENT="you@your_comp"
        mail -s "Disk space usage report for $DIRECTORY" "$MAIL_RECIPIENT" < "$RESULT_FILE"

        # Clean up the temporary file
        rm -f "$RESULT_FILE"
        ------------------------------------------------------------------------------------------------------------------
    Run
        ./top_users_disk_space.sh

3.  Create XML-style output from a Tab-separated list

    #!/bin/bash

    # Check if a file is provided as input
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <input_file>"
        exit 1
    fi

    input_file="$1"

    # Start the XML output
    echo "<users>"

    # Read the input file line by line
    while IFS=$'\t' read -r username firstname lastname phoneNumber; do
        # Skip the header (if present)
        if [ "$username" != "Username" ]; then
            # Start user entry
            echo "    <user>"
            echo "        <username>$username</username>"
            echo "        <firstname>$firstname</firstname>"
            echo "        <lastname>$lastname</lastname>"
            echo "        <phoneNumber>$phoneNumber</phoneNumber>"
            echo "    </user>"
        fi
    done < "$input_file"

    # End the XML output
    echo "</users>"

    Usage:
        ./tsv_to_xml.sh users.txt > output.xml