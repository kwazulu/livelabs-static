
resource "oci_core_instance" "dbseclab" {
  count               = var.instance_count
  availability_domain = var.availability_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = "DBSec-Lab"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = var.ssh_public_key }

  create_vnic_details {
    assign_public_ip = true
    display_name     = "DBSec-Lab"
    hostname_label   = "dbsec-lab"
    private_ip       = "10.0.0.150"
    subnet_id        = oci_core_subnet.Public-Subnet-dbsec.id
  }

  source_details {
    source_id   = var.instance_image_id
    source_type = "image"
  }
}
