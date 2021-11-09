
provider "yandex" {
  token     = "tokenid"
  cloud_id  = "b1gnn4plmft41oerklsa"
  folder_id = "b1g32bc6ughpds2k1k6o"
  zone      = "ru-central1-a"
}

locals {
    environment = terraform.workspace
}
resource "yandex_compute_instance" "vm-1" {
  name = "netology"
  platform_id  	 = lookup(var.web_platform_type_map, local.environment)
  count          = lookup(var.web_instance_count_map, local.environment)
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
lifecycle {
    create_before_destroy = true
  }
  boot_disk {
    initialize_params {
      image_id = "fd8urjqioepver7sq82o"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

#output "internal_ip_address_vm_1" {
#  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
#}

#output "external_ip_address_vm_1" {
#  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
#}