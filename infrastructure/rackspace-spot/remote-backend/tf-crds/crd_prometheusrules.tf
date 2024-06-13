resource "kubernetes_manifest" "customresourcedefinition_prometheusrules_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.14.0"
        "operator.prometheus.io/version" = "0.74.0"
      }
      "name" = "prometheusrules.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "PrometheusRule"
        "listKind" = "PrometheusRuleList"
        "plural" = "prometheusrules"
        "shortNames" = [
          "promrule",
        ]
        "singular" = "prometheusrule"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "PrometheusRule defines recording and alerting rules for a Prometheus instance"
              "properties" = {
                "apiVersion" = {
                  "description" = <<-EOT
                  APIVersion defines the versioned schema of this representation of an object.
                  Servers should convert recognized schemas to the latest internal value, and
                  may reject unrecognized values.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
                  EOT
                  "type" = "string"
                }
                "kind" = {
                  "description" = <<-EOT
                  Kind is a string value representing the REST resource this object represents.
                  Servers may infer this from the endpoint the client submits requests to.
                  Cannot be updated.
                  In CamelCase.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
                  EOT
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Specification of desired alerting rule definitions for Prometheus."
                  "properties" = {
                    "groups" = {
                      "description" = "Content of Prometheus rule file"
                      "items" = {
                        "description" = "RuleGroup is a list of sequentially evaluated recording and alerting rules."
                        "properties" = {
                          "interval" = {
                            "description" = "Interval determines how often rules in the group are evaluated."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "limit" = {
                            "description" = <<-EOT
                            Limit the number of alerts an alerting rule and series a recording
                            rule can produce.
                            Limit is supported starting with Prometheus >= 2.31 and Thanos Ruler >= 0.24.
                            EOT
                            "type" = "integer"
                          }
                          "name" = {
                            "description" = "Name of the rule group."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "partial_response_strategy" = {
                            "description" = <<-EOT
                            PartialResponseStrategy is only used by ThanosRuler and will
                            be ignored by Prometheus instances.
                            More info: https://github.com/thanos-io/thanos/blob/main/docs/components/rule.md#partial-response
                            EOT
                            "pattern" = "^(?i)(abort|warn)?$"
                            "type" = "string"
                          }
                          "rules" = {
                            "description" = "List of alerting and recording rules."
                            "items" = {
                              "description" = <<-EOT
                              Rule describes an alerting or recording rule
                              See Prometheus documentation: [alerting](https://www.prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) or [recording](https://www.prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules) rule
                              EOT
                              "properties" = {
                                "alert" = {
                                  "description" = <<-EOT
                                  Name of the alert. Must be a valid label value.
                                  Only one of `record` and `alert` must be set.
                                  EOT
                                  "type" = "string"
                                }
                                "annotations" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = <<-EOT
                                  Annotations to add to each alert.
                                  Only valid for alerting rules.
                                  EOT
                                  "type" = "object"
                                }
                                "expr" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "description" = "PromQL expression to evaluate."
                                  "x-kubernetes-int-or-string" = true
                                }
                                "for" = {
                                  "description" = "Alerts are considered firing once they have been returned for this long."
                                  "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                  "type" = "string"
                                }
                                "keep_firing_for" = {
                                  "description" = "KeepFiringFor defines how long an alert will continue firing after the condition that triggered it has cleared."
                                  "minLength" = 1
                                  "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                  "type" = "string"
                                }
                                "labels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "Labels to add or overwrite."
                                  "type" = "object"
                                }
                                "record" = {
                                  "description" = <<-EOT
                                  Name of the time series to output to. Must be a valid metric name.
                                  Only one of `record` and `alert` must be set.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "expr",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "name",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
        },
      ]
    }
  }
}
