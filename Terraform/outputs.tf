output "droplet_ip_address" {
  value = digitalocean_droplet.my_droplet.ipv4_address
}