1.
#   Write a script that does the following:
# 	Display the name of the script being executed.

# 	Display the first, third and tenth argument given to the script.

# 	Display the total number of arguments passed to the script.

# 	If there were more than three positional parameters, use shift to move all the values 3 places
# 	to the left.

# 	Print all the values of the remaining arguments.

# 	Print the number of arguments.
# Test with zero, one, three and over ten arguments.
----------------------------------------------------------------------------
    #!/bin/bash

    # Display the name of the script being executed.
    echo "Script name: $0"

    # Display the first, third, and tenth argument.
    echo "First argument: ${1:-None}"
    echo "Third argument: ${3:-None}"
    echo "Tenth argument: ${10:-None}"

    # Display the total number of arguments passed to the script.
    TOTAL_ARGS=$#
    echo "Total number of arguments: $TOTAL_ARGS"

    # If more than three arguments are provided, shift 3 places left.
    if [ $TOTAL_ARGS -gt 3 ]; then
        echo "Shifting arguments by 3 positions..."
        shift 3
        echo "Remaining arguments after shift: $@"
    else
        echo "Less than or equal to 3 arguments provided, no shift applied."
    fi

    # Print the number of remaining arguments after the shift.
    echo "Number of remaining arguments: $#"
----------------------------------------------------------------------------
Test:
    ./argument_script.sh arg1 arg2 arg3 arg4 arg5 arg6 arg7 arg8 arg9 arg10 arg11
----------------------------------------------------------------------------

2.
    # Write a script that implements a simple web browser (in text mode), using wget and links -dump to
    # display HTML pages to the user. The user has 3 choices: enter a URL, enter b for back and q to quit.
    # The last 10 URLs entered by the user are stored in an array, from which the user can restore the URL
    # by using the back functionality.
----------------------------------------------------------------------------
    #!/bin/bash

    # Array to store the last 10 URLs
    history=()
    history_index=-1

    # Function to add URL to history
    add_to_history() {
        local url="$1"
        if [ ${#history[@]} -eq 10 ]; then
            history=(${history[@]:1})  # Remove the oldest URL if the history is full
        fi
        history+=("$url")
        history_index=${#history[@]}  # Set the index to the most recent URL
    }

    # Main browser loop
    while true; do
        echo -n "Enter a URL, 'b' for back, or 'q' to quit: "
        read choice

        if [ "$choice" == "q" ]; then
            echo "Quitting the browser."
            break
        elif [ "$choice" == "b" ]; then
            if [ $history_index -gt 0 ]; then
                ((history_index--))
                url=${history[$history_index]}
                echo "Loading: $url"
                links -dump "$url" | less
            else
                echo "No more history to go back to."
            fi
        elif [[ "$choice" =~ ^https?:// ]]; then
            url="$choice"
            echo "Loading: $url"
            add_to_history "$url"
            links -dump "$url" | less
        else
            echo "Invalid input. Please enter a valid URL, 'b' for back, or 'q' to quit."
        fi

    done
----------------------------------------------------------------------------