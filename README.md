<!-- BEGIN_TF_DOCS -->
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.1 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.11, < 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.3 |
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.11, < 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloudfunctions2_function.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_storage_bucket.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [null_resource.dependent_files](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [archive_file.main](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [google_project.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_project.nums](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [null_data_source.wait_for_files](https://registry.terraform.io/providers/hashicorp/null/latest/docs/data-sources/data_source) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_traffic_on_latest_revision"></a> [all\_traffic\_on\_latest\_revision](#input\_all\_traffic\_on\_latest\_revision) | (Optional) Whether 100% of traffic is routed to the latest revision. Defaults to true. | `bool` | `true` | no |
| <a name="input_available_cpu"></a> [available\_cpu](#input\_available\_cpu) | (Optional) The number of CPUs used in a single container instance. Default value is calculated from available memory. | `string` | `""` | no |
| <a name="input_available_memory"></a> [available\_memory](#input\_available\_memory) | (Optional) The amount of memory available for a function. Defaults to 256M. Supported units are k, M, G, Mi, Gi. If no unit is supplied the value is interpreted as bytes. | `string` | `"256Mi"` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | When deleting the GCS bucket containing the cloud function, delete all objects in the bucket first. | `bool` | `false` | no |
| <a name="input_bucket_labels"></a> [bucket\_labels](#input\_bucket\_labels) | A set of key/value label pairs to assign to the function source archive bucket. | `map(string)` | `{}` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name to apply to the bucket. Will default to a string of the function name. | `string` | `""` | no |
| <a name="input_build_environment_variables"></a> [build\_environment\_variables](#input\_build\_environment\_variables) | A set of key/value environment variable pairs available during build time. | `map(string)` | `{}` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Whether to create a new bucket or use an existing one. If false, `bucket_name` should reference the name of the alternate bucket to use. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the function. | `string` | `"Processes events."` | no |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | The name of a method in the function source which will be invoked when the function is executed. | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A set of key/value environment variable pairs to assign to the function. | `map(string)` | `{}` | no |
| <a name="input_files_to_exclude_in_source_dir"></a> [files\_to\_exclude\_in\_source\_dir](#input\_files\_to\_exclude\_in\_source\_dir) | Specify files to ignore when reading the source\_dir | `list(string)` | `[]` | no |
| <a name="input_ingress_settings"></a> [ingress\_settings](#input\_ingress\_settings) | The ingress settings for the function. Allowed values are ALLOW\_ALL, ALLOW\_INTERNAL\_AND\_GCLB and ALLOW\_INTERNAL\_ONLY. Changes to this field will recreate the cloud function. | `string` | `"ALLOW_ALL"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Cloud Function. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location of this cloud function. | `string` | `""` | no |
| <a name="input_log_bucket"></a> [log\_bucket](#input\_log\_bucket) | Log bucket | `string` | `null` | no |
| <a name="input_log_object_prefix"></a> [log\_object\_prefix](#input\_log\_object\_prefix) | Log object prefix | `string` | `null` | no |
| <a name="input_max_instance_count"></a> [max\_instance\_count](#input\_max\_instance\_count) | (Optional) The limit on the maximum number of function instances that may coexist at a given time. | `number` | `100` | no |
| <a name="input_max_instance_request_concurrency"></a> [max\_instance\_request\_concurrency](#input\_max\_instance\_request\_concurrency) | (Optional) Sets the maximum number of concurrent requests that each instance can receive. Defaults to 1. | `number` | `1` | no |
| <a name="input_min_instance_count"></a> [min\_instance\_count](#input\_min\_instance\_count) | (Optional) The limit on the minimum number of function instances that may coexist at a given time. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to apply to any nameable resources. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project to which resources will be applied. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which resources will be applied. | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime in which the function will be executed. | `string` | n/a | yes |
| <a name="input_secret_environment_variables"></a> [secret\_environment\_variables](#input\_secret\_environment\_variables) | A list of maps which contains key, project\_id, secret\_name (not the full secret id) and version to assign to the function as a set of secret environment variables. | `list(map(string))` | `[]` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | The service account to run the function as. | `string` | `""` | no |
| <a name="input_source_dependent_files"></a> [source\_dependent\_files](#input\_source\_dependent\_files) | A list of any Terraform created `local_file`s that the module will wait for before creating the archive. | <pre>list(object({<br>    filename = string<br>    id       = string<br>  }))</pre> | `[]` | no |
| <a name="input_source_directory"></a> [source\_directory](#input\_source\_directory) | The pathname of the directory which contains the function source code. | `string` | n/a | yes |
| <a name="input_timeout_s"></a> [timeout\_s](#input\_timeout\_s) | The amount of time in seconds allotted for the execution of the function. | `number` | `60` | no |
| <a name="input_vpc_connector"></a> [vpc\_connector](#input\_vpc\_connector) | The VPC Network Connector that this cloud function can connect to. It should be set up as fully-qualified URI. The format of this field is projects/*/locations/*/connectors/*. | `string` | `null` | no |
| <a name="input_vpc_connector_egress_settings"></a> [vpc\_connector\_egress\_settings](#input\_vpc\_connector\_egress\_settings) | The egress settings for the connector, controlling what traffic is diverted through it. Allowed values are ALL\_TRAFFIC and PRIVATE\_RANGES\_ONLY. If unset, this field preserves the previously set value. | `string` | `"PRIVATE_RANGES_ONLY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function"></a> [function](#output\_function) | The google cloud function2. |
| <a name="output_name"></a> [name](#output\_name) | The name of the function. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://blackbird.cloud)
<!-- END_TF_DOCS -->