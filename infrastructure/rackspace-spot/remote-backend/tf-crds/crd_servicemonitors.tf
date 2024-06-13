resource "kubernetes_manifest" "customresourcedefinition_servicemonitors_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.14.0"
        "operator.prometheus.io/version" = "0.74.0"
      }
      "name" = "servicemonitors.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "ServiceMonitor"
        "listKind" = "ServiceMonitorList"
        "plural" = "servicemonitors"
        "shortNames" = [
          "smon",
        ]
        "singular" = "servicemonitor"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "ServiceMonitor defines monitoring for a set of services."
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
                  "description" = <<-EOT
                  Specification of desired Service selection for target discovery by
                  Prometheus.
                  EOT
                  "properties" = {
                    "attachMetadata" = {
                      "description" = <<-EOT
                      `attachMetadata` defines additional metadata which is added to the
                      discovered targets.
                      
                      
                      It requires Prometheus >= v2.37.0.
                      EOT
                      "properties" = {
                        "node" = {
                          "description" = <<-EOT
                          When set to true, Prometheus must have the `get` permission on the
                          `Nodes` objects.
                          EOT
                          "type" = "boolean"
                        }
                      }
                      "type" = "object"
                    }
                    "bodySizeLimit" = {
                      "description" = <<-EOT
                      When defined, bodySizeLimit specifies a job level limit on the size
                      of uncompressed response body that will be accepted by Prometheus.
                      
                      
                      It requires Prometheus >= v2.28.0.
                      EOT
                      "pattern" = "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
                      "type" = "string"
                    }
                    "endpoints" = {
                      "description" = "List of endpoints part of this ServiceMonitor."
                      "items" = {
                        "description" = <<-EOT
                        Endpoint defines an endpoint serving Prometheus metrics to be scraped by
                        Prometheus.
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            `authorization` configures the Authorization header credentials to use when
                            scraping the target.
                            
                            
                            Cannot be set at the same time as `basicAuth`, or `oauth2`.
                            EOT
                            "properties" = {
                              "credentials" = {
                                "description" = "Selects a key of a Secret in the namespace that contains the credentials for authentication."
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = <<-EOT
                                    Name of the referent.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind, uid?
                                    EOT
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
                            "description" = <<-EOT
                            `basicAuth` configures the Basic Authentication credentials to use when
                            scraping the target.
                            
                            
                            Cannot be set at the same time as `authorization`, or `oauth2`.
                            EOT
                            "properties" = {
                              "password" = {
                                "description" = <<-EOT
                                `password` specifies a key of a Secret containing the password for
                                authentication.
                                EOT
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = <<-EOT
                                    Name of the referent.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind, uid?
                                    EOT
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
                                "description" = <<-EOT
                                `username` specifies a key of a Secret containing the username for
                                authentication.
                                EOT
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = <<-EOT
                                    Name of the referent.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind, uid?
                                    EOT
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
                          "bearerTokenFile" = {
                            "description" = <<-EOT
                            File to read bearer token for scraping the target.
                            
                            
                            Deprecated: use `authorization` instead.
                            EOT
                            "type" = "string"
                          }
                          "bearerTokenSecret" = {
                            "description" = <<-EOT
                            `bearerTokenSecret` specifies a key of a Secret containing the bearer
                            token for scraping targets. The secret needs to be in the same namespace
                            as the ServiceMonitor object and readable by the Prometheus Operator.
                            
                            
                            Deprecated: use `authorization` instead.
                            EOT
                            "properties" = {
                              "key" = {
                                "description" = "The key of the secret to select from.  Must be a valid secret key."
                                "type" = "string"
                              }
                              "name" = {
                                "description" = <<-EOT
                                Name of the referent.
                                More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                TODO: Add other useful fields. apiVersion, kind, uid?
                                EOT
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
                          "enableHttp2" = {
                            "description" = "`enableHttp2` can be used to disable HTTP2 when scraping the target."
                            "type" = "boolean"
                          }
                          "filterRunning" = {
                            "description" = <<-EOT
                            When true, the pods which are not running (e.g. either in Failed or
                            Succeeded state) are dropped during the target discovery.
                            
                            
                            If unset, the filtering is enabled.
                            
                            
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase
                            EOT
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = <<-EOT
                            `followRedirects` defines whether the scrape requests should follow HTTP
                            3xx redirects.
                            EOT
                            "type" = "boolean"
                          }
                          "honorLabels" = {
                            "description" = <<-EOT
                            When true, `honorLabels` preserves the metric's labels when they collide
                            with the target's labels.
                            EOT
                            "type" = "boolean"
                          }
                          "honorTimestamps" = {
                            "description" = <<-EOT
                            `honorTimestamps` controls whether Prometheus preserves the timestamps
                            when exposed by the target.
                            EOT
                            "type" = "boolean"
                          }
                          "interval" = {
                            "description" = <<-EOT
                            Interval at which Prometheus scrapes the metrics from the target.
                            
                            
                            If empty, Prometheus uses the global scrape interval.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "metricRelabelings" = {
                            "description" = <<-EOT
                            `metricRelabelings` configures the relabeling rules to apply to the
                            samples before ingestion.
                            EOT
                            "items" = {
                              "description" = <<-EOT
                              RelabelConfig allows dynamic rewriting of the label set for targets, alerts,
                              scraped samples and remote write samples.
                              
                              
                              More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                              EOT
                              "properties" = {
                                "action" = {
                                  "default" = "replace"
                                  "description" = <<-EOT
                                  Action to perform based on the regex matching.
                                  
                                  
                                  `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
                                  `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.
                                  
                                  
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
                                  Replacement value against which a Replace action is performed if the
                                  regular expression matches.
                                  
                                  
                                  Regex capture groups are available.
                                  EOT
                                  "type" = "string"
                                }
                                "separator" = {
                                  "description" = "Separator is the string between concatenated SourceLabels."
                                  "type" = "string"
                                }
                                "sourceLabels" = {
                                  "description" = <<-EOT
                                  The source labels select values from existing labels. Their content is
                                  concatenated using the configured Separator and matched against the
                                  configured regular expression.
                                  EOT
                                  "items" = {
                                    "description" = <<-EOT
                                    LabelName is a valid Prometheus label name which may only contain ASCII
                                    letters, numbers, as well as underscores.
                                    EOT
                                    "pattern" = "^[a-zA-Z_][a-zA-Z0-9_]*$"
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "targetLabel" = {
                                  "description" = <<-EOT
                                  Label to which the resulting string is written in a replacement.
                                  
                                  
                                  It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
                                  `KeepEqual` and `DropEqual` actions.
                                  
                                  
                                  Regex capture groups are available.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "oauth2" = {
                            "description" = <<-EOT
                            `oauth2` configures the OAuth2 settings to use when scraping the target.
                            
                            
                            It requires Prometheus >= 2.27.0.
                            
                            
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
                            EOT
                            "properties" = {
                              "clientId" = {
                                "description" = <<-EOT
                                `clientId` specifies a key of a Secret or ConfigMap containing the
                                OAuth2 client's ID.
                                EOT
                                "properties" = {
                                  "configMap" = {
                                    "description" = "ConfigMap containing data to use for the targets."
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key to select."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                                "description" = <<-EOT
                                `clientSecret` specifies a key of a Secret containing the OAuth2
                                client's secret.
                                EOT
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = <<-EOT
                                    Name of the referent.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind, uid?
                                    EOT
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
                                "description" = <<-EOT
                                `endpointParams` configures the HTTP parameters to append to the token
                                URL.
                                EOT
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
                          "params" = {
                            "additionalProperties" = {
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "description" = "params define optional HTTP URL parameters."
                            "type" = "object"
                          }
                          "path" = {
                            "description" = <<-EOT
                            HTTP path from which to scrape for metrics.
                            
                            
                            If empty, Prometheus uses the default value (e.g. `/metrics`).
                            EOT
                            "type" = "string"
                          }
                          "port" = {
                            "description" = <<-EOT
                            Name of the Service port which this endpoint refers to.
                            
                            
                            It takes precedence over `targetPort`.
                            EOT
                            "type" = "string"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` configures the HTTP Proxy URL (e.g.
                            "http://proxyserver:2195") to go through when scraping the target.
                            EOT
                            "type" = "string"
                          }
                          "relabelings" = {
                            "description" = <<-EOT
                            `relabelings` configures the relabeling rules to apply the target's
                            metadata labels.
                            
                            
                            The Operator automatically adds relabelings for a few standard Kubernetes fields.
                            
                            
                            The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
                            
                            
                            More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                            EOT
                            "items" = {
                              "description" = <<-EOT
                              RelabelConfig allows dynamic rewriting of the label set for targets, alerts,
                              scraped samples and remote write samples.
                              
                              
                              More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                              EOT
                              "properties" = {
                                "action" = {
                                  "default" = "replace"
                                  "description" = <<-EOT
                                  Action to perform based on the regex matching.
                                  
                                  
                                  `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
                                  `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.
                                  
                                  
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
                                  Replacement value against which a Replace action is performed if the
                                  regular expression matches.
                                  
                                  
                                  Regex capture groups are available.
                                  EOT
                                  "type" = "string"
                                }
                                "separator" = {
                                  "description" = "Separator is the string between concatenated SourceLabels."
                                  "type" = "string"
                                }
                                "sourceLabels" = {
                                  "description" = <<-EOT
                                  The source labels select values from existing labels. Their content is
                                  concatenated using the configured Separator and matched against the
                                  configured regular expression.
                                  EOT
                                  "items" = {
                                    "description" = <<-EOT
                                    LabelName is a valid Prometheus label name which may only contain ASCII
                                    letters, numbers, as well as underscores.
                                    EOT
                                    "pattern" = "^[a-zA-Z_][a-zA-Z0-9_]*$"
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "targetLabel" = {
                                  "description" = <<-EOT
                                  Label to which the resulting string is written in a replacement.
                                  
                                  
                                  It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
                                  `KeepEqual` and `DropEqual` actions.
                                  
                                  
                                  Regex capture groups are available.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "scheme" = {
                            "description" = <<-EOT
                            HTTP scheme to use for scraping.
                            
                            
                            `http` and `https` are the expected values unless you rewrite the
                            `__scheme__` label via relabeling.
                            
                            
                            If empty, Prometheus uses the default value `http`.
                            EOT
                            "enum" = [
                              "http",
                              "https",
                            ]
                            "type" = "string"
                          }
                          "scrapeTimeout" = {
                            "description" = <<-EOT
                            Timeout after which Prometheus considers the scrape to be failed.
                            
                            
                            If empty, Prometheus uses the global scrape timeout unless it is less
                            than the target's scrape interval value in which the latter is used.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "targetPort" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "description" = <<-EOT
                            Name or number of the target port of the `Pod` object behind the
                            Service. The port must be specified with the container's port property.
                            EOT
                            "x-kubernetes-int-or-string" = true
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration to use when scraping the target."
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
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                              "caFile" = {
                                "description" = "Path to the CA cert in the Prometheus container to use for the targets."
                                "type" = "string"
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
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                                        "description" = <<-EOT
                                        Name of the referent.
                                        More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                        TODO: Add other useful fields. apiVersion, kind, uid?
                                        EOT
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
                              "certFile" = {
                                "description" = "Path to the client cert file in the Prometheus container for the targets."
                                "type" = "string"
                              }
                              "insecureSkipVerify" = {
                                "description" = "Disable target certificate validation."
                                "type" = "boolean"
                              }
                              "keyFile" = {
                                "description" = "Path to the client key file in the Prometheus container for the targets."
                                "type" = "string"
                              }
                              "keySecret" = {
                                "description" = "Secret containing the client key file for the targets."
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = <<-EOT
                                    Name of the referent.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind, uid?
                                    EOT
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
                          "trackTimestampsStaleness" = {
                            "description" = <<-EOT
                            `trackTimestampsStaleness` defines whether Prometheus tracks staleness of
                            the metrics that have an explicit timestamp present in scraped data.
                            Has no effect if `honorTimestamps` is false.
                            
                            
                            It requires Prometheus >= v2.48.0.
                            EOT
                            "type" = "boolean"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "jobLabel" = {
                      "description" = <<-EOT
                      `jobLabel` selects the label from the associated Kubernetes `Service`
                      object which will be used as the `job` label for all metrics.
                      
                      
                      For example if `jobLabel` is set to `foo` and the Kubernetes `Service`
                      object is labeled with `foo: bar`, then Prometheus adds the `job="bar"`
                      label to all ingested metrics.
                      
                      
                      If the value of this field is empty or if the label doesn't exist for
                      the given Service, the `job` label of the metrics defaults to the name
                      of the associated Kubernetes `Service`.
                      EOT
                      "type" = "string"
                    }
                    "keepDroppedTargets" = {
                      "description" = <<-EOT
                      Per-scrape limit on the number of targets dropped by relabeling
                      that will be kept in memory. 0 means no limit.
                      
                      
                      It requires Prometheus >= v2.47.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelLimit" = {
                      "description" = <<-EOT
                      Per-scrape limit on number of labels that will be accepted for a sample.
                      
                      
                      It requires Prometheus >= v2.27.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelNameLengthLimit" = {
                      "description" = <<-EOT
                      Per-scrape limit on length of labels name that will be accepted for a sample.
                      
                      
                      It requires Prometheus >= v2.27.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "labelValueLengthLimit" = {
                      "description" = <<-EOT
                      Per-scrape limit on length of labels value that will be accepted for a sample.
                      
                      
                      It requires Prometheus >= v2.27.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "namespaceSelector" = {
                      "description" = <<-EOT
                      Selector to select which namespaces the Kubernetes `Endpoints` objects
                      are discovered from.
                      EOT
                      "properties" = {
                        "any" = {
                          "description" = <<-EOT
                          Boolean describing whether all namespaces are selected in contrast to a
                          list restricting them.
                          EOT
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
                    "podTargetLabels" = {
                      "description" = <<-EOT
                      `podTargetLabels` defines the labels which are transferred from the
                      associated Kubernetes `Pod` object onto the ingested metrics.
                      EOT
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "sampleLimit" = {
                      "description" = <<-EOT
                      `sampleLimit` defines a per-scrape limit on the number of scraped samples
                      that will be accepted.
                      EOT
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
                      `scrapeProtocols` defines the protocols to negotiate during a scrape. It tells clients the
                      protocols supported by Prometheus in order of preference (from most to least preferred).
                      
                      
                      If unset, Prometheus uses its default value.
                      
                      
                      It requires Prometheus >= v2.49.0.
                      EOT
                      "items" = {
                        "description" = <<-EOT
                        ScrapeProtocol represents a protocol used by Prometheus for scraping metrics.
                        Supported values are:
                        * `OpenMetricsText0.0.1`
                        * `OpenMetricsText1.0.0`
                        * `PrometheusProto`
                        * `PrometheusText0.0.4`
                        EOT
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
                    "selector" = {
                      "description" = "Label selector to select the Kubernetes `Endpoints` objects."
                      "properties" = {
                        "matchExpressions" = {
                          "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                          "items" = {
                            "description" = <<-EOT
                            A label selector requirement is a selector that contains values, a key, and an operator that
                            relates the key and values.
                            EOT
                            "properties" = {
                              "key" = {
                                "description" = "key is the label key that the selector applies to."
                                "type" = "string"
                              }
                              "operator" = {
                                "description" = <<-EOT
                                operator represents a key's relationship to a set of values.
                                Valid operators are In, NotIn, Exists and DoesNotExist.
                                EOT
                                "type" = "string"
                              }
                              "values" = {
                                "description" = <<-EOT
                                values is an array of string values. If the operator is In or NotIn,
                                the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                the values array must be empty. This array is replaced during a strategic
                                merge patch.
                                EOT
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
                          "description" = <<-EOT
                          matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
                          map is equivalent to an element of matchExpressions, whose key field is "key", the
                          operator is "In", and the values array contains only "value". The requirements are ANDed.
                          EOT
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
                    }
                    "targetLabels" = {
                      "description" = <<-EOT
                      `targetLabels` defines the labels which are transferred from the
                      associated Kubernetes `Service` object onto the ingested metrics.
                      EOT
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "targetLimit" = {
                      "description" = <<-EOT
                      `targetLimit` defines a limit on the number of scraped targets that will
                      be accepted.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                  }
                  "required" = [
                    "selector",
                  ]
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
