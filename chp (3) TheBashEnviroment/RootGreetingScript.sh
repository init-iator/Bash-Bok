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
