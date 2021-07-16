# Apache 2 host 1
resource "google_compute_instance" "web-1" {
  name         = "homework-iac4-web1"
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

  metadata = {
    ssh-keys = "${var.ansible_user}:${var.ansible_pub_key}"
  }
  
  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

# Apache 2 host 2
resource "google_compute_instance" "web-2" {
  name         = "homework-iac4-web2"
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

  metadata = {
    ssh-keys = "${var.ansible_user}:${var.ansible_pub_key}"
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

# Ansible host
resource "google_compute_instance" "ansible" {
  name         = "homework-iac4-ansible"
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

  metadata_startup_script = templatefile("init.sh.tpl", {
    web-1              = "${google_compute_instance.web-1.network_interface.0.access_config.0.nat_ip}",
    web-2              = "${google_compute_instance.web-2.network_interface.0.access_config.0.nat_ip}",
    ansible_vault_pass = var.ansible_vault_pass
  })

}

# Open Gitlab to 80 port
resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform-lab4"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}