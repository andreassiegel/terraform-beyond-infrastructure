terraform {
  required_providers {
    outlook = {
      source = "magodo/outlook"
      version = "0.0.4"
    }
  }
}

provider "outlook" {
  auth_method       = "auth_code_flow"
  client_id         = var.client_id
  client_secret     = var.client_secret
}

data "outlook_mail_folder" "inbox" {
  well_known_name   = "inbox"
}

resource "outlook_mail_folder" "example" {
  name              = "SWKC"
  parent_folder_id  = data.outlook_mail_folder.inbox.id
}

resource "outlook_category" "example" {
  name              = "SWKC"
  color             = "Yellow"
}

resource "outlook_message_rule" "confluence" {
  name    = "[SWKC] Move Confluence Mails"
  enabled = true

  condition {
    from_addresses   = ["confluence@mail-eu.atlassian.net"]
    subject_contains = ["[Confluence] pentacor internal > Softwerkskammer"]
  }

  action {
    assign_categories = [outlook_category.example.name]
    move_to_folder    = outlook_mail_folder.example.id
    stop_processing_rules = true
  }
}

resource "outlook_message_rule" "meetup" {
  name    = "[SWKC] Move Meetup Mails"
  enabled = true

  condition {
    from_addresses   = ["info@meetup.com"]
    sender_contains  = ["Meetup", "Softwerkskammer Chemnitz"]
    body_contains    = ["Softwerkskammer Chemnitz"]
  }

  action {
    assign_categories = [outlook_category.example.name]
    move_to_folder    = outlook_mail_folder.example.id
    stop_processing_rules = true
  }
}

