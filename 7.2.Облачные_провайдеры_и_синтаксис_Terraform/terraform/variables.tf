variable "web_platform_type_map" {
  type = map
  default = {
    "stage" = "standard-v1"
    "prod" = "standard-v2"
  }

}


variable "web_instance_count_map" {
  type = map
  default = {
    "stage" = 1
    "prod" = 2
  }
}
