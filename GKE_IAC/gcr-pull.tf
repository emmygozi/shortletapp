resource "google_project_iam_member" "gcr_pull" {
  project = var.project_id
  for_each = toset([
    "roles/storage.objectViewer",
    "roles/artifactregistry.reader"
  ])
  role = each.key
   member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}