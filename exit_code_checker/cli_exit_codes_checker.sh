#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

declare -a components=( firefox sipp nautilus slack )


check_exit_code () {
    local color_for_correct=${GREEN}
    local color_for_incorrect=${RED}

    # Color inversion when checking incorrect option and exit code is equal to 1
    if [[ $1 -eq 1 ]] && [[ $2 = "error_is_correct" ]] 
    then
	    color_for_correct=${RED}
	    color_for_incorrect=${GREEN}
    fi

    if [[ $1 -eq 0 ]] 
    then
            echo -e "${color_for_correct}Exit code :$1 ${NC}"
    else
            echo -e "${color_for_incorrect}Exit code :$1 ${NC}"
    fi
}


for component in "${components[@]}"
do
    echo -e "${CYAN} ============================= Testing $component =============================${NC}"

    echo -e "${CYAN} Help output ${NC} ($component --help):"
    $component --help
    check_exit_code `echo $?`

    echo -e "${CYAN} Help output ${NC} ($component -h):"
    $component -h
    check_exit_code `echo $?`

    echo -e "${CYAN} Version output ${NC} ($component --version):"
    $component --version
    check_exit_code `echo $?`

    echo -e "${CYAN} Version output ${NC} ($component -v):"
    $component -v
    check_exit_code `echo $?`

    echo -e "${CYAN} Output on an invalid option ${NC} ($component --invalid-option):"
    $component --invalid-option
    check_exit_code `echo $?` "error_is_correct"
done
