resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

  management {
    auto_repair = true
    auto_upgrade = true

  }
  autoscaling {
  min_node_count = 3 # for High Availability
  max_node_count = 6  # Depends your money
}
  

  node_config {
    preemptible = false
    machine_type = "e2-medium"
    disk_size_gb = 20
    disk_type = "pd-standard"

    labels = {
      role = "general"
    }


    service_account = google_service_account.kubernetes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_service_account" "kubernetes" {
    account_id = "devops"
  
}

resource "google_container_node_pool" "spot" {
    name = "spot"
    cluster = google_container_cluster.cluster.name

    management {
      auto_repair = true
      auto_upgrade = true
    }
  
  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }
  node_config {
    preemptible = true
    machine_type = "e2-small"
    disk_size_gb = 20

    labels = {
        team = "devops"
    }

    taint = [
      {
        key = "instance_type"
        value = "spot"
        effect = "NO_SCHEDULE"
      }
    ]
    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
