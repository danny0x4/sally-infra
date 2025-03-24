variable "project_id" {
    description = "Project ID from GCP"
    type = string
    default = "eighth-strata-454614-d5"
  
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

variable "instance_name" {
    description = "Name of the instance"
    type = string
    default = "jenkins-instance"
  
}

variable "machine_type" {
    description = "Machine type for the instance"
    type = string
    default = "e2-medium"
}

variable "disk_size" {
    description = "Size of the disk for the instance"
    type = number
    default = 30
  
}

variable "ssh_user" {
    description = "Username for SSH"
    type = string
    default = "ubuntu"
  
}

variable "ssh_pub_key_file" {
    description = "Path to the public key file"
    type = string
    default = "/Users/dannyrestu/id_rsa.pub"
  
}