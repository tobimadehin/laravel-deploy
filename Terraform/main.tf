resource "digitalocean_droplet" "my_droplet" {
    name      = "my-droplet"
    region    = "nyc3"
    size      = "s-1vcpu-1gb"
    image     = "ubuntu-20-04-x64"
    ssh_keys  = [digitalocean_ssh_key.my_ssh_key.id]
}

resource "digitalocean_ssh_key" "my_ssh_key" {
  name = "my_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}