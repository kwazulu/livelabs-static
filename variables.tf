/*
******************************
Basic Configuration Details
******************************
*/

variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "region" {}
variable "availability_domain_name" {}
variable "ssh_public_key" {}


variable "instance_shape" {
  default = "VM.Standard2.4"
}

variable "instance_count" {
  default = 1
}

variable "instance_image_id" {
  # Replace this image ID as needed to point to the correct source in your tenant
  # default = "ocid1.image.oc1.phx.aaaaaaaaby7cfcthcyy2zacjultmmhckpti5sunk3wofwo64wvvfc3bf2zaa"
}
