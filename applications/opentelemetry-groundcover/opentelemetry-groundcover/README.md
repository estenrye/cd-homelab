# Groundcover Metrics Mapping

## HostMetrics Receiver

### Host Metrics CPU Scraper

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_host_cpu_capacity_m_cpu | [system.cpu.logical.count](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpulogicalcount) | `scale_metric(1000.0)` | Number of logical CPU cores on the host in millicores. |
| groundcover_host_cpu_idle_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`idle`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["idle"], "idle")`</li><li>drop datapoints where `attributes["state"] != "idle"`</li></ul> | Percentage of CPU time spent idle |
| groundcover_host_cpu_idle_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `idle`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "idle"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["idle"], "idle")`</li></ul> | Total time spent idle |
| groundcover_host_cpu_interrupt_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`interrupt,softirq`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["interrupt", "softirq"], "interrupt")`</li><li>drop datapoints where `attributes["state"] != "interrupt"`</li></ul> | Percentage of CPU time spent handling interrupts |
| groundcover_host_cpu_iowait_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`wait`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["wait"], "wait")`</li><li>drop datapoints where `attributes["state"] != "wait"`</li></ul> | Percentage of CPU time spent waiting for I/O |
| groundcover_host_cpu_iowait_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `wait`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "wait"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["wait"], "wait")`</li></ul> | Total time spent waiting for I/O to complete |
| groundcover_host_cpu_irq_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `interrupt`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "interrupt"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["interrupt"], "interrupt")`</li></ul> | Total time spent handling hardware interrupts |
| groundcover_host_cpu_nice_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `nice`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "nice"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["nice"], "nice")`</li></ul> | Total time spent on niced processes |
| groundcover_host_cpu_num_cores | [system.cpu.logical.count](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpulogicalcount) | N/A | Number of CPU cores on the host |
| groundcover_host_cpu_softirq_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `softirq`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "softirq"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["softirq"], "softirq")`</li></ul> | Total time spent handling software interrupts |
| groundcover_host_cpu_steal_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `steal`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "steal"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["steal"], "steal")`</li></ul> | Total time spent in involuntary wait (stolen by hypervisor) |
| groundcover_host_cpu_stolen_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`steal`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["steal"], "steal")`</li><li>drop datapoints where `attributes["state"] != "steal"`</li></ul> | Percentage of CPU time stolen by the hypervisor |
| groundcover_host_cpu_system_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`system`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["system"], "system")`</li><li>drop datapoints where `attributes["state"] != "system"`</li></ul> | Percentage of CPU time spent in system mode |
| groundcover_host_cpu_system_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `system`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "system"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["system"], "system")`</li></ul> | Total time spent in system mode |
| groundcover_host_cpu_usage_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`interrupt,nice,softirq,steal,system,user,wait`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["interrupt", "nice", "softirq", "steal", "system", "user", "wait"], "usage")`</li><li>drop datapoints where `attributes["state"] != "usage"`</li></ul> | Percentage of used cpu in the current host |
| groundcover_host_cpu_usage_m_cpu | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`interrupt,nice,softirq,steal,system,user,wait`<br/>cpu: `*` | <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["interrupt", "nice", "softirq", "steal", "system", "user", "wait"], "usage")`</li><li>`scale_metric(1000.0, "")`</li><li>drop datapoints where `attributes["state"] != "usage"`</li></ul> | Cpu usage in the current host |
| groundcover_host_cpu_user_spent_percent | [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization)<br/>state:`user`<br/>cpu: `*` |  <ul><li>`delete_key(attributes, "cpu")`</li><li>`ggregate_on_attribute_value("sum", "state", ["user"], "user")`</li><li>drop datapoints where `attributes["state"] != "user"`</li></ul> | 
| groundcover_host_cpu_user_spent_seconds_total | [system.cpu.time](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcputime)<br/>state: `user`<br/>cpu: `*` | <ul><li>drop datapoints where `attributes["state"] != "user"`</li><li>`delete_key(attributes, "cpu")`</li><li>`aggregate_on_attribute_value("sum", "state", ["user"], "user")`</li></ul> |  Total time spent in user mode |

