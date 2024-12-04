#!/usr/bin/bash
# Script must run as sudo

echo "*************SEPARATOR************" 
#set -x
echo "*************SEPARATOR************" 
echo "*************SEPARATOR************"
echo "Users with bash as standard"
grep "/bin/bash$" /etc/passwd
echo
echo "*************SEPARATOR************"
echo "Lines in /etc/group starting as 'daemon':"
grep "^daemon" /etc/group
echo
echo "*************SEPARATOR************" 
echo "Lines in /etc/group not containing 'daemon':"
grep -v "daemon" /etc/group
echo 
echo "*************SEPARATOR************"
echo "Dispaly localhost information from the /etc/hosts file"
echo "Method1"
grep -n "localhost" /etc/hosts
grep -c "localhost" /etc/hosts
echo 
echo "Method2"
grep -n "localhost" /etc/hosts && grep -c "localhost" /etc/hosts
echo 
echo "Method3"
{ grep -n "localhost" /etc/hosts; grep -c "localhost" /etc/hosts; }
echo 
echo "*************SEPARATOR************"
echo "Display a list of /usr/share/doc subdirectories containing \
information about shells."
grep -rl "shell" /usr/share/doc/
grep -rl 'shell' /usr/share/doc | xargs -I {} dirname {} | uniq
echo 
echo "*************SEPARATOR************"
echo "How many README files do these subdirectories contain?"
find /usr/share/doc -type f -name "README" | wc -l
echo 
echo "*************SEPARATOR************"
echo "Make a list of files in your home directory \
that were changed less that 10 hours ago, using grep, but
leave out directories."
find ~ -maxdepth 1 -type f -mmin -600
echo
echo "*************SEPARATOR************" 
echo "This is script"
echo 
echo "*************SEPARATOR************"
echo "Can you find an alternative for wc -l, using grep?"
cd /usr/share/doc
grep -r "README" .
echo 
echo "*************SEPARATOR************"
echo "Using the file system table (/etc/fstab for instance), \
list local disk devices."
grep -E "^(UUID|/dev/sd)" /etc/fstab
sudo fdisk -l
echo
echo "*************SEPARATOR************" 
echo "Make a script that checks whether a user exists in /etc/passwd."
USER="username"
if grep -q "^$USER:" /etc/passwd; then
	echo "User $USER exists."
else
	echo "User $USER does not exists"
fi
echo 
echo "*************SEPARATOR************"
echo "Display configuration files in /etc that contain numbers in their names."
ls /etc | grep -E "[0-9].*\.(cnf|conf|cfg)$"
echo
echo "*************SEPARATOR************"
echo "Script Done"
echo
