resource "google_compute_instance" "jenkins_server" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["http-server", "https-server", "jenkins"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  # Output the IP for Ansible inventory
  provisioner "local-exec" {
    command = "echo '${self.name} ansible_host=${self.network_interface[0].access_config[0].nat_ip}' >> inventory"
  }
}

# Firewall rule for Jenkins and Nginx
resource "google_compute_firewall" "jenkins_firewall" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jenkins"]
}

output "jenkins_public_ip" {
  value = google_compute_instance.jenkins_server.network_interface[0].access_config[0].nat_ip
}