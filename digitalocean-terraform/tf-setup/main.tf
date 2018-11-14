provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
}

# Create a new SSH key
resource "digitalocean_ssh_key" "key" {
  name       = "Terraform Example"
  public_key = "${file("./id_rsa.pub")}"
}

resource "digitalocean_droplet" "web" {
  ssh_keys           = ["${digitalocean_ssh_key.key.fingerprint}"]
  image              = "ubuntu-16-04-x64"
  region             = "${var.do_region}"
  size               = "s-1vcpu-1gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "nginx-web-ams3"
  tags   = ["${digitalocean_tag.web.id}"]

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx curl",
      # remove old index.html and replace with hello nginx
      "rm /var/www/html/index.nginx-debian.html",
      "curl -L https://gist.githubusercontent.com/chris-rock/f37445df2e3cffb86a988cc26998a501/raw/0b449f8f22b7c690d4025d5e4487895340642b89/index.html -o /var/www/html/index.html"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("./id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "digitalocean_droplet" "crown" {
  ssh_keys           = ["${digitalocean_ssh_key.key.fingerprint}"]
  image              = "ubuntu-16-04-x64"
  region             = "${var.do_region}"
  size               = "s-1vcpu-1gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "nginx-crown-ams3"
  tags   = ["${digitalocean_tag.web.id}"]

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx curl",
      # remove old index.html and replace with hello nginx
      "rm /var/www/html/index.nginx-debian.html",
      # with crown
      "curl -L https://gist.githubusercontent.com/chris-rock/1820008c1810e3da9d313198c2e58aa1/raw/733371932109aa14889130b15d70895c8172f98b/index.html -o /var/www/html/index.html"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("./id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }

  provisioner "inspec" {
    profiles = [
      "supermarket://dev-sec/linux-baseline",
      "supermarket://dev-sec/ssh-baseline",
    ]

    reporter {
      name = "cli"
    }

    connection {
      type     = "ssh"
      private_key = "${file("./id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }

    on_failure = "continue"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "digitalocean_tag" "web" {
  name = "inspec-web"
}

resource "digitalocean_certificate" "web" {
  name              = "nginx"
  type              = "custom"
  private_key       = "${file("./domain.key")}"
  leaf_certificate  = "${file("./domain.crt")}"
}

resource "digitalocean_loadbalancer" "public" {
  name = "loadbalancer-1"
  region = "${var.do_region}"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port = 443
    entry_protocol = "https"

    target_port = 80
    target_protocol = "http"

    certificate_id  = "${digitalocean_certificate.web.id}"
  }

  healthcheck {
    port = 80
    protocol = "tcp"
  }

  // use tags here
  droplet_tag = "${digitalocean_tag.web.id}"
  // droplet_ids = ["${digitalocean_droplet.web.id}"]
}

resource "digitalocean_firewall" "web" {
  name = "only-22-80-and-443"

  droplet_ids = ["${digitalocean_droplet.web.id}", "${digitalocean_droplet.crown.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["192.168.1.0/24"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "icmp"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "53"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "53"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "null_resource" "inspec" {
  // runs inspec profile against aws services
  provisioner "inspec" {
    profiles = [
      "../do-security-profile",
    ]

    target {
      backend = "digitalocean"
    }

    reporter {
      name = "cli"
    }

    // we allow failures for now
    on_failure = "continue"
  }
}