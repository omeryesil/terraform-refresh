#######################################################################################

#!/bin/bash

######################################################################################

# check if the az loged in.. 
$(pwd)/common.sh $1

echo "STATUS: " $?
if [ $? -eq 255 ]; then 
    exit 
fi

######################################################################################

# The Init command is used to initialize a working directory containing Terraform configuration files.
# This is the first command that should be run after writing a new Terraform configuration
terraform init $1

#The Get command is used to download and update modules mentioned in the root module.
terraform get $1

#The Apply command is used to create an execution plan
terraform apply -auto-approve $1 

######################################################################################