resource "google_compute_router" "router" {
    name = "router"
    region = "asia-southeast1-a"
    network = google_compute_network.vpc.id
  
}