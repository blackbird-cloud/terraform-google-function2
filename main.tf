locals {
  logging = var.log_bucket == null ? [] : [
    {
      log_bucket        = var.log_bucket
      log_object_prefix = var.log_object_prefix
    }
  ]
}

resource "null_resource" "dependent_files" {
  triggers = {
    for file in var.source_dependent_files :
    pathexpand(file.filename) => file.id
  }
}

data "null_data_source" "wait_for_files" {
  inputs = {
    dependent_files_id = null_resource.dependent_files.id
    source_dir         = pathexpand(var.source_directory)
  }
}

data "archive_file" "main" {
  type        = "zip"
  output_path = pathexpand("${var.source_directory}.zip")
  source_dir  = data.null_data_source.wait_for_files.outputs["source_dir"]
  excludes    = var.files_to_exclude_in_source_dir
}

resource "google_storage_bucket" "main" {
  count                       = var.create_bucket ? 1 : 0
  name                        = coalesce(var.bucket_name, var.name)
  force_destroy               = var.bucket_force_destroy
  location                    = var.region
  project                     = var.project_id
  storage_class               = "REGIONAL"
  labels                      = var.bucket_labels
  uniform_bucket_level_access = true

  dynamic "logging" {
    for_each = length(local.logging) == 0 ? [] : local.logging
    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = logging.value.log_object_prefix
    }
  }

}

resource "google_storage_bucket_object" "main" {
  name                = "${data.archive_file.main.output_md5}-${basename(data.archive_file.main.output_path)}"
  bucket              = var.create_bucket ? google_storage_bucket.main[0].name : var.bucket_name
  source              = data.archive_file.main.output_path
  content_disposition = "attachment"
  content_encoding    = "zip"
  content_type        = "application/zip"
}

data "google_project" "nums" {
  for_each   = toset(compact([for item in var.secret_environment_variables : lookup(item, "project_id", "")]))
  project_id = each.value
}

data "google_project" "default" {
  project_id = var.project_id
}

resource "google_cloudfunctions2_function" "main" {
  name        = var.name
  location    = var.location
  description = var.description
  labels      = var.labels
  project     = var.project_id

  build_config {
    runtime               = var.runtime
    entry_point           = var.entry_point
    environment_variables = var.build_environment_variables
    source {
      storage_source {
        bucket = var.create_bucket ? google_storage_bucket.main[0].name : var.bucket_name
        object = google_storage_bucket_object.main.name
      }
    }
  }

  service_config {
    max_instance_count               = var.max_instance_count
    min_instance_count               = var.min_instance_count
    available_memory                 = var.available_memory
    timeout_seconds                  = var.timeout_s
    max_instance_request_concurrency = var.max_instance_request_concurrency
    available_cpu                    = var.available_cpu
    environment_variables            = var.environment_variables
    ingress_settings                 = var.ingress_settings
    vpc_connector_egress_settings    = var.vpc_connector_egress_settings
    vpc_connector                    = var.vpc_connector
    all_traffic_on_latest_revision   = var.all_traffic_on_latest_revision
    service_account_email            = var.service_account_email
    dynamic "secret_environment_variables" {
      for_each = { for item in var.secret_environment_variables : item.key => item }

      content {
        key        = secret_environment_variables.value["key"]
        project_id = try(data.google_project.nums[secret_environment_variables.value["project_id"]].number, data.google_project.default.number)
        secret     = secret_environment_variables.value["secret_name"]
        version    = lookup(secret_environment_variables.value, "version", "latest")
      }
    }
  }
}
