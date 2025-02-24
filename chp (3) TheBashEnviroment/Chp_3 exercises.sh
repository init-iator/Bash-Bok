#!/usr/bin/bash

# This script containes exercises for chapter 3

# Declare and set variables
VAR1="thirteen"
VAR2="13"
VAR3="Happy Birthday"

# Print variables
echo $VAR1 $VAR2 $VAR3

# Test if vars are global
typeset -p VAR1 VAR2 VAR3

# Remove VAR1
unset VAR1

# Print again

echo $VAR1 $VAR2 $VAR3
