1. Where is the bash program located on your system?
    $ which bash
    /usr/bin/bash

2. Use the --version option to find out which version you are running.
    $ bash --version
    GNU bash, version 5.2.32(1)-release (x86_64-pc-linux-gnu)
    Copyright (C) 2022 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

    This is free software; you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

3.  Which shell configuration files are read when you login to your system using the graphical user
    interface and then opening a terminal window?
    1. Graphical Login
        When you log in via the GUI (e.g., GNOME, KDE, etc.), the graphical display manager typically does not start a login shell. As a result:

        The system-wide shell initialization files for login shells (like /etc/profile) are not sourced.
        User-specific shell initialization files for login shells (like ~/.bash_profile or ~/.profile) are also not sourced at this stage.
    2. Opening a Terminal Window
        When you open a terminal window from the GUI, the behavior depends on how the terminal emulator is configured:

        a) Non-login Interactive Shell (Default Behavior)
        Most terminal emulators (e.g., GNOME Terminal, Konsole) open a non-login interactive shell by default. In this case:

        The shell reads non-login shell configuration files:
        For Bash:
        /etc/bashrc (or /etc/bash.bashrc on some systems) — if configured in /etc/profile or ~/.bashrc.
        ~/.bashrc — the user-specific configuration for interactive non-login shells.
        For Zsh:
        /etc/zshrc (system-wide).
        ~/.zshrc (user-specific).
        For other shells, the equivalent of .bashrc or .zshrc is sourced.
        b) Login Shell (Optional Configuration)
        If the terminal emulator is configured to start a login shell (e.g., by passing the --login flag), the following files are read:

        System-wide login shell configuration:
        /etc/profile
        Files sourced by /etc/profile (e.g., /etc/bashrc or /etc/bash.bashrc).
        User-specific login shell configuration:
        ~/.bash_profile, or if it doesn’t exist:
        ~/.bash_login, or if it doesn’t exist:
        ~/.profile
        Additionally, the interactive shell files (like ~/.bashrc for Bash) may be explicitly sourced by the login shell configuration (~/.bash_profile often sources ~/.bashrc).

        Summary of Configuration Files Read:
        Non-login interactive shell (default terminal window behavior):

        /etc/bashrc or /etc/bash.bashrc (if configured to be sourced).
        ~/.bashrc (Bash) or ~/.zshrc (Zsh).
        Login shell (optional, with terminal emulator configuration):

        /etc/profile
        ~/.bash_profile, ~/.bash_login, or ~/.profile
        May also source ~/.bashrc.

4. Are the following shells interactive shells? Are they login shells?

    A shell opened by clicking on the background of your graphical desktop, selecting "Terminal" or such from a menu:

    Interactive: Yes
    Login: No
    A shell that you get after issuing the command ssh localhost:

    Interactive: Yes
    Login: Yes
    A shell that you get when logging in to the console in text mode:

    Interactive: Yes
    Login: Yes
    A shell obtained by the command xterm &:

    Interactive: Yes
    Login: No
    A shell opened by the mysystem.sh script:

    Interactive: No
    Login: No
    A shell that you get on a remote host, for which you didn't have to give the login and/or password because you use SSH and maybe SSH keys:

    Interactive: Yes
    Login: Yes
    Key Notes:
    Interactive Shell: Allows direct input/output (e.g., via terminal or SSH session).
    Login Shell: Processes login-specific configuration files (like /etc/profile, ~/.bash_profile).

5. Can you explain why bash does not exit when you type Ctrl+C on the command line?

    1. No Running Foreground Process
    If no command or process is running in the foreground, Bash itself is not interrupted by Ctrl+C. Instead, Bash just ignores the signal at the command prompt and remains ready for input.
    2. Bash is a Shell, Not a Command
    Bash is a parent process that provides the environment for running commands. When you're at the command prompt, Bash isn't executing a specific task but waiting for user input. Sending SIGINT in this state doesn't terminate Bash because it’s not designed to.
    3. Signal Handling in Bash
    Bash has its own signal handling mechanisms. By default, Bash ignores SIGINT at the prompt to prevent accidental termination of the shell. This ensures that the shell session remains stable and responsive.
    4. How Bash Reacts to Ctrl+C
    If a foreground process (e.g., a running command like sleep or ping) is active, Ctrl+C sends SIGINT to terminate that process.
    Once the process ends, Bash regains control and displays the command prompt.
    Exiting Bash
    If you want to exit Bash, you can use:

    Ctrl+D (EOF - End of File)
    The exit command
    This behavior is by design, ensuring that Ctrl+C does not disrupt the shell itself when used inadvertently.

6. Display directory stack content.

    dirs -v

Example:
    $ pushd /tmp
    /tmp ~/Documents

    $ pushd /var
    /var /tmp ~/Documents

    $ dirs -v
    0  /var
    1  /tmp
    2  ~/Documents

7. set your prompt so that it displays your location in the file system hierarchy, for instance add this line to ~/.bashrc:

    1. Open your ~/.bashrc file:
        nano ~/.bashrc
    2. Add the following line to the file:
        export PS1="\u@\h \w> "
            Explanation of the components:
                \u: Displays the current username.
                \h: Displays the hostname (short version).
                \w: Displays the current working directory (full path).
                > : Adds a prompt symbol after the directory.
    3. Apply the changes: Run the following command to apply the changes to the current session:
        source ~/.bashrc

8. Display hashed commands for your current shell session.

    1. Use the hash command:
        The hash command shows the hashed commands in the current shell session. These are commands that the shell has cached to optimize repeated execution.

        Run the following command:
            hash
        Output Example:
            hit:  /usr/bin/ls
            hit:  /usr/bin/ping
        This shows the paths of commands that the shell has "hashed" for faster lookup. If you run a command in the shell, it gets cached in this hash table.

    2. Clear the hash table:
            hash -r
        This command will clear the cache and remove all the hashed commands from memory. After that, the shell will re-hash commands as they are run again.

9. How many processes are currently running on your system? Use ps and wc.

    ps aux | wc -l
    Explanation:
        ps aux: This command lists all running processes on the system, including processes from all users.
        wc -l: This counts the number of lines returned by the ps command, which corresponds to the number of processes. Each process is listed on a new line.
    Example Output:
    $ ps aux | wc -l
    100
    (This shows that there are 100 processes running on the system. Note that the number might include the header line, which is why you may subtract one if you want to count only the processes.)

    This subtracts 1 to exclude the header line.
    ps aux | wc -l | awk '{print $1-1}'

10. How to display the system hostname? Only the name, nothing more!

    $ hostname