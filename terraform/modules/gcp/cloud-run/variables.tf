variable "project_id" {
  description = "The project ID to deploy to."
  type        = string
}

variable "application_name" {
  description = "The name of the application."
  type        = string
}

variable "application_image" {
  description = "The image repository for the application."
  type        = string
}

variable "url" {
  description = "The custom URL for the cloud run application."
  type        = string
}

variable "region" {
  description = "The region for the deployment."
  type        = string
}