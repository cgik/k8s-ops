resource "google_cloud_run_service" "default" {
  name     = var.application_name
  location = var.region

  metadata {
    namespace = var.project_id
  }

  template {
    spec {
      containers {
        image = var.application_image
        ports {
          name = "http1"
          container_port = "3000"
          protocol = "TCP"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "default" {
  location = var.region
  name     = var.url

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = google_cloud_run_service.default.name
  }
}