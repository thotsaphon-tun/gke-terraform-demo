module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 13.1"

    project_id   = local.project_id
    network_name = "default2"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "node-subnet"
            subnet_ip             = "10.83.0.0/24"
            subnet_region         = local.region
            subnet_private_access = "true"
        }
    ]

    secondary_ranges = {
        node-subnet = [
            {
                range_name    = "pod-subnet"
                ip_cidr_range = "100.64.0.0/16"
            }
        ]
    }

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        }
    ]
    depends_on = [ module.project-services ]
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 8.3"

  name    = "default"
  project_id = local.project_id
  region  = local.region
  network = module.vpc.network_name
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  project_id = local.project_id
  region     = local.region
  router     = module.cloud_router.router.name
}