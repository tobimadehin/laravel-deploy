output "droplet_ip_address" {
  value = [for droplet in digitalocean_droplet.my_droplet : droplet.id]
}