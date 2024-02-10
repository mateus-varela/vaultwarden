variable "namespace" {
  description = "namespace where to deploy an application"
  type        = string
}

variable "app" {
  description = "an application to deploy"
  type        = map
}

variable "values" {
  description = "Extra values"
  type        = list(string)
  default     = []
}

variable "set" {
  description = "Value block with custom STRING values to be merged with the values yaml."
  # type = list(object({}))
  default = []
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  # type = list(object({}))
  default = []
}

variable "repository" {
  description = "Helm repository"
  type        = string
}

variable "traefik_chart_version" {
  description = "Version of Traefik chart to install"
  type        = string
  default     = "21.1.0" # See https://artifacthub.io/packages/helm/traefik/traefik for latest version(s)
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 
}

variable "replica_count" {
  description = "Number of replica pods to create"
  type        = number
  default     = 1
}

variable "values_file" {
  description = "The name of the traefik helmchart values file to use"
  type        = string
  default     = "values.yaml"
}