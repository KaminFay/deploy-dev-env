
terraform {
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~>2.0"
      }
    }
}

provider "digitalocean" {
    token = var.do_token
}

module "servers" {
    source = "./../../modules/vm"
    // We want to spin up two of our dev machines to load whatever apps we need to onto
    count = 2
    provision = false

    image = var.image
    name = "${var.name}-backend-${count.index}"
    region = var.region
    size = var.size
    tags = ["Backend", "Application"]
    do_token = var.do_token
    domain_name = var.domain_name
}

module "loadbalancer" {
    source = "./../../modules/vm"
    provision = false

    image = var.image
    name = "${var.name}-lb"
    region = var.region
    size = var.size
    tags = ["Backend", "Loadbalancer"]
    do_token = var.do_token
    domain_name = var.domain_name
}