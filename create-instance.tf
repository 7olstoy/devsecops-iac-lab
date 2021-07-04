resource "google_compute_instance" "default" {
  name         = "homework-iac1"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = <<-EOF
sudo dnf update
sudo dnf install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo firewall-cmd --zone=public --add-service=http
echo '<!doctype html><html><body><h1>TERRAFORM on CENTOS 8!</h1></body></html>' > /var/www/html/index.html
EOF
    
  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
