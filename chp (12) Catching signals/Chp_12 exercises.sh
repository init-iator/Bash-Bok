1.
# Create a script that writes a boot image to a diskette using the dd utility. If the user tries to interrupt
# the script using Ctrl+C, display a message that this action will make the diskette unusable.
------------------------------------------------------------------------------------------
#!/bin/bash

# Define the image file and diskette device
BOOT_IMAGE="boot.img"  # Replace with the actual path to your boot image
DISKETTE_DEVICE="/dev/fd0"  # Replace with the correct device path

# Function to handle Ctrl+C interruptions
trap_ctrlc() {
    echo -e "\nWARNING: Interrupting this process will make the diskette unusable!"
    exit 1
}

# Trap the SIGINT (Ctrl+C) signal
trap trap_ctrlc SIGINT

# Check if the boot image file exists
if [[ ! -f "$BOOT_IMAGE" ]]; then
    echo "Error: Boot image file '$BOOT_IMAGE' not found."
    exit 1
fi

# Confirm with the user
echo "This will write '$BOOT_IMAGE' to '$DISKETTE_DEVICE'."
echo "All data on the diskette will be overwritten."
read -p "Do you want to proceed? (yes/no): " response
if [[ "$response" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Write the boot image to the diskette
echo "Writing boot image to diskette..."
dd if="$BOOT_IMAGE" of="$DISKETTE_DEVICE" bs=512 status=progress

# Check if the operation was successful
if [[ $? -eq 0 ]]; then
    echo "Boot image successfully written to the diskette."
else
    echo "Error: Failed to write the boot image to the diskette."
fi
------------------------------------------------------------------------------------------

2.
# Write a script that automates the installation of a third-party package of your choice. The package
# must be downloaded from the Internet. It must be decompressed, unarchived and compiled if these
# actions are appropriate. Only the actual installation of the package should be uninterruptable.
------------------------------------------------------------------------------------------
#!/bin/bash

# Exit immediately if a command fails
set -e

# Define variables
PACKAGE_URL="https://github.com/htop-dev/htop/archive/refs/tags/3.2.2.tar.gz"
PACKAGE_NAME="htop"
TARBALL="${PACKAGE_NAME}-3.2.2.tar.gz"
EXTRACTED_DIR="${PACKAGE_NAME}-3.2.2"
INSTALL_DIR="/usr/local/bin"

# Check if user is root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Use sudo." >&2
  exit 1
fi

# Step 1: Download the package
if [[ ! -f "$TARBALL" ]]; then
  echo "Downloading $PACKAGE_NAME..."
  wget -q "$PACKAGE_URL" -O "$TARBALL"\else
  echo "Package tarball already exists, skipping download."
fi

# Step 2: Extract the tarball
if [[ ! -d "$EXTRACTED_DIR" ]]; then
  echo "Extracting $TARBALL..."
  tar -xf "$TARBALL"
else
  echo "Package already extracted, skipping extraction."
fi

# Step 3: Compile the package
cd "$EXTRACTED_DIR"
echo "Configuring $PACKAGE_NAME..."
./autogen.sh && ./configure

echo "Compiling $PACKAGE_NAME..."
make -j$(nproc)

# Step 4: Install the package (non-interruptible)
trap "echo 'Installation cannot be interrupted. Please wait until it finishes.'" SIGINT SIGTERM

echo "Installing $PACKAGE_NAME..."
make install

# Restore signal handling
trap - SIGINT SIGTERM

# Step 5: Verify the installation
if command -v htop &>/dev/null; then
  echo "$PACKAGE_NAME installed successfully."
else
  echo "Installation failed."
fi

# Cleanup
cd ..
echo "Cleaning up..."
rm -rf "$EXTRACTED_DIR"
rm -f "$TARBALL"

echo "Done!"
------------------------------------------------------------------------------------------