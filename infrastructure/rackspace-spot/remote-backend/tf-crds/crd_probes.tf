resource "kubernetes_manifest" "customresourcedefinition_probes_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.13.0"
        "operator.prometheus.io/version" = "0.72.0"
      }
      "name" = "probes.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "Probe"
        "listKind" = "ProbeList"
        "plural" = "probes"
        "shortNames" = [
          "prb",
        ]
        "singular" = "probe"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "Probe defines monitoring for a set of static targets or ingresses."
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Specification of desired Ingress selection for target discovery by Prometheus."
                  "properties" = {
                    "authorization" = {
                      "description" = "Authorization section for this endpoint"
                      "properties" = {
                        "credentials" = {
                          "description" = "Selects a key of a Secret in the namespace that contains the credentials for authentication."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "type" = {
                          "description" = <<-EOT
                          Defines the authentication type. The value is case-insensitive. 
                           "Basic" is not a supported value. 
                           Default: "Bearer"
                          EOT
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "basicAuth" = {
                      "description" = "BasicAuth allow an endpoint to authenticate over basic authentication. More info: https://prometheus.io/docs/operating/configuration/#endpoint"
                      "properties" = {
                        "password" = {
                          "description" = "`password` specifies a key of a Secret containing the password for authentication."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "username" = {
                          "description" = "`username` specifies a key of a Secret containing the username for authentication."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                      }
                      "type" = "object"
                    }
                    "bearerTokenSecret" = {
                      "description" = "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the probe and accessible by the Prometheus Operator."
                      "properties" = {
                        "key" = {
                          "description" = "The key of the secret to select from.  Must be a valid secret key."
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                          "type" = "string"
                        }
                        "optional" = {
                          "description" = "Specify whether the Secret or its key must be defined"
                          "type" = "boolean"
                        }
                      }
                      "required" = [
                        "key",
                      ]
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
                    }
                    "interval" = {
                      "description" = "Interval at which targets are probed using the configured prober. If not specified Prometheus' global scrape interval is used."
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "jobName" = {
                      "description" = "The job name assigned to scraped metrics by default."
                      "type" = "string"
                    }
                    "keepDroppedTargets" = {
                      "description" = <<-EOT
                      Per-scrape limit on the number of targets dropped by relabeling that will be kept in memory. 0 means no limit. 
                       It requires Prometheus >= v2.47.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelLimit" = {
                      "description" = "Per-scrape limit on number of labels that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelNameLengthLimit" = {
                      "description" = "Per-scrape limit on length of labels name that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelValueLengthLimit" = {
                      "description" = "Per-scrape limit on length of labels value that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "metricRelabelings" = {
                      "description" = "MetricRelabelConfigs to apply to samples before ingestion."
                      "items" = {
                        "description" = <<-EOT
                        RelabelConfig allows dynamic rewriting of the label set for targets, alerts, scraped samples and remote write samples. 
                         More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                        EOT
                        "properties" = {
                          "action" = {
                            "default" = "replace"
                            "description" = <<-EOT
                            Action to perform based on the regex matching. 
                             `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0. `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0. 
                             Default: "Replace"
                            EOT
                            "enum" = [
                              "replace",
                              "Replace",
                              "keep",
                              "Keep",
                              "drop",
                              "Drop",
                              "hashmod",
                              "HashMod",
                              "labelmap",
                              "LabelMap",
                              "labeldrop",
                              "LabelDrop",
                              "labelkeep",
                              "LabelKeep",
                              "lowercase",
                              "Lowercase",
                              "uppercase",
                              "Uppercase",
                              "keepequal",
                              "KeepEqual",
                              "dropequal",
                              "DropEqual",
                            ]
                            "type" = "string"
                          }
                          "modulus" = {
                            "description" = <<-EOT
                            Modulus to take of the hash of the source label values. 
                             Only applicable when the action is `HashMod`.
                            EOT
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "regex" = {
                            "description" = "Regular expression against which the extracted value is matched."
                            "type" = "string"
                          }
                          "replacement" = {
                            "description" = <<-EOT
                            Replacement value against which a Replace action is performed if the regular expression matches. 
                             Regex capture groups are available.
                            EOT
                            "type" = "string"
                          }
                          "separator" = {
                            "description" = "Separator is the string between concatenated SourceLabels."
                            "type" = "string"
                          }
                          "sourceLabels" = {
                            "description" = "The source labels select values from existing labels. Their content is concatenated using the configured Separator and matched against the configured regular expression."
                            "items" = {
                              "description" = "LabelName is a valid Prometheus label name which may only contain ASCII letters, numbers, as well as underscores."
                              "pattern" = "^[a-zA-Z_][a-zA-Z0-9_]*$"
                              "type" = "string"
                            }
                            "type" = "array"
                          }
                          "targetLabel" = {
                            "description" = <<-EOT
                            Label to which the resulting string is written in a replacement. 
                             It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`, `KeepEqual` and `DropEqual` actions. 
                             Regex capture groups are available.
                            EOT
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "module" = {
                      "description" = "The module to use for probing specifying how to probe the target. Example module configuring in the blackbox exporter: https://github.com/prometheus/blackbox_exporter/blob/master/example.yml"
                      "type" = "string"
                    }
                    "oauth2" = {
                      "description" = "OAuth2 for the URL. Only valid in Prometheus versions 2.27.0 and newer."
                      "properties" = {
                        "clientId" = {
                          "description" = "`clientId` specifies a key of a Secret or ConfigMap containing the OAuth2 client's ID."
                          "properties" = {
                            "configMap" = {
                              "description" = "ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key to select."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "clientSecret" = {
                          "description" = "`clientSecret` specifies a key of a Secret containing the OAuth2 client's secret."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "endpointParams" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "`endpointParams` configures the HTTP parameters to append to the token URL."
                          "type" = "object"
                        }
                        "scopes" = {
                          "description" = "`scopes` defines the OAuth2 scopes used for the token request."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "tokenUrl" = {
                          "description" = "`tokenURL` configures the URL to fetch the token from."
                          "minLength" = 1
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "clientId",
                        "clientSecret",
                        "tokenUrl",
                      ]
                      "type" = "object"
                    }
                    "prober" = {
                      "description" = "Specification for the prober to use for probing targets. The prober.URL parameter is required. Targets cannot be probed if left empty."
                      "properties" = {
                        "path" = {
                          "default" = "/probe"
                          "description" = "Path to collect metrics from. Defaults to `/probe`."
                          "type" = "string"
                        }
                        "proxyUrl" = {
                          "description" = "Optional ProxyURL."
                          "type" = "string"
                        }
                        "scheme" = {
                          "description" = "HTTP scheme to use for scraping. `http` and `https` are the expected values unless you rewrite the `__scheme__` label via relabeling. If empty, Prometheus uses the default value `http`."
                          "enum" = [
                            "http",
                            "https",
                          ]
                          "type" = "string"
                        }
                        "url" = {
                          "description" = "Mandatory URL of the prober."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "url",
                      ]
                      "type" = "object"
                    }
                    "sampleLimit" = {
                      "description" = "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "scrapeClass" = {
                      "description" = "The scrape class to apply."
                      "minLength" = 1
                      "type" = "string"
                    }
                    "scrapeProtocols" = {
                      "description" = <<-EOT
                      `scrapeProtocols` defines the protocols to negotiate during a scrape. It tells clients the protocols supported by Prometheus in order of preference (from most to least preferred). 
                       If unset, Prometheus uses its default value. 
                       It requires Prometheus >= v2.49.0.
                      EOT
                      "items" = {
                        "description" = "ScrapeProtocol represents a protocol used by Prometheus for scraping metrics. Supported values are: * `OpenMetricsText0.0.1` * `OpenMetricsText1.0.0` * `PrometheusProto` * `PrometheusText0.0.4`"
                        "enum" = [
                          "PrometheusProto",
                          "OpenMetricsText0.0.1",
                          "OpenMetricsText1.0.0",
                          "PrometheusText0.0.4",
                        ]
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "scrapeTimeout" = {
                      "description" = "Timeout for scraping metrics from the Prometheus exporter. If not specified, the Prometheus global scrape timeout is used."
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "targetLimit" = {
                      "description" = "TargetLimit defines a limit on the number of scraped targets that will be accepted."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "targets" = {
                      "description" = "Targets defines a set of static or dynamically discovered targets to probe."
                      "properties" = {
                        "ingress" = {
                          "description" = "ingress defines the Ingress objects to probe and the relabeling configuration. If `staticConfig` is also defined, `staticConfig` takes precedence."
                          "properties" = {
                            "namespaceSelector" = {
                              "description" = "From which namespaces to select Ingress objects."
                              "properties" = {
                                "any" = {
                                  "description" = "Boolean describing whether all namespaces are selected in contrast to a list restricting them."
                                  "type" = "boolean"
                                }
                                "matchNames" = {
                                  "description" = "List of namespace names to select from."
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "relabelingConfigs" = {
                              "description" = "RelabelConfigs to apply to the label set of the target before it gets scraped. The original ingress address is available via the `__tmp_prometheus_ingress_address` label. It can be used to customize the probed URL. The original scrape job's name is available via the `__tmp_prometheus_job_name` label. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
                              "items" = {
                                "description" = <<-EOT
                                RelabelConfig allows dynamic rewriting of the label set for targets, alerts, scraped samples and remote write samples. 
                                 More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                                EOT
                                "properties" = {
                                  "action" = {
                                    "default" = "replace"
                                    "description" = <<-EOT
                                    Action to perform based on the regex matching. 
                                     `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0. `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0. 
                                     Default: "Replace"
                                    EOT
                                    "enum" = [
                                      "replace",
                                      "Replace",
                                      "keep",
                                      "Keep",
                                      "drop",
                                      "Drop",
                                      "hashmod",
                                      "HashMod",
                                      "labelmap",
                                      "LabelMap",
                                      "labeldrop",
                                      "LabelDrop",
                                      "labelkeep",
                                      "LabelKeep",
                                      "lowercase",
                                      "Lowercase",
                                      "uppercase",
                                      "Uppercase",
                                      "keepequal",
                                      "KeepEqual",
                                      "dropequal",
                                      "DropEqual",
                                    ]
                                    "type" = "string"
                                  }
                                  "modulus" = {
                                    "description" = <<-EOT
                                    Modulus to take of the hash of the source label values. 
                                     Only applicable when the action is `HashMod`.
                                    EOT
                                    "format" = "int64"
                                    "type" = "integer"
                                  }
                                  "regex" = {
                                    "description" = "Regular expression against which the extracted value is matched."
                                    "type" = "string"
                                  }
                                  "replacement" = {
                                    "description" = <<-EOT
                                    Replacement value against which a Replace action is performed if the regular expression matches. 
                                     Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                  "separator" = {
                                    "description" = "Separator is the string between concatenated SourceLabels."
                                    "type" = "string"
                                  }
                                  "sourceLabels" = {
                                    "description" = "The source labels select values from existing labels. Their content is concatenated using the configured Separator and matched against the configured regular expression."
                                    "items" = {
                                      "description" = "LabelName is a valid Prometheus label name which may only contain ASCII letters, numbers, as well as underscores."
                                      "pattern" = "^[a-zA-Z_][a-zA-Z0-9_]*$"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "targetLabel" = {
                                    "description" = <<-EOT
                                    Label to which the resulting string is written in a replacement. 
                                     It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`, `KeepEqual` and `DropEqual` actions. 
                                     Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "selector" = {
                              "description" = "Selector to select the Ingress objects."
                              "properties" = {
                                "matchExpressions" = {
                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                  "items" = {
                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                    "properties" = {
                                      "key" = {
                                        "description" = "key is the label key that the selector applies to."
                                        "type" = "string"
                                      }
                                      "operator" = {
                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                        "type" = "string"
                                      }
                                      "values" = {
                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "operator",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "matchLabels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                  "type" = "object"
                                }
                              }
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "staticConfig" = {
                          "description" = "staticConfig defines the static list of targets to probe and the relabeling configuration. If `ingress` is also defined, `staticConfig` takes precedence. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config."
                          "properties" = {
                            "labels" = {
                              "additionalProperties" = {
                                "type" = "string"
                              }
                              "description" = "Labels assigned to all metrics scraped from the targets."
                              "type" = "object"
                            }
                            "relabelingConfigs" = {
                              "description" = "RelabelConfigs to apply to the label set of the targets before it gets scraped. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
                              "items" = {
                                "description" = <<-EOT
                                RelabelConfig allows dynamic rewriting of the label set for targets, alerts, scraped samples and remote write samples. 
                                 More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                                EOT
                                "properties" = {
                                  "action" = {
                                    "default" = "replace"
                                    "description" = <<-EOT
                                    Action to perform based on the regex matching. 
                                     `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0. `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0. 
                                     Default: "Replace"
                                    EOT
                                    "enum" = [
                                      "replace",
                                      "Replace",
                                      "keep",
                                      "Keep",
                                      "drop",
                                      "Drop",
                                      "hashmod",
                                      "HashMod",
                                      "labelmap",
                                      "LabelMap",
                                      "labeldrop",
                                      "LabelDrop",
                                      "labelkeep",
                                      "LabelKeep",
                                      "lowercase",
                                      "Lowercase",
                                      "uppercase",
                                      "Uppercase",
                                      "keepequal",
                                      "KeepEqual",
                                      "dropequal",
                                      "DropEqual",
                                    ]
                                    "type" = "string"
                                  }
                                  "modulus" = {
                                    "description" = <<-EOT
                                    Modulus to take of the hash of the source label values. 
                                     Only applicable when the action is `HashMod`.
                                    EOT
                                    "format" = "int64"
                                    "type" = "integer"
                                  }
                                  "regex" = {
                                    "description" = "Regular expression against which the extracted value is matched."
                                    "type" = "string"
                                  }
                                  "replacement" = {
                                    "description" = <<-EOT
                                    Replacement value against which a Replace action is performed if the regular expression matches. 
                                     Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                  "separator" = {
                                    "description" = "Separator is the string between concatenated SourceLabels."
                                    "type" = "string"
                                  }
                                  "sourceLabels" = {
                                    "description" = "The source labels select values from existing labels. Their content is concatenated using the configured Separator and matched against the configured regular expression."
                                    "items" = {
                                      "description" = "LabelName is a valid Prometheus label name which may only contain ASCII letters, numbers, as well as underscores."
                                      "pattern" = "^[a-zA-Z_][a-zA-Z0-9_]*$"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "targetLabel" = {
                                    "description" = <<-EOT
                                    Label to which the resulting string is written in a replacement. 
                                     It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`, `KeepEqual` and `DropEqual` actions. 
                                     Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "static" = {
                              "description" = "The list of hosts to probe."
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "tlsConfig" = {
                      "description" = "TLS configuration to use when scraping the endpoint."
                      "properties" = {
                        "ca" = {
                          "description" = "Certificate authority used when verifying server certificates."
                          "properties" = {
                            "configMap" = {
                              "description" = "ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key to select."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "cert" = {
                          "description" = "Client certificate to present when doing client-authentication."
                          "properties" = {
                            "configMap" = {
                              "description" = "ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key to select."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "insecureSkipVerify" = {
                          "description" = "Disable target certificate validation."
                          "type" = "boolean"
                        }
                        "keySecret" = {
                          "description" = "Secret containing the client key file for the targets."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "serverName" = {
                          "description" = "Used to verify the hostname for the targets."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
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
