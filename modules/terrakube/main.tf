

resource "kubernetes_namespace" "terrakube" {
  metadata {
    name = "terrakube"
  }
  kind_cluster_config_path = var.kind_cluster_config_path
}

resource "kubernetes_secret" "terrakube_dex_github" {
  metadata {
    name      = "terrakube-dex-github"
    namespace = "terrakube"
  }

  data = {
    clientID     = var.github_oauth_client_id
    clientSecret = var.github_oauth_client_secret
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.terrakube
  ]
}

resource "helm_release" "terrakube" {
  name       = "terrakube"
  namespace  = kubernetes_namespace.terrakube.metadata[0].name
  repository = "https://terrakube-io.github.io/terrakube-helm-chart"
  chart      = "terrakube"
  version    = "3.27.6"

  create_namespace = false   # namespace already exists

  atomic           = true
  timeout          = 1200    # 20 min, safe for Airflow
  wait             = true
  wait_for_jobs    = true

  depends_on = [
    kubernetes_secret.terrakube_dex_github
  ]

  values = [
    file("${path.module}/terrakube-values.yaml")
  ]
}
