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

resource "tfe_workspace" "test" {
  name           = "my-workspace-name"
  organization   = tfe_organization.test-organization.name
  agent_pool_id  = tfe_agent_pool.test-agent-pool.id
  execution_mode = "agent"
}
