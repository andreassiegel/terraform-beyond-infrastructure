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

resource "jira_project_category" "example" {
  name                  = "Managed"
  description           = "Managed Projects"
}

resource "jira_project" "example" {
  key                   = "SWKC"
  name                  = "Softwerkskammer Chemnitz"
  project_type_key      = "software"
  project_template_key  = "com.pyxis.greenhopper.jira:gh-simplified-agility-kanban"
  assignee_type         = "UNASSIGNED"
  category_id           = jira_project_category.example.id
}

resource "jira_filter" "example" {
  name                  = "${jira_project.example.key} Issues"
  jql                   = "project = ${jira_project.example.key}"

  description           = "All Issues in ${jira_project.example.key}"
  favourite             = false

  permissions {
    type        = "project"
    project_id  = jira_project.example.project_id
  }

  permissions {
    type        = "authenticated"
  }
}
