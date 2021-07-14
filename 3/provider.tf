provider "google" {
  credentials = "${file("./key.json")}"
  project = "xenon-jetty-317519"
  region = "us-central1"
}
