1.  Create 3 variables, VAR1, VAR2 and VAR3; initialize them to hold the values "thirteen", "13" and \
    "Happy Birthday" respectively
        $ var1=thirteen
        $ var2=13
        $ var3=Happy Birthday
        $ echo $var1 $var2 $var3
        thirteen 13 Happy Birthday

3.  Are these local or global variables?\
        Global variables

4.  Remove var3
        $ unset var3

(6. 7. 8.)
    1. Edit /etc/profile for Greeting Users
        Add a greeting message for all users:
            # Display a greeting message to all users
            echo "Welcome, $USER! You are logged in to $(hostname) on $(date)."

        Customize prompt for root account:
            # Custom prompt for root
            if [ "$USER" == "root" ]; then
                PS1='\[\e[1;41m\]Danger!! root is doing stuff in \w\[\e[0m\] > '
            else
                PS1='\u@\h \w> '  # Default prompt for all users
            fi

    2. Test the Changes
        source /etc/profile

    3. Optional: Modify Prompt for Specific Users

        if [ "$USER" == "root" ]; then
            PS1='\[\e[1;41m\]Danger!! root is doing stuff in \w\[\e[0m\] > '
        elif [ "$USER" == "newuser" ]; then
            PS1='\[\e[1;32m\]Welcome, newuser! You are in \w\[\e[0m\] > '
        else
            PS1='\u@\h \w> '
        fi

9.
    nano rectangle_area.sh

    #!/bin/bash

    # rectangle_area.sh - A script to calculate the surface area of a rectangle.
    # It assigns values to two integer variables representing length and width,
    # calculates the surface area, and displays the result in a readable format.

    # Assigning integer values to the variables for length and width
    length=10
    width=5

    # Calculating the surface area of the rectangle
    area=$((length * width))

    # Generating elegant output to show the result
    echo "========================================"
    echo " Surface Area Calculation of a Rectangle"
    echo "========================================"
    echo "Length    : $length units"
    echo "Width     : $width units"
    echo "----------------------------------------"
    echo "Area      : $area square units"
    echo "========================================"

    # End of script








