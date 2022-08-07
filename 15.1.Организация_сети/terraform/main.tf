terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "XXXXXXXXXXXXX"
  cloud_id  = "XXXXXXXXXXX"
  folder_id = "XXXXXXXXXX"
  zone      = "ru-central1-a"
}



resource "yandex_vpc_network" "netology-network" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "netology-subnet-ext" {
  name           = "netology-subnet-ext"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-network.id
}

resource "yandex_vpc_subnet" "netology-subnet-int" {
  name           = "netology-subnet-int"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-network.id
  route_table_id = yandex_vpc_route_table.netology-route.id
}

resource "yandex_vpc_route_table" "netology-route" {
  name       = "nat-route"
  network_id = yandex_vpc_network.netology-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}



resource "yandex_compute_instance" "netology-nat" {

  name = "netology-nat"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.netology-subnet-ext.id
    ip_address = "192.168.10.254"
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "netology-ext" {

  name = "netology-ext"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.netology-subnet-ext.id
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "netology-int" {

  name = "netology-int"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.netology-subnet-int.id
    nat        = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}