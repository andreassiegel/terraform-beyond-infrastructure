terraform {
  required_providers {
    spotify = {
      source = "conradludgate/spotify"
      version = "0.2.7"
    }
  }
}

provider "spotify" {
  api_key = var.api_key
}

data "spotify_search_track" "example" {
  name  = "Terraform"
}

resource "spotify_playlist" "playlist" {
  name        = "Softwerkskammer Chemnitz Terraform Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks      = data.spotify_search_track.example.tracks[*].id
}
