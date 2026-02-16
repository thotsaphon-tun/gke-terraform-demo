# Demo for create GKE auto-pilot cluster with terraform
The sample will create a subnet for GKE node.  
POD CIDR will be in non-RFC 1918 IP addresses range [https://docs.cloud.google.com/kubernetes-engine/docs/concepts/gke-ip-address-mgmt-strategies#reduce-private-ip-address-usage-in-gke] to reduce internal ip exhausted problem.  
Service CIDR will be default to '34.118.224.0/20' which is Google reserved public ip address, which can be shared across multiple cluster.

# Usage
```
terraform init
terraform plan
terraform apply
```

# Terminate
```
terraform destroy
```