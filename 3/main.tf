terraform {
  required_version = "~>1.0.1"
  backend "remote" {
    organization = "GB-lab"
    workspaces {
      name = "iac_gke_cluster"
    }
  }
}

data "template_file" "startup_script" {
  template = "${file("./init.sh")}"
  vars = {
    gitlab_root_password = var.gitlab_root_password
  }
}

# Gitlab
resource "google_compute_instance" "default" {
  name         = "homework-iac3"
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

  metadata_startup_script = "${data.template_file.startup_script.rendered}"

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

# Open Gitlab to 80 port
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

# k8s
resource "google_container_cluster" "primary" {
  name               = var.cluster
  location           = var.zone
  initial_node_count = 3

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = var.app_name
    }

    tags = ["app", var.app_name]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

