output "service_location" {
  value       = google_cloud_run_service.default.location
  description = "Location in which the Cloud Run service was created"
}