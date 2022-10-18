# Global Config Options
log_level = "info"
buffer_period {
  min = "5s"
  max = "20s"
}

# Configures Consul-Terraform-Sync connection with a Consul agent to perform queries to the Consul catalog
consul {
  address = "consul-server:8500"
}

# Relays provider discovery and installation information to Terraform
driver "terraform" {
  log = true
  path = "/consul-terraform-sync/"
  required_providers {
    panos = {
      source = "PaloAltoNetworks/panos"
    }
  }
}

## Network Infrastructure Options

# Palo Alto Workflow Options
terraform_provider "panos" {
  alias = "panos1"
}

## Consul Terraform Sync Task Definitions

# A task is executed when any change to the defined services are detected in the Consul catalog
task {
  name = "DAG_Web_App"
  description = "Automate population of dynamic address group"
  module = "PaloAltoNetworks/dag-nia/panos"
  providers = ["panos.panos1"]
  services = ["web", "app", "dns"]
}
