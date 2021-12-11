terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.18.2"
    }
  }
}

provider "github" {
  owner       = var.owner
  token       = var.token
}

resource "github_repository" "example" {
  name          = "terraform-beyond-infrastructure"
  description   = "Sample repository for the talk at the Softwerkskammer Chemnitz Pecha Kucha Night 2021"

  visibility    = "public"

  has_issues    = false
  has_projects  = false
  has_wiki      = false
  is_template   = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  auto_init              = true
  gitignore_template     = "Terraform"
  license_template       = "wtfpl"

  topics = ["terraform", "demo", "softwerskammer", "swkc"]
}

locals {
  default_branch_name = "develop"
}

resource "github_branch" "develop" {
  repository = github_repository.example.name
  branch     = local.default_branch_name
}

resource "github_branch_default" "default"{
  repository = github_repository.example.name
  branch     = github_branch.develop.branch
}

resource "github_branch_protection" "example" {
  repository_id    = github_repository.example.node_id

  pattern          = local.default_branch_name
  allows_deletions = false
  enforce_admins   = false

  required_status_checks {
    strict = true
  }
}
