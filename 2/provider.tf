provider "google" {
  credentials = file(var.credentials) 
  #Error: googleapi: Error 403: Project lookup error: permission denied on resource 'projects/var.project' (or it may not exist)., forbidden 
  #project = "var.project"
  project = "xenon-jetty-317519"
  region = "var.region"
}