### Load Scraper Metrics

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_host_cpu_load_avg1 | [system.cpu.load_average.1m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average1m) | N/A | CPU load average over 1 minute
| groundcover_host_cpu_load_avg5 | [system.cpu.load_average.5m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average5m) | N/A | CPU load average over 5 minutes
| groundcover_host_cpu_load_avg15 | [system.cpu.load_average.15m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average15m) | N/A | CPU load average over 15 minutes
| groundcover_host_cpu_load_norm1 | <ul><li>[system.cpu.load_average.1m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average1m)</li><li>[system.cpu.logical.count](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpulogicalcount)</li></ul> | `system.cpu.load_average.1m / system.cpu.logical.count` | Normalized CPU load over 1 minute |
| groundcover_host_cpu_load_norm5 | <ul><li>[system.cpu.load_average.5m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average5m)</li><li>[system.cpu.logical.count](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpulogicalcount)</li></ul> | `system.cpu.load_average.5m / system.cpu.logical.count` | Normalized CPU load over 5 minutes |
| groundcover_host_cpu_load_norm15 | <ul><li>[system.cpu.load_average.15m](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md#systemcpuload_average15m)</li><li>[system.cpu.logical.count](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpulogicalcount)</li></ul> | `system.cpu.load_average.15m / system.cpu.logical.count` | Normalized CPU load over 15 minutes |

### Memory Scraper Metrics

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_host_mem_used_percent | [system.memory.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryutilization)<br/>state: `used` | <ul><li>drop datapoints where `attributes["state"] != "used"`</li><li>`scale_metric(100.0, "percent")`</li></ul> | Percentage of used memory in the current host |
| groundcover_host_mem_used_bytes | [system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `used` | drop datapoints where `attributes["state"] != "used"` | Memory used in the current host |
| groundcover_host_mem_free_bytes |[system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `free`| drop datapoints where `attributes["state"] != "free"` | Free memory in the current host |
| groundcover_host_mem_capacity_bytes | [system.memory.limit](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemorylimit) | N/A |  Memory capacity in the current host |
| groundcover_host_mem_buffers_bytes | [system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `buffered` | drop datapoints where `attributes["state"] != "buffered"`| Buffer memory in the current host |
| groundcover_host_mem_sreclaimable_bytes | [system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `slab_reclaimable` | drop datapoints where `attributes["state"] != "slab_reclaimable"` | Reclaimable slab memory in the current host |
| groundcover_host_mem_cached_bytes | [system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `cached` | drop datapoints where `attributes["state"] != "cached"` | Cached memory in the current host |
| groundcover_host_mem_available_bytes | [system.linux.memory.available](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemlinuxmemoryavailable) | N/A | Available memory in the current host |
| groundcover_host_mem_slab_bytes | [system.memory.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryusage)<br/> state: `slab` | drop datapoints where `attributes["state"] != "slab"`| Slab memory in the current host |

### Paging Scraper Metrics

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_host_mem_swap_used_bytes | [system.paging.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/pagingscraper/documentation.md#systempagingusage)<br/> state: `used` | drop datapoints where `attributes["state"] != "used"` | Used swap memory in the current host<br/><br/>Metric will not be emitted on hosts without swap enabled. |
| groundcover_host_mem_swap_free_bytes | [system.paging.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/pagingscraper/documentation.md#systempagingusage)<br/> state: `free` | drop datapoints where `attributes["state"] != "free"` | Free swap memory in the current host<br/><br/>Metric will not be emitted on hosts without swap enabled. |
| groundcover_host_mem_swap_total_bytes | [system.paging.usage](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/pagingscraper/documentation.md#systempagingusage)<br/> state: `free`, `used`, `cached` | <ul><li>`aggregate_on_attribute_value("sum", "state", ["free", "used", "cached"], "total")`</li><li>drop datapoints where `attributes["state"] != "total"`</li></ul> | Total swap memory in the current host <br/><br/>Metric will not be emitted on hosts without swap enabled.|

## Unmapped Metrics

### Groundcover Body Metrics (1 metric)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_body_size_bytes ||| Size of the request/response body |

### Groundcover Container Metrics (18 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_container_cpu_delay_seconds ||| K8s container CPU delay |
| groundcover_container_cpu_request_m_cpu ||| K8s container requested CPU allocation |
| groundcover_container_cpu_request_usage_percent ||| CPU usage rate out of request (usage/request) |
| groundcover_container_cpu_limit_m_cpu ||| K8s container CPU limit |
| groundcover_container_cpu_throttled_percent ||| Percentage of CPU throttling for the container |
| groundcover_container_cpu_throttled_seconds_total ||| Total CPU throttling time for K8s container |
| groundcover_container_cpu_usage_percent ||| CPU usage rate (usage/limit) |
| groundcover_container_cpu_usage_rate_millis ||| CPU usage rate |
| groundcover_container_crash_count ||| Total count of container crashes |
| groundcover_container_disk_delay_seconds ||| K8s container disk I/O delay |
| groundcover_container_m_cpu_usage_seconds_total ||| Total CPU usage time in milli-CPUs for the container |
| groundcover_container_mem_working_set_bytes | [container.memory.working_set](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/kubeletstatsreceiver/documentation.md#containermemoryworking_set) | N/A | Working set memory usage for the container |
| groundcover_container_memory_request_bytes ||| groundcover_container_memory_request_bytes |
| groundcover_container_memory_request_used_percent ||| Memory usage rate out of request (usage/request) |
| groundcover_container_memory_limit_bytes ||| K8s container memory limit |
| groundcover_container_memory_used_percent ||| Memory usage rate (usage/limit) |
| groundcover_container_memory_working_set_bytes | [container.memory.working_set](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/kubeletstatsreceiver/documentation.md#containermemoryworking_set) | N/A | Current memory working set |
| groundcover_container_memory_rss_bytes ||| Current memory resident set size (RSS) |

### Groundcover Host Metrics

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_host_cpu_guest_nice_spent_seconds_total |  |  | Total time spent running niced guest processes.<br/><br/>Need to Revisit this calculation.  Per [the HostMetircs scraper documentation](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md) there is no `guest` state.  Need to ask groundcover how this metric is captured. |
| groundcover_host_cpu_guest_spent_percent |  |  | Percentage of CPU time spent running guest processes.<br/><br/>Need to Revisit this calculation.  Per [system.cpu.utilization](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization) there is no `guest` state.  Need to ask groundcover how this metric is captured. |
| groundcover_host_cpu_guest_spent_seconds_total |  |  | Total time spent running guest processes<br/><br/>Need to Revisit this calculation.  Per [the HostMetircs scraper documentation](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md) there is no `guest` state.  Need to ask groundcover how this metric is captured. |
| groundcover_host_disk_read_time_ms_total ||| Total time spent reading from disk per device in the current host |
| groundcover_host_disk_read_time_ms_milliseconds_total ||||
| groundcover_host_disk_space_used_bytes ||| Used disk space in the current host |
| groundcover_host_disk_space_free_bytes ||| Free disk space in the current host |
| groundcover_host_disk_space_total_bytes ||| Total disk space in the current host |
| groundcover_host_disk_space_used_percent ||| Percentage of used disk space in the current host |
| groundcover_host_disk_write_time_ms_milliseconds_total ||||
| groundcover_host_disk_write_time_ms_total ||| Total time spent writing to disk per device in the current host |
| groundcover_host_fs_free_bytes ||| Free filesystem space in the current host |
| groundcover_host_fs_total_bytes ||| Total filesystem space in the current host |
| groundcover_host_fs_used_bytes ||| Used filesystem space in the current host |
| groundcover_host_fs_used_percent ||| Percentage of used filesystem space in the current host |
| groundcover_host_mem_commit_limit_bytes ||| Memory commit limit in the current host |
| groundcover_host_mem_committed_as_bytes ||| Committed address space memory in the current host |
| groundcover_host_mem_page_tables_bytes ||| Page tables memory in the current host |
| groundcover_host_mem_shared_bytes ||| Shared memory in the current host |
| groundcover_host_mem_swap_in_bytes | [system.paging.operations](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/pagingscraper/documentation.md#systempagingoperations)<br/>direction: `page_in`<br/>type: `*` |||
| groundcover_host_mem_swap_out_bytes | [system.paging.operations](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/pagingscraper/documentation.md#systempagingoperations)<br/>direction: `page_out`<br/>type: `*` |||
| groundcover_host_net_receive_bytes_total ||| Total bytes received on network interface |
| groundcover_host_net_receive_dropped_total ||| Total number of received packets dropped on network interface |
| groundcover_host_net_receive_errors_total ||| Total number of receive errors on network interface |
| groundcover_host_net_receive_packets_total ||| Total packets received on network interface |
| groundcover_host_net_transmit_bytes_total ||| Total bytes transmitted on network interface |
| groundcover_host_net_transmit_dropped_total ||| Total number of transmitted packets dropped on network interface |
| groundcover_host_net_transmit_errors_total ||| Total number of transmit errors on network interface |
| groundcover_host_net_transmit_packets_total ||| Total packets transmitted on network interface |
| groundcover_host_uptime_seconds ||| Uptime of the current host |

### Groundcover Kubernetes Metrics (80 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_kube_cronjob_status_active ||| Number of active CronJob executions |
| groundcover_kube_daemonset_status_current_number_scheduled ||| Number of Pods currently scheduled by the DaemonSet |
| groundcover_kube_daemonset_status_desired_number_scheduled ||| Desired number of Pods scheduled by the DaemonSet |
| groundcover_kube_daemonset_status_number_available ||| Number of available Pods for the DaemonSet |
| groundcover_kube_daemonset_status_number_misscheduled ||| Number of Pods running on nodes they should not be scheduled on |
| groundcover_kube_daemonset_status_number_ready ||| Number of ready Pods for the DaemonSet |
| groundcover_kube_daemonset_status_number_unavailable ||| Number of unavailable Pods for the DaemonSet |
| groundcover_kube_daemonset_status_observed_generation ||| Most recent generation observed for the DaemonSet |
| groundcover_kube_daemonset_status_updated_number_scheduled ||| Number of Pods updated and scheduled by the DaemonSet |
| groundcover_kube_deployment_metadata_generation ||| Sequence number representing a specific generation of the Deployment |
| groundcover_kube_deployment_spec_replicas ||| Desired number of replicas for the Deployment |
| groundcover_kube_deployment_status_condition ||| Current condition of the Deployment (labeled by type and status) |
| groundcover_kube_deployment_status_observed_generation ||| Most recent generation observed for the Deployment |
| groundcover_kube_deployment_status_replicas ||| Number of replicas for the Deployment |
| groundcover_kube_deployment_status_replicas_available ||| Number of available replicas for the Deployment |
| groundcover_kube_deployment_status_replicas_unavailable ||| Number of unavailable replicas for the Deployment |
| groundcover_kube_deployment_status_replicas_updated ||| Number of updated replicas for the Deployment |
| groundcover_kube_deployment_status_replicas_ready ||| Number of ready replicas for the Deployment |
| groundcover_kube_horizontalpodautoscaler_spec_min_replicas ||| Minimum number of replicas configured for the HPA |
| groundcover_kube_horizontalpodautoscaler_spec_max_replicas ||| Maximum number of replicas configured for the HPA |
| groundcover_kube_horizontalpodautoscaler_spec_target_metric ||| Configured HPA target metric value |
| groundcover_kube_horizontalpodautoscaler_status_condition ||| Current condition of the Horizontal Pod Autoscaler (labeled by type and status) |
| groundcover_kube_horizontalpodautoscaler_status_current_replicas ||| Current number of replicas managed by the HPA |
| groundcover_kube_horizontalpodautoscaler_status_desired_replicas ||| Desired number of replicas as calculated by the HPA |
| groundcover_kube_horizontalpodautoscaler_status_target_metric ||| Current observed value of the HPA target metric |
| groundcover_kube_job_complete ||| Whether the Job has completed successfully |
| groundcover_kube_job_failed ||| Whether the Job has failed |
| groundcover_kube_job_spec_completions ||| Desired number of successfully finished Pods for the Job |
| groundcover_kube_job_spec_parallelism ||| Desired number of Pods running in parallel for the Job |
| groundcover_kube_job_status_active ||| Number of actively running Pods for the Job |
| groundcover_kube_job_status_failed ||| Number of failed Pods for the Job |
| groundcover_kube_job_status_completion_time ||| Completion time of the Job as Unix timestamp |
| groundcover_kube_job_status_start_time ||| Start time of the Job as Unix timestamp |
| groundcover_kube_job_status_succeeded ||| Number of succeeded Pods for the Job |
| groundcover_kube_node_spec_taint ||| Node taint information (labeled by key, value and effect) |
| groundcover_kube_node_spec_unschedulable ||| Whether a node can schedule new pods |
| groundcover_kube_node_status_allocatable ||| The amount of resources allocatable for pods (after reserving some for system daemons) |
| groundcover_kube_node_status_capacity ||| The total amount of resources available for a node |
| groundcover_kube_node_status_condition ||| The condition of a cluster node |
| groundcover_kube_persistentvolume_capacity_bytes ||| Capacity of the PersistentVolume |
| groundcover_kube_persistentvolume_status_phase ||| Current phase of the PersistentVolume |
| groundcover_kube_persistentvolumeclaim_access_mode ||| Access mode of the PersistentVolumeClaim |
| groundcover_kube_persistentvolumeclaim_status_phase ||| Current phase of the PersistentVolumeClaim |
| groundcover_kube_pod_container_resource_limits ||| The number of requested limit resource by a container. It is recommended to use the `kube_pod_resource_limits` metric exposed by kube-scheduler instead, as it is more precise. |
| groundcover_kube_pod_container_resource_requests ||| The number of requested request resource by a container. It is recommended to use the `kube_pod_resource_requests` metric exposed by kube-scheduler instead, as it is more precise. |
| groundcover_kube_pod_container_status_last_terminated_exitcode ||| The last termination exit code for the container |
| groundcover_kube_pod_container_status_last_terminated_reason ||| The last termination reason for the container |
| groundcover_kube_pod_container_status_restarts_total ||| The number of container restarts per container |
| groundcover_kube_pod_container_status_ready ||| Describes whether the containers readiness check succeeded |
| groundcover_kube_pod_container_status_running ||| Describes whether the container is currently in running state |
| groundcover_kube_pod_container_status_terminated ||| Describes whether the container is currently in terminated state |
| groundcover_kube_pod_container_status_waiting ||| Describes whether the container is currently in waiting state |
| groundcover_kube_pod_container_status_waiting_reason ||| Describes the reason the container is currently in waiting state |
| groundcover_kube_pod_container_status_terminated_reason ||| Describes the reason the container is currently in terminated state |
| groundcover_kube_pod_init_container_resource_limits ||| The number of CPU cores requested limit by an init container |
| groundcover_kube_pod_init_container_resource_requests ||| Requested resources by init container (labeled by resource and unit) |
| groundcover_kube_pod_init_container_status_ready ||| Describes whether the init containers readiness check succeeded |
| groundcover_kube_pod_init_container_status_restarts_total ||| The number of restarts for the init container |
| groundcover_kube_pod_init_container_status_running ||| Describes whether the init container is currently in running state |
| groundcover_kube_pod_init_container_status_terminated ||| Describes whether the init container is currently in terminated state |
| groundcover_kube_pod_init_container_status_terminated_reason ||| Describes the reason the init container is currently in terminated state |
| groundcover_kube_pod_init_container_status_waiting ||| Describes whether the init container is currently in waiting state |
| groundcover_kube_pod_init_container_status_waiting_reason ||| Describes the reason the init container is currently in waiting state |
| groundcover_kube_pod_status_phase ||| The pods current phase |
| groundcover_kube_pod_status_ready ||| Describes whether the pod is ready to serve requests |*
| groundcover_kube_pod_status_scheduled ||| Describes the status of the scheduling process for the pod |
| groundcover_kube_replicaset_spec_replicas ||| Desired number of replicas for the ReplicaSet |
| groundcover_kube_replicaset_status_observed_generation ||| Most recent generation observed for the ReplicaSet |
| groundcover_kube_replicaset_status_ready_replicas ||| Number of ready replicas for the ReplicaSet |
| groundcover_kube_replicaset_status_replicas ||| Number of replicas for the ReplicaSet |
| groundcover_kube_statefulset_metadata_generation ||| Sequence number representing a specific generation of the StatefulSet |
| groundcover_kube_statefulset_replicas ||| Desired number of replicas for the StatefulSet |
| groundcover_kube_statefulset_status_current_revision ||| Current revision of the StatefulSet |
| groundcover_kube_statefulset_status_observed_generation ||| Most recent generation observed for the StatefulSet |
| groundcover_kube_statefulset_status_replicas ||| Number of replicas for the StatefulSet |
| groundcover_kube_statefulset_status_replicas_available ||| Number of available replicas for the StatefulSet |
| groundcover_kube_statefulset_status_replicas_current ||| Number of current replicas for the StatefulSet |
| groundcover_kube_statefulset_status_replicas_ready ||| Number of ready replicas for the StatefulSet |
| groundcover_kube_statefulset_status_replicas_updated ||| Number of updated replicas for the StatefulSet |
| groundcover_kube_statefulset_status_update_revision ||| Update revision of the StatefulSet |

### Groundcover Network Metrics (8 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_network_connections_closed_total ||| Total connections closed by the workload |
| groundcover_network_connections_opened_failed_total ||| Total number of failed network connection attempts by the workload |
| groundcover_network_connections_opened_refused_total ||| Total number of network connections refused by the workload |
| groundcover_network_connections_opened_total ||| groundcover_network_connections_opened_total |
| groundcover_network_rx_bytes_total ||| Total bytes received by the workload |
| groundcover_network_tx_bytes_total ||| Total bytes sent by the workload |
| groundcover_network_rx_ops_total ||| Total number of read operations issued by the workload |
| groundcover_network_tx_ops_total ||| Total number of write operations issued by the workload |

### Groundcover Node Metrics (33 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_node_allocatable_cpum_cpu ||| Allocatable CPU in the current node |
| groundcover_node_allocatable_mem_bytes ||| Allocatable memory in the current node |
| groundcover_node_capacity_cpum_cpu ||| Total CPU capacity in milli-CPUs for the node |
| groundcover_node_capacity_mem_bytes ||| Total memory capacity for the node |
| groundcover_node_disk_space_free_bytes ||| Free disk space for the node |
| groundcover_node_disk_space_total_bytes ||| Total disk space for the node |
| groundcover_node_disk_space_used_bytes ||| Used disk space for the node |
| groundcover_node_disk_space_used_percent ||| Percentage of disk space used for the node |
| groundcover_node_m_cpu_requests_total ||| Total CPU requests in milli-CPUs for the node |
| groundcover_node_m_cpu_limits_total ||| Total CPU limits in milli-CPUs for the node |
| groundcover_node_m_cpu_usage_seconds_total ||| Total CPU usage time in milli-CPUs for the node |
| groundcover_node_mem_limits_bytes ||| Total memory limits for the node |
| groundcover_node_mem_requests_bytes ||| Total memory requests for the node |
| groundcover_node_mem_used_percent ||| Percentage of used memory in the current node |
| groundcover_node_mem_working_set_bytes ||| Working set memory usage for the node |
| groundcover_node_rt_allocatable_cpum_cpu ||| Allocatable CPU in milli-CPUs for the node in real-time |
| groundcover_node_rt_allocatable_mem_bytes ||| Allocatable memory in real-time for the node |
| groundcover_node_rt_capacity_cpum_cpu ||| Total CPU capacity in milli-CPUs for the node in real-time |
| groundcover_node_rt_capacity_mem_bytes ||| Total memory capacity in real-time for the node |
| groundcover_node_rt_cpu_usage_percent ||| Real-time CPU usage in percent for the node |
| groundcover_node_rt_disk_space_free_bytes ||| Free disk space in real-time for the node |
| groundcover_node_rt_disk_space_total_bytes ||| Total disk space in real-time for the node |
| groundcover_node_rt_disk_space_used_bytes ||| Used disk space in real-time for the node |
| groundcover_node_rt_disk_space_used_percent ||| Percentage of disk space used in real-time for the node |
| groundcover_node_rt_m_cpu_limits_total ||| Total CPU limits in milli-CPUs for the node in real-time |
| groundcover_node_rt_m_cpu_requests_total ||| Total CPU requests in milli-CPUs for the node in real-time |
| groundcover_node_rt_m_cpu_total_workload_usage ||| Total workload CPU usage in milli-CPUs for the node in real-time |
| groundcover_node_rt_m_cpu_usage ||| Real-time CPU usage in milli-CPUs for the node |
| groundcover_node_rt_m_cpu_usage_seconds_total ||| Total CPU usage time in milli-CPUs for the node in real-time |
| groundcover_node_rt_mem_limits_bytes ||| Total memory limits in real-time for the node |
| groundcover_node_rt_mem_requests_bytes ||| Real-time memory requests for the node |
| groundcover_node_rt_mem_used_percent ||| Percentage of memory used in real-time for the node |
| groundcover_node_rt_mem_working_set_bytes ||| Working set memory usage in real-time for the node |

### Groundcover PVC Metrics (14 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_pvc_available_bytes ||| Available Persistent Volume Claim (PVC) space |
| groundcover_pvc_capacity_bytes ||| Persistent Volume Claim (PVC) capacity |
| groundcover_pvc_read_bytes_total ||| Total bytes read by the workload from the Persistent Volume Claim (PVC) |
| groundcover_pvc_read_latency_count ||| Count of read operations latency for the Persistent Volume Claim (PVC) |
| groundcover_pvc_read_latency_sum ||| Sum of read operation latencies for the Persistent Volume Claim (PVC) |
| groundcover_pvc_read_latency_summary ||| Summary of read operations latency for the Persistent Volume Claim (PVC) |
| groundcover_pvc_reads_total ||| Total read operations performed by the workload from the Persistent Volume Claim (PVC) |
| groundcover_pvc_usage_bytes ||| Persistent Volume Claim (PVC) usage |
| groundcover_pvc_usage_percent ||| Percentage of used Persistent Volume Claim (PVC) storage |
| groundcover_pvc_write_bytes_total ||| Total bytes written by the workload to the Persistent Volume Claim (PVC) |
| groundcover_pvc_write_latency_count ||| Count of write operations sampled for latency on the Persistent Volume Claim (PVC) |
| groundcover_pvc_write_latency_sum ||| Sum of write operation latencies for the Persistent Volume Claim (PVC) |
| groundcover_pvc_write_latency_summary ||| Summary of write operations latency for the Persistent Volume Claim (PVC) |
| groundcover_pvc_writes_total ||| Total write operations performed by the workload to the Persistent Volume Claim (PVC) |

### Groundcover Resource Metrics (5 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_resource_error_counter ||| Total resource requests with error status codes |
| groundcover_resource_issue_counter ||| Total resource requests flagged as issues |
| groundcover_resource_latency_seconds ||| Latency of resource requests |
| groundcover_resource_success_counter ||| Total resource requests with successful status codes |
| groundcover_resource_total_counter ||| Total resource requests |

### Groundcover Workload Metrics (6 metrics)

| Target Metric | Source Metric | Calculation | Notes |
| --- | --- | --- | --- |
| groundcover_workload_body_size_bytes ||| Size of the request/response body handled by the workload |
| groundcover_workload_error_counter ||| Total workload requests with error status codes |
| groundcover_workload_issue_counter ||| Total workload requests flagged as issues |
| groundcover_workload_latency_seconds ||| Latency across all workload APIs |
| groundcover_workload_success_counter ||| Total workload requests with successful status codes |
| groundcover_workload_total_counter ||| Total requests handled by the workload |
