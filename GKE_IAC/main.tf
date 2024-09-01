# gke.tf
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}


module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = var.gke_name
  region                     = var.region
  zones                      = [var.zone]
  network                    = google_compute_network.vpc_network.name
  subnetwork                 = google_compute_subnetwork.subnetwork.name
  ip_range_pods              = "gke-pods-range"
  ip_range_services          = "gke-services-range"
  http_load_balancing        = var.negative
  network_policy             = var.negative
  horizontal_pod_autoscaling = var.positive
  filestore_csi_driver       = var.negative

  # typically in production environemnt there would be a bastion and private endpoint and nodes would be true
  enable_private_endpoint    = var.negative
  enable_private_nodes       = var.negative
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  dns_cache                  = var.negative
  deletion_protection        = var.negative # set to true tom prevent accidental deletion of cluster

  node_pools = [
    {
      name                        = var.nodepool_name
      machine_type                = var.machine_type
      disk_type                   = var.disk_type
      image_type                  = var.image_type
      node_locations              = var.zone
      min_count                   = var.min_count
      max_count                   = var.max_count
      local_ssd_count             = var.local_ssd_count
      spot                        = var.negative
      disk_size_gb                = var.disk_size_gb
      logging_variant             = "DEFAULT"
      auto_repair                 = var.positive
      auto_upgrade                = var.positive
      service_account             = google_service_account.gke_node_sa.email
    
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "alpha-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "alpha-default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "alpha-default-node-pool",
    ]
  }
}
