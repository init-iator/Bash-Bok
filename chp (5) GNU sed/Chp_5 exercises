1.  Print a list of files in your scripts directory, ending in ".sh". Mind that you might have to unalias
    ls. Put the result in a temporary file

    unalias ls 2>/dev/null  # Ensure no aliases for ls are active
    ls ~/scripts/*.sh > /tmp/scripts_list.txt

    cat /tmp/scripts_list.txt

2.  Make a list of files in /usr/bin that have the letter "a" as the second character. Put the result in a
    temporary file.

    ls /usr/bin/?a* > /tmp/usr_bin_a_files.txt
        Explanation:
            ls /usr/bin/?a*:

            ?: Matches any single character.
            a: Specifies that the second character must be "a".
            *: Matches any subsequent characters in the filename.
            > /tmp/usr_bin_a_files.txt:

            Redirects the output to a temporary file located at /tmp/usr_bin_a_files.txt.
    Result:
        cat /tmp/usr_bin_a_files.txt

3.  Delete the first 3 lines of each temporary file.

    sed -i '1,3d' /tmp/*.txt
        Explanation:
            sed: A stream editor for filtering and transforming text.
            -i: Edits the files in place, modifying the original files directly.
            '1,3d': The command to delete lines 1 through 3 in each file.
                1,3: Specifies the range of lines (from line 1 to line 3).
                d: Deletes the specified lines.
            /tmp/*.txt: Specifies all .txt files in the /tmp directory as the target.

4.  Print to standard output only the lines containing the pattern "an".

    sed -n '/an/p' <file_name>
        Explanation:
            sed: Stream editor for filtering and transforming text.
            -n: Suppresses the default output (prevents sed from printing every line by default).
            /an/: The pattern to search for (in this case, an).
            p: Prints the lines that match the pattern.
            <file_name>: Replace with the name of your file.

5.  Create a file holding sed commands to perform the previous two tasks. Add an extra command to this
    file that adds a string like "*** This might have something to do with man and man pages ***" in the
    line preceding every occurence of the string "man". Check the results.

    nano commands.sed
        1, 3d
        /an/p
        /man/i\*** This might have something to do with man and man pages ***

6.  A long listing of the root directory, /, is used for input. Create a file holding sed commands that
    check for symbolic links and plain files. If a file is a symbolic link, precede it with a line like "--This
    is a symlink--". If the file is a plain file, add a string on the same line, adding a comment like "<---
    this is a plain file".

    nano commands.sed
        /^l/ i\--This is a symlink--
        /^-/ s/$/ <--- this is a plain file/

    uasge:
        sed -n -f commands.sed <file_name>

7.  Create a script that shows lines containing trailing white spaces from a file. This script should use a
    sed script and show sensible information to the user.

    Script: check_trailing_spaces.sh
        -----------------------------------------------------------------------------
        #!/bin/bash

        # Script to check for lines with trailing white spaces in a file using sed.
        # Usage: ./check_trailing_spaces.sh <file_name>

        # Ensure the user provides a file as an argument
        if [ $# -ne 1 ]; then
            echo "Usage: $0 <file_name>"
            exit 1
        fi

        file_name="$1"

        # Check if the file exists
        if [ ! -f "$file_name" ]; then
            echo "Error: File '$file_name' not found!"
            exit 1
        fi

        # Create a temporary sed script to find lines with trailing white spaces
        sed_script="/tmp/trailing_spaces.sed"

        cat << 'EOF' > "$sed_script"
        # Match lines with trailing white spaces and print them
        / \+$/p
        EOF

        # Use sed with the script to check for trailing white spaces
        echo "Checking for lines with trailing white spaces in '$file_name'..."
        echo "Lines with trailing white spaces:"
        sed -n -f "$sed_script" "$file_name"

        # Clean up
        rm -f "$sed_script"
        ---------------------------------------------------------------------------------
    Make it executable:
        chmod +x check_trailing_spaces.sh
    Run the script with a file as an argument:
        ./check_trailing_spaces.sh <file_name>