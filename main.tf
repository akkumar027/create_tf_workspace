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
  count        = length(var.repo_names)
  name         = var.repo_names[count.index]
  visibility   = "public"
  auto_init    = true
}

resource "github_branch" "development" {
  count        = length(var.repo_names)
  repository = github_repository.repository[count.index].full_name
  branch     = "development"
}

resource "tfe_workspace" "workspace" {
  count               = length(var.repo_names)
  name                = var.repo_names[count.index]
  organization        = "ak-learn-tf"
  speculative_enabled = true
  vcs_repo {
    identifier     = github_repository.repository[count.index].full_name
    oauth_token_id = "ot-mXXzSCqaPqstMCLw"
  }
  tag_names           = [var.repo_names[count.index]]
}
resource "tfe_workspace" "workspace_dev" {
  count               = length(var.repo_names)
  name                = "${var.repo_names[count.index]}_dev"
  organization        = "ak-learn-tf"
  speculative_enabled = true
  vcs_repo {
    identifier     = github_repository.repository[count.index].full_name
    oauth_token_id = "ot-mXXzSCqaPqstMCLw"
  }
  tag_names           = concat([var.repo_names[count.index]], ["dev"])
}
