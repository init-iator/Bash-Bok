1. Display a list of all the users on your system who log in with the Bash shell as a default.
    grep '/bash' /etc/passwd | cut -d: -f1
        Explanation:
        grep '/bash' /etc/passwd: This searches the /etc/passwd file for any users with /bash in their default shell path (which includes /bin/bash or /usr/bin/bash).
        cut -d: -f1: This cuts the first field (username) from each line of the output, as the /etc/passwd file is colon-separated, and the first field is the username.

2. From the /etc/group directory, display all lines starting with the string "daemon".
    grep "^daemon" /etc/group
        Explanation:
        grep: The command used to search for text patterns in files.
        ^daemon: The caret (^) indicates that the string "daemon" should appear at the start of the line.
        /etc/group: The file to search within. This file contains group information for the system.

3. Print all the lines from the same file that don't contain the string.
    grep -v "daemon" /etc/group
        Explanation:
        grep: The command used to search for text patterns in files.
        -v: The option that inverts the match, meaning it will show lines that do not contain the specified pattern.
        "daemon": The string to exclude from the output.
        /etc/group: The file to search within.

4.  Display localhost information from the /etc/hosts file, display the line number(s) matching the
    search string and count the number of occurrences of the string.

    1. Display lines containing "localhost":
        grep "localhost" /etc/hosts

    2. Display line number(s) where "localhost" occurs:
        grep -n "localhost" /etc/hosts

    3. Count the number of occurrences of "localhost":
        grep -c "localhost" /etc/hosts

    Combined Command:
        grep -n "localhost" /etc/hosts && grep -c "localhost" /etc/hosts

    Explanation:
        grep "localhost" /etc/hosts: Displays all the lines containing "localhost".
        grep -n "localhost" /etc/hosts: Displays those lines along with their line numbers.
        grep -c "localhost" /etc/hosts: Displays the total count of lines that contain "localhost".
