1.  Write a script using your favorite editor. The script should display the path to your homedirectory and \
    the terminal type that you are using. Additionally it shows all the services started up in runlevel 3 on \
    your system. (hint: use HOME, TERM and ls /etc/rc3.d/S*)
2.  Add comments in your script.
3.  Add information for the users of your script.
4.  Change permissions on your script so that you can run it.
5.  Run the script in normal mode and in debug mode. It should run without errors.
        chmod +x sys_info.sh


---------------------------------------------------------------------------------------------
    #!/bin/bash

    # sys_info.sh - A simple script to display system information.
    # It shows the home directory path, terminal type, and services running in runlevel 3.

    # Display the path to the home directory using the HOME environment variable
    echo "Home Directory: $HOME"

    # Display the terminal type using the TERM environment variable
    echo "Terminal Type: $TERM"

    # Display all the services started in runlevel 3 by listing files in /etc/rc3.d/S*
    echo "Services started in runlevel 3:"
    ls /etc/rc3.d/S* | sort

    # End of script
----------------------------------------------------------------------------------------------