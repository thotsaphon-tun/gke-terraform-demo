module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 18.2"

  project_id = local.project_id

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "container.googleapis.com",
  ]
}