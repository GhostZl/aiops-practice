resource "helm_release" "crossplane" {
  depends_on       = [module.k3s, terraform_data.download_k3s_yaml]
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true
}
