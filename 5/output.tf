output "ip_web" {
  value = "${google_compute_instance.web.network_interface.0.access_config.0.nat_ip}"
  description = "The Apache2 host IP address"
}