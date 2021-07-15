output "ip-web-1" {
  value = "${google_compute_instance.web-1.network_interface.0.access_config.0.nat_ip}"
}

output "ip-web-2" {
  value = "${google_compute_instance.web-2.network_interface.0.access_config.0.nat_ip}"
}

output "ip-web-ansible" {
  value = "${google_compute_instance.ansible.network_interface.0.access_config.0.nat_ip}"
}