# network.tf
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  network       = google_compute_network.vpc_network.id
  ip_cidr_range  = "10.0.0.0/24"
  region         = var.region

  secondary_ip_range {
    range_name    = "gke-pods-range"
    ip_cidr_range = "10.4.2.0/23"  # /25 gives you 128 addresses (126 usable)
  }


  secondary_ip_range {
    range_name    = "gke-services-range"
    ip_cidr_range = "10.4.1.0/24"  # /25 gives you 128 addresses (126 usable)
  }
}


resource "google_compute_router" "router" {
  name    = "shortlet-app-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}


resource "google_compute_router_nat" "nat" {
  name                               = "shortlet-app-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}



resource "google_compute_global_address" "nat_ip" {
  name         = "shortlet-app-nat-ip"
  address_type  = "EXTERNAL"
}
