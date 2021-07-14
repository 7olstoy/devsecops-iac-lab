
output "ip_gitlab" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
  description = "The Gitlab IP address"
}

output "cluster" {
  value = google_container_cluster.primary.name
}

output "host" {
  value     = google_container_cluster.primary.endpoint
  sensitive = true
}

output "cluster_ca_certificate" {
  value       = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  sensitive   = false
  description = "The k8s CA certificate"
}

output "username" {
  value     = google_container_cluster.primary.master_auth.0.username
  sensitive = false
}

output "password" {
  value     = google_container_cluster.primary.master_auth.0.password
  sensitive = true
}
