output "name" {
  description = "The name of the function."
  value       = google_cloudfunctions2_function.main.name
}

output "function" {
  description = "The google cloud function2."
  value       = google_cloudfunctions2_function.main
}
