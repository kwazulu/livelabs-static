resource "oci_core_vcn" "dbsec" {
  cidr_block     = "10.0.0.0/16"
  dns_label      = "dbsec"
  compartment_id = var.compartment_ocid
  display_name   = "dbsec"
}

resource "oci_core_internet_gateway" "Internet-Gateway-dbsec" {
  compartment_id = var.compartment_ocid
  display_name   = "Internet Gateway-dbsec"
  enabled        = "true"
  vcn_id         = oci_core_vcn.dbsec.id
}

resource "oci_core_default_route_table" "Default-Route-Table-for-dbsec" {
  manage_default_resource_id = oci_core_vcn.dbsec.default_route_table_id
  display_name               = "Default Route Table for dbsec"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.Internet-Gateway-dbsec.id
  }
}

resource "oci_core_default_security_list" "Default-Security-List-for-dbsec" {
  manage_default_resource_id = oci_core_vcn.dbsec.default_security_list_id
  display_name               = "Default Security List for dbsec"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  // allow outbound udp traffic on a port range
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "17"
    stateless   = true

    udp_options {
      min = 319
      max = 320
    }
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol  = "6"
    source    = "0.0.0.0/0"
    stateless = true

    tcp_options {
      min = 22
      max = 22
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      type = 3
      code = 4
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = "all"
    source    = "10.0.0.0/16"
    stateless = true
  }
}

resource "oci_core_subnet" "Public-Subnet-dbsec" {
  cidr_block        = "10.0.0.0/24"
  display_name      = "Public Subnet-dbsec"
  dns_label         = "pub"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.dbsec.id
  security_list_ids = [oci_core_vcn.dbsec.default_security_list_id]
  route_table_id    = oci_core_vcn.dbsec.default_route_table_id
  dhcp_options_id   = oci_core_vcn.dbsec.default_dhcp_options_id
}
