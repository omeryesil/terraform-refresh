#!/bin/bash


######################################################################################

# Export Path Variable
#export PATH=$PATH:/opt

######################################################################################

# If statement to ensure a user has provided a Terraform folder path
if [ -z "$1" ]; then
    echo ""
    echo "You have not provided a Terraform path."
    echo "SYNTAX = ./destroy.sh <PATH>"
    echo "EXAMPLE = ./destroy.sh terraform/instance"
    echo ""
    exit -1
fi

######################################################################################

if az account show > /dev/null 2>&1 ; then
    echo ""
    echo "--------------------------------------------------------------------------------------------"
    echo ""
    echo "You have successfully authenticated with Microsoft Azure."
    echo ""
    echo "--------------------------------------------------------------------------------------------"
else
    echo ""
    echo "--------------------------------------------------------------------------------------------"
    echo ""
    echo "Authentication failure."
    echo "Please run the following command on your command line to authenticate with Microsoft Azure."
    echo ""
    echo "az login"
    echo ""
    echo "--------------------------------------------------------------------------------------------"
    echo ""
    exit -1
fi

exit 0

