# HELM
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "alpha"
  }
}


resource "helm_release" "microservices_chart" {
  name       = "shortlet-app-${terraform.workspace}"
  chart      = "../helm-chart"
  repository = ""   # Leave empty if using a local chart directory

  # Optionally, specify the chart version and other parameters
  # version = "1.0.0"

  values = [
    file("../helm-chart/values.yaml")
  ]

  depends_on = [
    module.gke,
    kubernetes_namespace.app_namespace
  ]
}
