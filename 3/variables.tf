variable "gitlab_root_password" {
  type    = string
  default = "ALALALALALALALALLALALALALALALALALALALLALA"
  sensitive = true
}

variable "project" {
  default = "xenon-jetty-317519"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "cluster" {
  default = "tolstoy-kub"
}

variable "credentials" {
  default = "./key.json"
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}

variable "machine_type" {
  default = "e2-micro"
}

variable "app_name" {
  default = "gb"
}