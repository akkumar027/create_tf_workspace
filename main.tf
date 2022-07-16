terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
    tfe = {
      version = "~> 0.33.0"
    }
  }
}

resource "github_repository" "repository" {
  count                   = length(var.repo_names)
  name                    = var.repo_names[count.index]
  organization            = "akkumar027"
  visibility              = "public"
  auto_init               = true
}

resource "github_branch" "development" {
  repository        = github_repository.repository.full_name
  branch            = "development"
}

resource "tfe_workspace" "workspace" {
  count                   = length(var.ad_group_names)
  name                    = var.workspace_names[count.index]
  organization            = "ak-learn-tf"
  speculative_enabled     = true
  identifier              = github_repository.repository.full_name
  oauth_token_id          = "ot-aNQYLytkGT4dd3Lr"
  tags                    = var.tag_names
}
