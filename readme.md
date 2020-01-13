# Terraform Refresh Knowledge

## Terraform file 

- main.tf 

```bash
provider "azurerm" {
}

variable "prefix" { default="mytest" }

resource "azurerm_resource_group" "main" {
	name = "${var.prefix}-resources"
	location = "East US"
}

# used only in terraform apply command 
output "virtual_machine_name" { value = "${azurerm_virtual_machine.main.name }" }
...
```

## Terraform Commands 

- **terraform init first_vm** 
  - Initializes terraform, also downloads the required providers, etc.. 

- **terraform plan first_vm** 
  - Checks what needs to be done.. no actual creation. Also, creates/updates the tfstate file 

- **terraform apply first_vm**
  - Applies the terraform infra request - creates/updates infra. 
  - **terraform apply -auto-approve first_vm**
    - This does not show interactive window (no need to type 'yes'...)

- **terraform destroy -auto-approve first_vm**
  - Destroys the infa

- **terraform get first_vm**
  - The Get command is used to download and update modules mentioned in the root module.

- **terraform destroy -target RESOURCE_NAME first_vm**
  - Can be applied to appy/destroy/plan   
  
  ``` bash
  terraform destroy -target azurerm_virtual_machine.main first_vm
   ``` 

## Variables 

```bash
varaible "name" {
    default = "DEFAULT_VALUE"
}

```

## Output 

- Only used when we call **terraform apply**

```bash
output "name" { value = "${resourceType.Name.Parameter}" }
```

- For array of resources 

```bash
output "virtual_machine_location" { value = "${azurerm_virtual_machine.main.*.location}" }
```

## Maps
- Key value pairs

```bash

variable "myTestMap" {
    type = "map"
    default = {
        "mykey1" : "myvalue1"
        "mykey2" : "myvalue2"
    }
}

resource "myResourceType" {
    name = "${var.myTestMap["mykey1"]}"
}
```

## Join

- Joins strings 

```bash 
output "myOutputName" {
    value = "${join(",", azurerm_virtual_machine.main.*.id)}"
}
```

## Depends On

```bash
resource "myResourceType" "myResourceName" {
    ...
}

# mySecondResourceName depends on myResourceType.myResourceName
resource "mySecondResourceType" "mySecondResourceName" {
    depends_on  = ["myResourceType.myResourceName"]

}

```

## Conditionals 

- CONDITION ? true : false 

```bash
variable "machine_type_PROD" { default = "Standard_DS1_V2" }
variable "machine_type_DEV" { default ="Standard_DS2_V2" }

variable "environment" { default ="development"}

resource "myresourcetype" "myresourcename" {
    name  = "${var.environment=="development"? var.machine_type_DEV : var.machine_type_PROD}"
}
```

## Debugging 
- Use environment variables 

  ```bash
  export TF_LOG=TRACE
  export TF_LOG_PATH=terraform.txt
  ```