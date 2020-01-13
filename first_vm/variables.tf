

variable "vm_count" {
  default = ["server1"]
}

variable "vm_type" {
  type  ="map"
  default = {
      "dev" = "Standard_B2s"
      "staging" = "Standard_B2s" 
  }
}