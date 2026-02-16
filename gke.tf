locals {
  cluster_type           = "gke-autopilot"
  network_name           = "default2"
  subnet_name            = "node-subnet"
  pods_range_name        = "pod-subnet"
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/gke-autopilot-cluster"
  version = "~> 43.0"

  project_id = local.project_id
  name       = "poc-cluster"
  location   = local.region
  network    = local.network_name
  subnetwork = local.subnet_name

  ip_allocation_policy = {
    cluster_secondary_range_name  = local.pods_range_name
  }

  datapath_provider = "ADVANCED_DATAPATH"
  private_ipv6_google_access = "PRIVATE_IPV6_GOOGLE_ACCESS_UNSPECIFIED"

  private_cluster_config = {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.84.0.0/28"
    master_global_access_config = {
      enabled = true
    }
  }

  master_authorized_networks_config = null

  confidential_nodes = {
    enabled = true
  }

  workload_identity_config = null
}