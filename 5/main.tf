# Apache host
resource "google_compute_instance" "web" {
  name         = "homework-iac5"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = file("./init.sh")
  
  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

# Open 80 port
resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform-lab5"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}