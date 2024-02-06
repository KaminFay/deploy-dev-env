terraform {
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~>2.0"
      }
    }
}

data "digitalocean_image" "dev-snapshot" {
    name = var.image
}


//Give us the option to provision with a file or some commands for
//any application based vms.
resource "digitalocean_droplet" "vm_provisioned" {
    count = var.provision ? 1 : 0
    image = data.digitalocean_image.dev-snapshot.image
    name = var.name
    region = var.region
    size = var.size
    tags = var.tags

    provisioner "file" {
     source = var.source_zip 
     destination = "/source/"
    }
}

// Create a resource that doesn't have any provisioning done
// This will likely only be used for LB but oh well
resource "digitalocean_droplet" "vm_unprovisioned" {
    count = var.provision ? 0 : 1
    image = data.digitalocean_image.dev-snapshot.image
    name = var.name
    region = var.region
    size = var.size
    tags = var.tags

}

resource "digitalocean_record" "www" {
    domain = var.domain_name
    type = "A"
    name = "@"
    value = var.provision ? digitalocean_droplet.vm_provisioned[0].ipv4_address : digitalocean_droplet.vm_unprovisioned[0].ipv4_address
}