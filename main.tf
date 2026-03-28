# Provider configuration
provider "google" {
  credentials = file("gcp-key.json")
  project     = "463290625255"  # Replace with your GCP project ID
  region      = "us-central1"
  zone        = "us-central1-a"
}

# Web Server VM Instance
resource "google_compute_instance" "web_server" {
  name         = "web-server-vm"
  machine_type = "e2-micro"  # Free tier eligible
  zone         = "us-central1-a"

  tags = ["web-server", "http-server"]

  labels = {
    environment = "production"
    purpose     = "web-hosting"
    managed_by  = "terraform"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10  # GB
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "<h1>Web Server deployed with Terraform!</h1>" > /var/www/html/index.html
    systemctl start nginx
    systemctl enable nginx
  EOF
}

# Storage bucket for static files
resource "google_storage_bucket" "web_static_files" {
  name          = "web-static-files-${random_id.bucket_suffix.hex}"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  labels = {
    environment = "production"
    purpose     = "static-content"
    managed_by  = "terraform"
  }
}

# Random ID for unique bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Firewall rule to allow HTTP traffic
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-web-server"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Output the VM's public IP
output "vm_public_ip" {
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
  description = "Public IP address of the web server"
}

# Output the bucket name
output "bucket_name" {
  value       = google_storage_bucket.web_static_files.name
  description = "Name of the storage bucket"
}