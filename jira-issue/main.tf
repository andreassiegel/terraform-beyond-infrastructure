terraform {
  required_providers {
    jira = {
      source = "fourplusone/jira"
      version = "0.1.14"
    }
  }
}

provider "jira" {
  url         = var.url
  user        = var.user
  password    = var.password
}

resource "jira_issue" "example" {
  issue_type  = "Task"
  project_key = "PPR"
  summary     = "SWKC  - Pecha Kucha Night 2021 - Terraform beyond Infrastructure"
 
  description = "Showcase what Terraform can be used for, beyond the provisioning of cloud infrastructure"
}

resource "jira_comment" "example" {
  body = "This comment was created automatically using Terraform."
  issue_key = jira_issue.example.issue_key
}
