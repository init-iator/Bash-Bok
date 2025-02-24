1.
    # Add a function to your ~/.bashrc config file that automates the printing of man pages. The result
    # should be that you type something like printman <command>, upon which the first appropriate man
    # page rolls out of your printer. Check using a pseudo printer device for testing purposes.
    # As an extra, build in a possibility for the user to supply the section number of the man page he or she
    # wants to print
SVAR
Append /.bashrc file with
------------------------------------------------------------------------------------------------
printman() {
    # Kontrollera om katalogen ~/PDF finns
    mkdir -p "$HOME/PDF"

    if [ -z "$1" ]; then
        echo "Användning: printman <kommando> [sektion]"
        return 1
    fi

    local command=$1
    local section=$2
    local output_file="$HOME/PDF/man-${command}${section:+-sec-${section}}.pdf"

    # Kontrollera om man-sidan finns
    if [ -z "$section" ]; then
        man -w $command > /dev/null 2>&1
    else
        man -w $section $command > /dev/null 2>&1
    fi

    if [ $? -ne 0 ]; then
        echo "Ingen manual finns för '$command' i sektion '${section:-any}'."
        return 1
    fi

    # Kontrollera om filen redan existerar
    if [ -f "$output_file" ]; then
        echo "Filen $output_file finns redan. Ingen ny utskrift behövs."
        return 0
    fi

    # Generera PDF från man-sidan
    if [ -z "$section" ]; then
        man -t $command | ps2pdf - "$output_file" || { echo "Fel vid skapande av PDF-fil."; return 1; }
    else
        man -t $section $command | ps2pdf - "$output_file" || { echo "Fel vid skapande av PDF-fil."; return 1; }
    fi

    echo "PDF-fil skapad: $output_file"
}
------------------------------------------------------------------------------------------------
run: source ~/.bashrc
test: printman <command> <manual section>

2.
    # Create a subdirectory in your home directory in which you can store function definitions. Put a couple
    # of functions in that directory. Useful functions might be, amongs others, that you have the same
    # commands as on DOS or a commercial UNIX when working with Linux, or vice versa. These
    # functions should then be imported in your shell environment when ~/.bashrc is read.
SVAR
make folder with functions
run: mkdir -p ~/functions

Skapa några funktioner
Funktion 1: cls (för att rensa terminalen, som i DOS)
    echo 'function cls { clear }' > ~/functions/cls.sh
Funktion 2: dir (för att visa filer, likt DOS)
    echo 'function dir { ls -alh }' > ~/functions/dir.sh
Funktion 3: copy (för att kopiera filer, likt DOS)
    echo 'function copy { cp -r "$1" "$2" }' > ~/functions/copy.sh

Importera funktionerna i ~/.bashrc
    nano ~/.bashrc

Lägg till följande rad i slutet av filen för att importera alla funktioner från mappen ~/functions:
------------------------------------------------------------------------------------------------
    # Ladda in funktioner från ~/functions
    for f in ~/functions/*.sh; do
    source "$f"
    done
------------------------------------------------------------------------------------------------
source ~/.bashrc
test:
run    cls
run    dir
run    copy source.txt destination.txt