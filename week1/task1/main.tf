module "cvm" {
  source     = "./modules/cvm"
  secret_id  = var.secret_id
  secret_key = var.secret_key
  password   = var.password
}

resource "terraform_data" "connect_cvm" {
  connection {
    host     = module.cvm.public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = var.password
  }

  triggers_replace = {
    script_hash = filemd5("${path.module}/docker.sh")
  }

  provisioner "file" {
    source      = "docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker.sh",
      "sh /tmp/docker.sh",
    ]
  }
}
