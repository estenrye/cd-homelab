resource "kubernetes_manifest" "customresourcedefinition_scrapeconfigs_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.13.0"
        "operator.prometheus.io/version" = "0.73.0"
      }
      "name" = "scrapeconfigs.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "ScrapeConfig"
        "listKind" = "ScrapeConfigList"
        "plural" = "scrapeconfigs"
        "shortNames" = [
          "scfg",
        ]
        "singular" = "scrapeconfig"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "ScrapeConfig defines a namespaced Prometheus scrape_config to be aggregated across multiple namespaces into the Prometheus configuration."
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
                  "description" = "ScrapeConfigSpec is a specification of the desired configuration for a scrape configuration."
                  "properties" = {
                    "authorization" = {
                      "description" = "Authorization header to use on every scrape request."
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
                    "azureSDConfigs" = {
                      "description" = "AzureSDConfigs defines a list of Azure service discovery configurations."
                      "items" = {
                        "description" = "AzureSDConfig allow retrieving scrape targets from Azure VMs. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#azure_sd_config"
                        "properties" = {
                          "authenticationMethod" = {
                            "description" = "# The authentication method, either OAuth or ManagedIdentity. See https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview"
                            "enum" = [
                              "OAuth",
                              "ManagedIdentity",
                            ]
                            "type" = "string"
                          }
                          "clientID" = {
                            "description" = "Optional client ID. Only required with the OAuth authentication method."
                            "type" = "string"
                          }
                          "clientSecret" = {
                            "description" = "Optional client secret. Only required with the OAuth authentication method."
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
                          "environment" = {
                            "description" = "The Azure environment."
                            "type" = "string"
                          }
                          "port" = {
                            "description" = "The port to scrape metrics from. If using the public IP address, this must instead be specified in the relabeling rule."
                            "type" = "integer"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "resourceGroup" = {
                            "description" = "Optional resource group name. Limits discovery to this resource group."
                            "type" = "string"
                          }
                          "subscriptionID" = {
                            "description" = "The subscription ID. Always required."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tenantID" = {
                            "description" = "Optional tenant ID. Only required with the OAuth authentication method."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "subscriptionID",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "basicAuth" = {
                      "description" = "BasicAuth information to use on every scrape request."
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
                    "consulSDConfigs" = {
                      "description" = "ConsulSDConfigs defines a list of Consul service discovery configurations."
                      "items" = {
                        "description" = "ConsulSDConfig defines a Consul service discovery configuration See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config"
                        "properties" = {
                          "allowStale" = {
                            "description" = "Allow stale Consul results (see https://www.consul.io/api/features/consistency.html). Will reduce load on Consul. If unset, Prometheus uses its default value."
                            "type" = "boolean"
                          }
                          "authorization" = {
                            "description" = "Authorization header configuration to authenticate against the Consul Server."
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
                            "description" = "BasicAuth information to authenticate against the Consul Server. More info: https://prometheus.io/docs/operating/configuration/#endpoints"
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
                          "datacenter" = {
                            "description" = "Consul Datacenter name, if not provided it will use the local Consul Agent Datacenter."
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2. If unset, Prometheus uses its default value."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects. If unset, Prometheus uses its default value."
                            "type" = "boolean"
                          }
                          "namespace" = {
                            "description" = "Namespaces are only supported in Consul Enterprise."
                            "type" = "string"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "nodeMeta" = {
                            "additionalProperties" = {
                              "type" = "string"
                            }
                            "description" = "Node metadata key/value pairs to filter nodes for a given service."
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration."
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
                          "partition" = {
                            "description" = "Admin Partitions are only supported in Consul Enterprise."
                            "type" = "string"
                          }
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "The time after which the provided names are refreshed. On large setup it might be a good idea to increase this value because the catalog will change all the time. If unset, Prometheus uses its default value."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "scheme" = {
                            "description" = "HTTP Scheme default \"http\""
                            "enum" = [
                              "HTTP",
                              "HTTPS",
                            ]
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "A valid string consisting of a hostname or IP followed by an optional port number."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "services" = {
                            "description" = "A list of services for which targets are retrieved. If omitted, all services are scraped."
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "tagSeparator" = {
                            "description" = "The string by which Consul tags are joined into the tag label. If unset, Prometheus uses its default value."
                            "type" = "string"
                          }
                          "tags" = {
                            "description" = "An optional list of tags used to filter nodes for a given service. Services must contain all tags in the list."
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "tlsConfig" = {
                            "description" = "TLS Config"
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
                          "tokenRef" = {
                            "description" = "Consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "digitalOceanSDConfigs" = {
                      "description" = "DigitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations."
                      "items" = {
                        "description" = "DigitalOceanSDConfig allow retrieving scrape targets from DigitalOcean's Droplets API. This service discovery uses the public IPv4 address by default, by that can be changed with relabeling See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#digitalocean_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header configuration to authenticate against the DigitalOcean API. Cannot be set at the same time as `oauth2`."
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
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be set at the same time as `authorization`."
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
                          "port" = {
                            "description" = "The port to scrape metrics from."
                            "type" = "integer"
                          }
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "Refresh interval to re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration applying to the target HTTP endpoint."
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
                      "type" = "array"
                    }
                    "dnsSDConfigs" = {
                      "description" = "DNSSDConfigs defines a list of DNS service discovery configurations."
                      "items" = {
                        "description" = "DNSSDConfig allows specifying a set of DNS domain names which are periodically queried to discover a list of targets. The DNS servers to be contacted are read from /etc/resolv.conf. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dns_sd_config"
                        "properties" = {
                          "names" = {
                            "description" = "A list of DNS domain names to be queried."
                            "items" = {
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                          }
                          "port" = {
                            "description" = "The port number used if the query type is not SRV Ignored for SRV records"
                            "type" = "integer"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the time after which the provided names are refreshed. If not set, Prometheus uses its default value."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "type" = {
                            "description" = <<-EOT
                            The type of DNS query to perform. One of SRV, A, AAAA, MX or NS. If not set, Prometheus uses its default value. 
                             When set to NS, It requires Prometheus >= 2.49.0.
                            EOT
                            "enum" = [
                              "SRV",
                              "A",
                              "AAAA",
                              "MX",
                              "NS",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "names",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "dockerSDConfigs" = {
                      "description" = "DockerSDConfigs defines a list of Docker service discovery configurations."
                      "items" = {
                        "description" = "Docker SD configurations allow retrieving scrape targets from Docker Engine hosts. This SD discovers \"containers\" and will create a target for each network IP and port the container is configured to expose. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#docker_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header configuration to authenticate against the Docker API. Cannot be set at the same time as `oauth2`."
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
                            "description" = "BasicAuth information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "filters" = {
                            "description" = "Optional filters to limit the discovery process to a subset of the available resources."
                            "items" = {
                              "description" = "DockerFilter is the configuration to limit the discovery process to a subset of available resources."
                              "properties" = {
                                "name" = {
                                  "type" = "string"
                                }
                                "values" = {
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                              }
                              "required" = [
                                "name",
                                "values",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "host" = {
                            "description" = "Address of the docker daemon"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "hostNetworkingHost" = {
                            "description" = "The host to use if the container is in host networking mode."
                            "type" = "string"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be set at the same time as `authorization`."
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
                          "port" = {
                            "description" = "The port to scrape metrics from."
                            "type" = "integer"
                          }
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "Time after which the container is refreshed."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration applying to the target HTTP endpoint."
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
                        "required" = [
                          "host",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "ec2SDConfigs" = {
                      "description" = "EC2SDConfigs defines a list of EC2 service discovery configurations."
                      "items" = {
                        "description" = "EC2SDConfig allow retrieving scrape targets from AWS EC2 instances. The private IP address is used by default, but may be changed to the public IP address with relabeling. The IAM credentials used must have the ec2:DescribeInstances permission to discover scrape targets See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#ec2_sd_config"
                        "properties" = {
                          "accessKey" = {
                            "description" = "AccessKey is the AWS API key."
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
                          "filters" = {
                            "description" = "Filters can be used optionally to filter the instance list by other criteria. Available filter criteria can be found here: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html Filter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html"
                            "items" = {
                              "description" = "EC2Filter is the configuration for filtering EC2 instances."
                              "properties" = {
                                "name" = {
                                  "type" = "string"
                                }
                                "values" = {
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                              }
                              "required" = [
                                "name",
                                "values",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "port" = {
                            "description" = "The port to scrape metrics from. If using the public IP address, this must instead be specified in the relabeling rule."
                            "type" = "integer"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "The AWS region"
                            "type" = "string"
                          }
                          "roleARN" = {
                            "description" = "AWS Role ARN, an alternative to using AWS API keys."
                            "type" = "string"
                          }
                          "secretKey" = {
                            "description" = "SecretKey is the AWS API secret."
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
                      "type" = "array"
                    }
                    "enableCompression" = {
                      "description" = <<-EOT
                      When false, Prometheus will request uncompressed response from the scraped target. 
                       It requires Prometheus >= v2.49.0. 
                       If unset, Prometheus uses true by default.
                      EOT
                      "type" = "boolean"
                    }
                    "eurekaSDConfigs" = {
                      "description" = "EurekaSDConfigs defines a list of Eureka service discovery configurations."
                      "items" = {
                        "description" = "Eureka SD configurations allow retrieving scrape targets using the Eureka REST API. Prometheus will periodically check the REST endpoint and create a target for every app instance. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#eureka_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header to use on every scrape request."
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
                            "description" = "BasicAuth information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be set at the same time as `authorization` or `basic_auth`."
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
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "Refresh interval to re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "The URL to connect to the Eureka server."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration applying to the target HTTP endpoint."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "fileSDConfigs" = {
                      "description" = "FileSDConfigs defines a list of file service discovery configurations."
                      "items" = {
                        "description" = "FileSDConfig defines a Prometheus file service discovery configuration See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#file_sd_config"
                        "properties" = {
                          "files" = {
                            "description" = "List of files to be used for file discovery. Recommendation: use absolute paths. While relative paths work, the prometheus-operator project makes no guarantees about the working directory where the configuration file is stored. Files must be mounted using Prometheus.ConfigMaps or Prometheus.Secrets."
                            "items" = {
                              "description" = "SDFile represents a file used for service discovery"
                              "pattern" = "^[^*]*(\\*[^/]*)?\\.(json|yml|yaml|JSON|YML|YAML)$"
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the refresh interval at which Prometheus will reload the content of the files."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "files",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "gceSDConfigs" = {
                      "description" = "GCESDConfigs defines a list of GCE service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        GCESDConfig configures scrape targets from GCP GCE instances. The private IP address is used by default, but may be changed to the public IP address with relabeling. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#gce_sd_config 
                         The GCE service discovery will load the Google Cloud credentials from the file specified by the GOOGLE_APPLICATION_CREDENTIALS environment variable. See https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform 
                         A pre-requisite for using GCESDConfig is that a Secret containing valid Google Cloud credentials is mounted into the Prometheus or PrometheusAgent pod via the `.spec.secrets` field and that the GOOGLE_APPLICATION_CREDENTIALS environment variable is set to /etc/prometheus/secrets/<secret-name>/<credentials-filename.json>.
                        EOT
                        "properties" = {
                          "filter" = {
                            "description" = "Filter can be used optionally to filter the instance list by other criteria Syntax of this filter is described in the filter query parameter section: https://cloud.google.com/compute/docs/reference/latest/instances/list"
                            "type" = "string"
                          }
                          "port" = {
                            "description" = "The port to scrape metrics from. If using the public IP address, this must instead be specified in the relabeling rule."
                            "type" = "integer"
                          }
                          "project" = {
                            "description" = "The Google Cloud Project ID"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tagSeparator" = {
                            "description" = "The tag separator is used to separate the tags on concatenation"
                            "type" = "string"
                          }
                          "zone" = {
                            "description" = "The zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs."
                            "minLength" = 1
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "project",
                          "zone",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "hetznerSDConfigs" = {
                      "description" = "HetznerSDConfigs defines a list of Hetzner service discovery configurations."
                      "items" = {
                        "description" = "HetznerSDConfig allow retrieving scrape targets from Hetzner Cloud API and Robot API. This service discovery uses the public IPv4 address by default, but that can be changed with relabeling See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#hetzner_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header configuration, required when role is hcloud. Role robot does not support bearer token authentication."
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
                            "description" = "BasicAuth information to use on every scrape request, required when role is robot. Role hcloud does not support basic auth."
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
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be used at the same time as `basic_auth` or `authorization`."
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
                          "port" = {
                            "description" = "The port to scrape metrics from."
                            "type" = "integer"
                          }
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "The time after which the servers are refreshed."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "The Hetzner role of entities that should be discovered."
                            "enum" = [
                              "hcloud",
                              "Hcloud",
                              "robot",
                              "Robot",
                            ]
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration to use on every scrape request."
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
                        "required" = [
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "honorLabels" = {
                      "description" = "HonorLabels chooses the metric's labels on collisions with target labels."
                      "type" = "boolean"
                    }
                    "honorTimestamps" = {
                      "description" = "HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data."
                      "type" = "boolean"
                    }
                    "httpSDConfigs" = {
                      "description" = "HTTPSDConfigs defines a list of HTTP service discovery configurations."
                      "items" = {
                        "description" = "HTTPSDConfig defines a prometheus HTTP service discovery configuration See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#http_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header configuration to authenticate against the target HTTP endpoint."
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
                            "description" = "BasicAuth information to authenticate against the target HTTP endpoint. More info: https://prometheus.io/docs/operating/configuration/#endpoints"
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
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "RefreshInterval configures the refresh interval at which Prometheus will re-query the endpoint to update the target list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration applying to the target HTTP endpoint."
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
                          "url" = {
                            "description" = "URL from which the targets are fetched."
                            "minLength" = 1
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "url",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "keepDroppedTargets" = {
                      "description" = <<-EOT
                      Per-scrape limit on the number of targets dropped by relabeling that will be kept in memory. 0 means no limit. 
                       It requires Prometheus >= v2.47.0.
                      EOT
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "kubernetesSDConfigs" = {
                      "description" = "KubernetesSDConfigs defines a list of Kubernetes service discovery configurations."
                      "items" = {
                        "description" = "KubernetesSDConfig allows retrieving scrape targets from Kubernetes' REST API. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#kubernetes_sd_config"
                        "properties" = {
                          "apiServer" = {
                            "description" = "The API server address consisting of a hostname or IP address followed by an optional port number. If left empty, Prometheus is assumed to run inside of the cluster. It will discover API servers automatically and use the pod's CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/."
                            "type" = "string"
                          }
                          "attachMetadata" = {
                            "description" = "Optional metadata to attach to discovered targets. It requires Prometheus >= v2.35.0 for `pod` role and Prometheus >= v2.37.0 for `endpoints` and `endpointslice` roles."
                            "properties" = {
                              "node" = {
                                "description" = "Attaches node metadata to discovered targets. When set to true, Prometheus must have the `get` permission on the `Nodes` objects. Only valid for Pod, Endpoint and Endpointslice roles."
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "authorization" = {
                            "description" = "Authorization header to use on every scrape request. Cannot be set at the same time as `basicAuth`, or `oauth2`."
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
                            "description" = "BasicAuth information to use on every scrape request. Cannot be set at the same time as `authorization`, or `oauth2`."
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
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "namespaces" = {
                            "description" = "Optional namespace discovery. If omitted, Prometheus discovers targets across all namespaces."
                            "properties" = {
                              "names" = {
                                "description" = "List of namespaces where to watch for resources. If empty and `ownNamespace` isn't true, Prometheus watches for resources in all namespaces."
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "ownNamespace" = {
                                "description" = "Includes the namespace in which the Prometheus pod exists to the list of watched namesapces."
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be set at the same time as `authorization`, or `basicAuth`."
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
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "Role of the Kubernetes entities that should be discovered."
                            "enum" = [
                              "Node",
                              "node",
                              "Service",
                              "service",
                              "Pod",
                              "pod",
                              "Endpoints",
                              "endpoints",
                              "EndpointSlice",
                              "endpointslice",
                              "Ingress",
                              "ingress",
                            ]
                            "type" = "string"
                          }
                          "selectors" = {
                            "description" = "Selector to select objects."
                            "items" = {
                              "description" = "K8SSelectorConfig is Kubernetes Selector Config"
                              "properties" = {
                                "field" = {
                                  "type" = "string"
                                }
                                "label" = {
                                  "type" = "string"
                                }
                                "role" = {
                                  "description" = "Role is role of the service in Kubernetes."
                                  "enum" = [
                                    "Node",
                                    "node",
                                    "Service",
                                    "service",
                                    "Pod",
                                    "pod",
                                    "Endpoints",
                                    "endpoints",
                                    "EndpointSlice",
                                    "endpointslice",
                                    "Ingress",
                                    "ingress",
                                  ]
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "role",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "role",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration to use on every scrape request."
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
                        "required" = [
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "kumaSDConfigs" = {
                      "description" = "KumaSDConfigs defines a list of Kuma service discovery configurations."
                      "items" = {
                        "description" = "KumaSDConfig allow retrieving scrape targets from Kuma's control plane. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#kuma_sd_config"
                        "properties" = {
                          "authorization" = {
                            "description" = "Authorization header to use on every scrape request."
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
                            "description" = "BasicAuth information to use on every scrape request."
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
                          "clientID" = {
                            "description" = "Client id is used by Kuma Control Plane to compute Monitoring Assignment for specific Prometheus backend."
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "Whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "fetchTimeout" = {
                            "description" = "The time after which the monitoring assignments are refreshed."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "followRedirects" = {
                            "description" = "Configure whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "noProxy" = {
                            "description" = <<-EOT
                            `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "string"
                          }
                          "oauth2" = {
                            "description" = "Optional OAuth 2.0 configuration. Cannot be set at the same time as `authorization`, or `basicAuth`."
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
                          "proxyConnectHeader" = {
                            "additionalProperties" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
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
                            "description" = <<-EOT
                            ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "proxyFromEnvironment" = {
                            "description" = <<-EOT
                            Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "type" = "boolean"
                          }
                          "proxyUrl" = {
                            "description" = <<-EOT
                            `proxyURL` defines the HTTP proxy server to use. 
                             It requires Prometheus >= v2.43.0.
                            EOT
                            "pattern" = "^http(s)?://.+$"
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "The time to wait between polling update requests."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "Address of the Kuma Control Plane's MADS xDS server."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration to use on every scrape request"
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
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
                    "metricsPath" = {
                      "description" = "MetricsPath HTTP path to scrape for metrics. If empty, Prometheus uses the default value (e.g. /metrics)."
                      "type" = "string"
                    }
                    "noProxy" = {
                      "description" = <<-EOT
                      `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names that should be excluded from proxying. IP and domain names can contain port numbers. 
                       It requires Prometheus >= v2.43.0.
                      EOT
                      "type" = "string"
                    }
                    "openstackSDConfigs" = {
                      "description" = "OpenStackSDConfigs defines a list of OpenStack service discovery configurations."
                      "items" = {
                        "description" = "OpenStackSDConfig allow retrieving scrape targets from OpenStack Nova instances. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#openstack_sd_config"
                        "properties" = {
                          "allTenants" = {
                            "description" = "Whether the service discovery should list all instances for all projects. It is only relevant for the 'instance' role and usually requires admin permissions."
                            "type" = "boolean"
                          }
                          "applicationCredentialId" = {
                            "description" = "ApplicationCredentialID"
                            "type" = "string"
                          }
                          "applicationCredentialName" = {
                            "description" = "The ApplicationCredentialID or ApplicationCredentialName fields are required if using an application credential to authenticate. Some providers allow you to create an application credential to authenticate rather than a password."
                            "type" = "string"
                          }
                          "applicationCredentialSecret" = {
                            "description" = "The applicationCredentialSecret field is required if using an application credential to authenticate."
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
                          "availability" = {
                            "description" = "Availability of the endpoint to connect to."
                            "enum" = [
                              "Public",
                              "public",
                              "Admin",
                              "admin",
                              "Internal",
                              "internal",
                            ]
                            "type" = "string"
                          }
                          "domainID" = {
                            "description" = "DomainID"
                            "type" = "string"
                          }
                          "domainName" = {
                            "description" = "At most one of domainId and domainName must be provided if using username with Identity V3. Otherwise, either are optional."
                            "type" = "string"
                          }
                          "identityEndpoint" = {
                            "description" = "IdentityEndpoint specifies the HTTP endpoint that is required to work with the Identity API of the appropriate version."
                            "type" = "string"
                          }
                          "password" = {
                            "description" = "Password for the Identity V2 and V3 APIs. Consult with your provider's control panel to discover your account's preferred method of authentication."
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
                          "port" = {
                            "description" = "The port to scrape metrics from. If using the public IP address, this must instead be specified in the relabeling rule."
                            "type" = "integer"
                          }
                          "projectID" = {
                            "description" = "ProjectID"
                            "type" = "string"
                          }
                          "projectName" = {
                            "description" = "The ProjectId and ProjectName fields are optional for the Identity V2 API. Some providers allow you to specify a ProjectName instead of the ProjectId. Some require both. Your provider's authentication policies will determine how these fields influence authentication."
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = "Refresh interval to re-read the instance list."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "The OpenStack Region."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "The OpenStack role of entities that should be discovered."
                            "enum" = [
                              "Instance",
                              "instance",
                              "Hypervisor",
                              "hypervisor",
                            ]
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "TLS configuration applying to the target HTTP endpoint."
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
                          "userid" = {
                            "description" = "UserID"
                            "type" = "string"
                          }
                          "username" = {
                            "description" = "Username is required if using Identity V2 API. Consult with your provider's control panel to discover your account's username. In Identity V3, either userid or a combination of username and domainId or domainName are needed"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "region",
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "params" = {
                      "additionalProperties" = {
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "description" = "Optional HTTP URL parameters"
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
                    }
                    "proxyConnectHeader" = {
                      "additionalProperties" = {
                        "description" = "SecretKeySelector selects a key of a Secret."
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
                      "description" = <<-EOT
                      ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests. 
                       It requires Prometheus >= v2.43.0.
                      EOT
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
                    }
                    "proxyFromEnvironment" = {
                      "description" = <<-EOT
                      Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY). If unset, Prometheus uses its default value. 
                       It requires Prometheus >= v2.43.0.
                      EOT
                      "type" = "boolean"
                    }
                    "proxyUrl" = {
                      "description" = <<-EOT
                      `proxyURL` defines the HTTP proxy server to use. 
                       It requires Prometheus >= v2.43.0.
                      EOT
                      "pattern" = "^http(s)?://.+$"
                      "type" = "string"
                    }
                    "relabelings" = {
                      "description" = "RelabelConfigs defines how to rewrite the target's labels before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields. The original scrape job's name is available via the `__tmp_prometheus_job_name` label. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
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
                    "sampleLimit" = {
                      "description" = "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "scheme" = {
                      "description" = "Configures the protocol scheme used for requests. If empty, Prometheus uses HTTP by default."
                      "enum" = [
                        "HTTP",
                        "HTTPS",
                      ]
                      "type" = "string"
                    }
                    "scrapeClass" = {
                      "description" = "The scrape class to apply."
                      "minLength" = 1
                      "type" = "string"
                    }
                    "scrapeInterval" = {
                      "description" = "ScrapeInterval is the interval between consecutive scrapes."
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "scrapeProtocols" = {
                      "description" = <<-EOT
                      The protocols to negotiate during a scrape. It tells clients the protocols supported by Prometheus in order of preference (from most to least preferred). 
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
                      "description" = "ScrapeTimeout is the number of seconds to wait until a scrape request times out."
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "staticConfigs" = {
                      "description" = "StaticConfigs defines a list of static targets with a common label set."
                      "items" = {
                        "description" = "StaticConfig defines a Prometheus static configuration. See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config"
                        "properties" = {
                          "labels" = {
                            "additionalProperties" = {
                              "type" = "string"
                            }
                            "description" = "Labels assigned to all metrics scraped from the targets."
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "targets" = {
                            "description" = "List of targets for this static configuration."
                            "items" = {
                              "description" = "Target represents a target for Prometheus to scrape"
                              "type" = "string"
                            }
                            "type" = "array"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "targetLimit" = {
                      "description" = "TargetLimit defines a limit on the number of scraped targets that will be accepted."
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "tlsConfig" = {
                      "description" = "TLS configuration to use on every scrape request"
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
                    "trackTimestampsStaleness" = {
                      "description" = "TrackTimestampsStaleness whether Prometheus tracks staleness of the metrics that have an explicit timestamp present in scraped data. Has no effect if `honorTimestamps` is false. It requires Prometheus >= v2.48.0."
                      "type" = "boolean"
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