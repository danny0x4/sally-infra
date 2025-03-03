variable "project_id" {
    description = "Project ID from GCP"
    type = string
    default = "data-shard-444014-p9"
  
}

variable "region" {
    description = "Region for GCP resources"
    type = string
    default = "asia-southeast1"
}

variable "zone" {
    description = "Zone of GPC resources"
    type = string
    default = "asia-southeast1-a"
  
}

variable "cluster_name" {
    description = "Name of the cluster"
    type = string
    default = "sallystore-cluster"
  
}

variable "node_count" {
    description = "Number of nodes in the cluster"
    type = number
    default = 3 # High Availability for prod
  
}

