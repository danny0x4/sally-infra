resource "google_compute_router_nat" "nat" {
    name    = "nat"
    router = google_compute_router.router.name
    region = "asia-southeast1-a"

    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    nat_ip_allocate_option = "MANUAL_ONLY"

    subnetwork {
      name = google_compute_subnetwork.subnet.name
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  
  nat_ips = [google_compute_address.nat.self_link]
}