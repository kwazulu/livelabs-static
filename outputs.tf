/*
 * Copyright (c) 2020 Oracle and/or its affiliates. All rights reserved.
 */
output "instance_names" {
  value = ["${oci_core_instance.dbseclab.*.display_name}"]
}

output "instance_public_ips" {
  value = ["${oci_core_instance.dbseclab.*.public_ip}"]
}
