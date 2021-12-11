terraform {
  required_providers {
    christmas-tree = {
      source = "cappyzawa/christmas-tree"
      version = "0.5.2"
    }
  }
}

provider "christmas-tree" {}

locals {
  file_name = "./christmas-tree.log"
}

resource "christmas-tree" "example" {
  path        = local.file_name
  ball_color  = "red"
  star_color  = "yellow"
  light_color = "white"

  provisioner "local-exec" {
    command = " echo '\n\n' && cat ${local.file_name} && echo '\n\n'"
  }
}
