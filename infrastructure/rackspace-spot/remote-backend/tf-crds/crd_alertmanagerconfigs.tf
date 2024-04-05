resource "kubernetes_manifest" "customresourcedefinition_alertmanagerconfigs_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.13.0"
        "operator.prometheus.io/version" = "0.72.0"
      }
      "name" = "alertmanagerconfigs.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "AlertmanagerConfig"
        "listKind" = "AlertmanagerConfigList"
        "plural" = "alertmanagerconfigs"
        "shortNames" = [
          "amcfg",
        ]
        "singular" = "alertmanagerconfig"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "AlertmanagerConfig configures the Prometheus Alertmanager, specifying how alerts should be grouped, inhibited and notified to external systems."
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
                  "description" = "AlertmanagerConfigSpec is a specification of the desired behavior of the Alertmanager configuration. By definition, the Alertmanager configuration only applies to alerts for which the `namespace` label is equal to the namespace of the AlertmanagerConfig resource."
                  "properties" = {
                    "inhibitRules" = {
                      "description" = "List of inhibition rules. The rules will only apply to alerts matching the resource's namespace."
                      "items" = {
                        "description" = "InhibitRule defines an inhibition rule that allows to mute alerts when other alerts are already firing. See https://prometheus.io/docs/alerting/latest/configuration/#inhibit_rule"
                        "properties" = {
                          "equal" = {
                            "description" = "Labels that must have an equal value in the source and target alert for the inhibition to take effect."
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                          }
                          "sourceMatch" = {
                            "description" = "Matchers for which one or more alerts have to exist for the inhibition to take effect. The operator enforces that the alert matches the resource's namespace."
                            "items" = {
                              "description" = "Matcher defines how to match on alert's labels."
                              "properties" = {
                                "matchType" = {
                                  "description" = "Match operation available with AlertManager >= v0.22.0 and takes precedence over Regex (deprecated) if non-empty."
                                  "enum" = [
                                    "!=",
                                    "=",
                                    "=~",
                                    "!~",
                                  ]
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Label to match."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "regex" = {
                                  "description" = "Whether to match on equality (false) or regular-expression (true). Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead."
                                  "type" = "boolean"
                                }
                                "value" = {
                                  "description" = "Label value to match."
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "targetMatch" = {
                            "description" = "Matchers that have to be fulfilled in the alerts to be muted. The operator enforces that the alert matches the resource's namespace."
                            "items" = {
                              "description" = "Matcher defines how to match on alert's labels."
                              "properties" = {
                                "matchType" = {
                                  "description" = "Match operation available with AlertManager >= v0.22.0 and takes precedence over Regex (deprecated) if non-empty."
                                  "enum" = [
                                    "!=",
                                    "=",
                                    "=~",
                                    "!~",
                                  ]
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Label to match."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "regex" = {
                                  "description" = "Whether to match on equality (false) or regular-expression (true). Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead."
                                  "type" = "boolean"
                                }
                                "value" = {
                                  "description" = "Label value to match."
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "muteTimeIntervals" = {
                      "description" = "List of MuteTimeInterval specifying when the routes should be muted."
                      "items" = {
                        "description" = "MuteTimeInterval specifies the periods in time when notifications will be muted"
                        "properties" = {
                          "name" = {
                            "description" = "Name of the time interval"
                            "type" = "string"
                          }
                          "timeIntervals" = {
                            "description" = "TimeIntervals is a list of TimeInterval"
                            "items" = {
                              "description" = "TimeInterval describes intervals of time"
                              "properties" = {
                                "daysOfMonth" = {
                                  "description" = "DaysOfMonth is a list of DayOfMonthRange"
                                  "items" = {
                                    "description" = "DayOfMonthRange is an inclusive range of days of the month beginning at 1"
                                    "properties" = {
                                      "end" = {
                                        "description" = "End of the inclusive range"
                                        "maximum" = 31
                                        "minimum" = -31
                                        "type" = "integer"
                                      }
                                      "start" = {
                                        "description" = "Start of the inclusive range"
                                        "maximum" = 31
                                        "minimum" = -31
                                        "type" = "integer"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "months" = {
                                  "description" = "Months is a list of MonthRange"
                                  "items" = {
                                    "description" = "MonthRange is an inclusive range of months of the year beginning in January Months can be specified by name (e.g 'January') by numerical month (e.g '1') or as an inclusive range (e.g 'January:March', '1:3', '1:March')"
                                    "pattern" = "^((?i)january|february|march|april|may|june|july|august|september|october|november|december|[1-12])(?:((:((?i)january|february|march|april|may|june|july|august|september|october|november|december|[1-12]))$)|$)"
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "times" = {
                                  "description" = "Times is a list of TimeRange"
                                  "items" = {
                                    "description" = "TimeRange defines a start and end time in 24hr format"
                                    "properties" = {
                                      "endTime" = {
                                        "description" = "EndTime is the end time in 24hr format."
                                        "pattern" = "^((([01][0-9])|(2[0-3])):[0-5][0-9])$|(^24:00$)"
                                        "type" = "string"
                                      }
                                      "startTime" = {
                                        "description" = "StartTime is the start time in 24hr format."
                                        "pattern" = "^((([01][0-9])|(2[0-3])):[0-5][0-9])$|(^24:00$)"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "weekdays" = {
                                  "description" = "Weekdays is a list of WeekdayRange"
                                  "items" = {
                                    "description" = "WeekdayRange is an inclusive range of days of the week beginning on Sunday Days can be specified by name (e.g 'Sunday') or as an inclusive range (e.g 'Monday:Friday')"
                                    "pattern" = "^((?i)sun|mon|tues|wednes|thurs|fri|satur)day(?:((:(sun|mon|tues|wednes|thurs|fri|satur)day)$)|$)"
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "years" = {
                                  "description" = "Years is a list of YearRange"
                                  "items" = {
                                    "description" = "YearRange is an inclusive range of years"
                                    "pattern" = "^2\\d{3}(?::2\\d{3}|$)"
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "receivers" = {
                      "description" = "List of receivers."
                      "items" = {
                        "description" = "Receiver defines one or more notification integrations."
                        "properties" = {
                          "discordConfigs" = {
                            "description" = "List of Discord configurations."
                            "items" = {
                              "description" = "DiscordConfig configures notifications via Discord. See https://prometheus.io/docs/alerting/latest/configuration/#discord_config"
                              "properties" = {
                                "apiURL" = {
                                  "description" = "The secret's key that contains the Discord webhook URL. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "The template of the message's body."
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "title" = {
                                  "description" = "The template of the message's title."
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "apiURL",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "emailConfigs" = {
                            "description" = "List of Email configurations."
                            "items" = {
                              "description" = "EmailConfig configures notifications via Email."
                              "properties" = {
                                "authIdentity" = {
                                  "description" = "The identity to use for authentication."
                                  "type" = "string"
                                }
                                "authPassword" = {
                                  "description" = "The secret's key that contains the password to use for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "authSecret" = {
                                  "description" = "The secret's key that contains the CRAM-MD5 secret. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "authUsername" = {
                                  "description" = "The username to use for authentication."
                                  "type" = "string"
                                }
                                "from" = {
                                  "description" = "The sender address."
                                  "type" = "string"
                                }
                                "headers" = {
                                  "description" = "Further headers email header key/value pairs. Overrides any headers previously set by the notification implementation."
                                  "items" = {
                                    "description" = "KeyValue defines a (key, value) tuple."
                                    "properties" = {
                                      "key" = {
                                        "description" = "Key of the tuple."
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value of the tuple."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "hello" = {
                                  "description" = "The hostname to identify to the SMTP server."
                                  "type" = "string"
                                }
                                "html" = {
                                  "description" = "The HTML body of the email notification."
                                  "type" = "string"
                                }
                                "requireTLS" = {
                                  "description" = "The SMTP TLS requirement. Note that Go does not support unencrypted connections to remote SMTP endpoints."
                                  "type" = "boolean"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "smarthost" = {
                                  "description" = "The SMTP host and port through which emails are sent. E.g. example.com:25"
                                  "type" = "string"
                                }
                                "text" = {
                                  "description" = "The text body of the email notification."
                                  "type" = "string"
                                }
                                "tlsConfig" = {
                                  "description" = "TLS configuration"
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
                                "to" = {
                                  "description" = "The email address to send notifications to."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "msteamsConfigs" = {
                            "description" = "List of MSTeams configurations. It requires Alertmanager >= 0.26.0."
                            "items" = {
                              "description" = "MSTeamsConfig configures notifications via Microsoft Teams. It requires Alertmanager >= 0.26.0."
                              "properties" = {
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "sendResolved" = {
                                  "description" = "Whether to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "text" = {
                                  "description" = "Message body template."
                                  "type" = "string"
                                }
                                "title" = {
                                  "description" = "Message title template."
                                  "type" = "string"
                                }
                                "webhookUrl" = {
                                  "description" = "MSTeams webhook URL."
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
                                "webhookUrl",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "name" = {
                            "description" = "Name of the receiver. Must be unique across all items from the list."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "opsgenieConfigs" = {
                            "description" = "List of OpsGenie configurations."
                            "items" = {
                              "description" = "OpsGenieConfig configures notifications via OpsGenie. See https://prometheus.io/docs/alerting/latest/configuration/#opsgenie_config"
                              "properties" = {
                                "actions" = {
                                  "description" = "Comma separated list of actions that will be available for the alert."
                                  "type" = "string"
                                }
                                "apiKey" = {
                                  "description" = "The secret's key that contains the OpsGenie API key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "apiURL" = {
                                  "description" = "The URL to send OpsGenie API requests to."
                                  "type" = "string"
                                }
                                "description" = {
                                  "description" = "Description of the incident."
                                  "type" = "string"
                                }
                                "details" = {
                                  "description" = "A set of arbitrary key/value pairs that provide further detail about the incident."
                                  "items" = {
                                    "description" = "KeyValue defines a (key, value) tuple."
                                    "properties" = {
                                      "key" = {
                                        "description" = "Key of the tuple."
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value of the tuple."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "entity" = {
                                  "description" = "Optional field that can be used to specify which domain alert is related to."
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "Alert text limited to 130 characters."
                                  "type" = "string"
                                }
                                "note" = {
                                  "description" = "Additional alert note."
                                  "type" = "string"
                                }
                                "priority" = {
                                  "description" = "Priority level of alert. Possible values are P1, P2, P3, P4, and P5."
                                  "type" = "string"
                                }
                                "responders" = {
                                  "description" = "List of responders responsible for notifications."
                                  "items" = {
                                    "description" = "OpsGenieConfigResponder defines a responder to an incident. One of `id`, `name` or `username` has to be defined."
                                    "properties" = {
                                      "id" = {
                                        "description" = "ID of the responder."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the responder."
                                        "type" = "string"
                                      }
                                      "type" = {
                                        "description" = "Type of responder."
                                        "enum" = [
                                          "team",
                                          "teams",
                                          "user",
                                          "escalation",
                                          "schedule",
                                        ]
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "username" = {
                                        "description" = "Username of the responder."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "type",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "source" = {
                                  "description" = "Backlink to the sender of the notification."
                                  "type" = "string"
                                }
                                "tags" = {
                                  "description" = "Comma separated list of tags attached to the notifications."
                                  "type" = "string"
                                }
                                "updateAlerts" = {
                                  "description" = "Whether to update message and description of the alert in OpsGenie if it already exists By default, the alert is never updated in OpsGenie, the new message only appears in activity log."
                                  "type" = "boolean"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "pagerdutyConfigs" = {
                            "description" = "List of PagerDuty configurations."
                            "items" = {
                              "description" = "PagerDutyConfig configures notifications via PagerDuty. See https://prometheus.io/docs/alerting/latest/configuration/#pagerduty_config"
                              "properties" = {
                                "class" = {
                                  "description" = "The class/type of the event."
                                  "type" = "string"
                                }
                                "client" = {
                                  "description" = "Client identification."
                                  "type" = "string"
                                }
                                "clientURL" = {
                                  "description" = "Backlink to the sender of notification."
                                  "type" = "string"
                                }
                                "component" = {
                                  "description" = "The part or component of the affected system that is broken."
                                  "type" = "string"
                                }
                                "description" = {
                                  "description" = "Description of the incident."
                                  "type" = "string"
                                }
                                "details" = {
                                  "description" = "Arbitrary key/value pairs that provide further detail about the incident."
                                  "items" = {
                                    "description" = "KeyValue defines a (key, value) tuple."
                                    "properties" = {
                                      "key" = {
                                        "description" = "Key of the tuple."
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value of the tuple."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "group" = {
                                  "description" = "A cluster or grouping of sources."
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "pagerDutyImageConfigs" = {
                                  "description" = "A list of image details to attach that provide further detail about an incident."
                                  "items" = {
                                    "description" = "PagerDutyImageConfig attaches images to an incident"
                                    "properties" = {
                                      "alt" = {
                                        "description" = "Alt is the optional alternative text for the image."
                                        "type" = "string"
                                      }
                                      "href" = {
                                        "description" = "Optional URL; makes the image a clickable link."
                                        "type" = "string"
                                      }
                                      "src" = {
                                        "description" = "Src of the image being attached to the incident"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "pagerDutyLinkConfigs" = {
                                  "description" = "A list of link details to attach that provide further detail about an incident."
                                  "items" = {
                                    "description" = "PagerDutyLinkConfig attaches text links to an incident"
                                    "properties" = {
                                      "alt" = {
                                        "description" = "Text that describes the purpose of the link, and can be used as the link's text."
                                        "type" = "string"
                                      }
                                      "href" = {
                                        "description" = "Href is the URL of the link to be attached"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "routingKey" = {
                                  "description" = "The secret's key that contains the PagerDuty integration key (when using Events API v2). Either this field or `serviceKey` needs to be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "serviceKey" = {
                                  "description" = "The secret's key that contains the PagerDuty service key (when using integration type \"Prometheus\"). Either this field or `routingKey` needs to be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "severity" = {
                                  "description" = "Severity of the incident."
                                  "type" = "string"
                                }
                                "url" = {
                                  "description" = "The URL to send requests to."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "pushoverConfigs" = {
                            "description" = "List of Pushover configurations."
                            "items" = {
                              "description" = "PushoverConfig configures notifications via Pushover. See https://prometheus.io/docs/alerting/latest/configuration/#pushover_config"
                              "properties" = {
                                "device" = {
                                  "description" = "The name of a device to send the notification to"
                                  "type" = "string"
                                }
                                "expire" = {
                                  "description" = "How long your notification will continue to be retried for, unless the user acknowledges the notification."
                                  "pattern" = "^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$"
                                  "type" = "string"
                                }
                                "html" = {
                                  "description" = "Whether notification message is HTML or plain text."
                                  "type" = "boolean"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "Notification message."
                                  "type" = "string"
                                }
                                "priority" = {
                                  "description" = "Priority, see https://pushover.net/api#priority"
                                  "type" = "string"
                                }
                                "retry" = {
                                  "description" = "How often the Pushover servers will send the same notification to the user. Must be at least 30 seconds."
                                  "pattern" = "^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$"
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "sound" = {
                                  "description" = "The name of one of the sounds supported by device clients to override the user's default sound choice"
                                  "type" = "string"
                                }
                                "title" = {
                                  "description" = "Notification title."
                                  "type" = "string"
                                }
                                "token" = {
                                  "description" = "The secret's key that contains the registered application's API token, see https://pushover.net/apps. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator. Either `token` or `tokenFile` is required."
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
                                "tokenFile" = {
                                  "description" = "The token file that contains the registered application's API token, see https://pushover.net/apps. Either `token` or `tokenFile` is required. It requires Alertmanager >= v0.26.0."
                                  "type" = "string"
                                }
                                "url" = {
                                  "description" = "A supplementary URL shown alongside the message."
                                  "type" = "string"
                                }
                                "urlTitle" = {
                                  "description" = "A title for supplementary URL, otherwise just the URL is shown"
                                  "type" = "string"
                                }
                                "userKey" = {
                                  "description" = "The secret's key that contains the recipient user's user key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator. Either `userKey` or `userKeyFile` is required."
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
                                "userKeyFile" = {
                                  "description" = "The user key file that contains the recipient user's user key. Either `userKey` or `userKeyFile` is required. It requires Alertmanager >= v0.26.0."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "slackConfigs" = {
                            "description" = "List of Slack configurations."
                            "items" = {
                              "description" = "SlackConfig configures notifications via Slack. See https://prometheus.io/docs/alerting/latest/configuration/#slack_config"
                              "properties" = {
                                "actions" = {
                                  "description" = "A list of Slack actions that are sent with each notification."
                                  "items" = {
                                    "description" = "SlackAction configures a single Slack action that is sent with each notification. See https://api.slack.com/docs/message-attachments#action_fields and https://api.slack.com/docs/message-buttons for more information."
                                    "properties" = {
                                      "confirm" = {
                                        "description" = "SlackConfirmationField protect users from destructive actions or particularly distinguished decisions by asking them to confirm their button click one more time. See https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields for more information."
                                        "properties" = {
                                          "dismissText" = {
                                            "type" = "string"
                                          }
                                          "okText" = {
                                            "type" = "string"
                                          }
                                          "text" = {
                                            "minLength" = 1
                                            "type" = "string"
                                          }
                                          "title" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "text",
                                        ]
                                        "type" = "object"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "style" = {
                                        "type" = "string"
                                      }
                                      "text" = {
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "type" = {
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "url" = {
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "text",
                                      "type",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "apiURL" = {
                                  "description" = "The secret's key that contains the Slack webhook URL. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "callbackId" = {
                                  "type" = "string"
                                }
                                "channel" = {
                                  "description" = "The channel or user to send notifications to."
                                  "type" = "string"
                                }
                                "color" = {
                                  "type" = "string"
                                }
                                "fallback" = {
                                  "type" = "string"
                                }
                                "fields" = {
                                  "description" = "A list of Slack fields that are sent with each notification."
                                  "items" = {
                                    "description" = "SlackField configures a single Slack field that is sent with each notification. Each field must contain a title, value, and optionally, a boolean value to indicate if the field is short enough to be displayed next to other fields designated as short. See https://api.slack.com/docs/message-attachments#fields for more information."
                                    "properties" = {
                                      "short" = {
                                        "type" = "boolean"
                                      }
                                      "title" = {
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "title",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "footer" = {
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "iconEmoji" = {
                                  "type" = "string"
                                }
                                "iconURL" = {
                                  "type" = "string"
                                }
                                "imageURL" = {
                                  "type" = "string"
                                }
                                "linkNames" = {
                                  "type" = "boolean"
                                }
                                "mrkdwnIn" = {
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "pretext" = {
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "shortFields" = {
                                  "type" = "boolean"
                                }
                                "text" = {
                                  "type" = "string"
                                }
                                "thumbURL" = {
                                  "type" = "string"
                                }
                                "title" = {
                                  "type" = "string"
                                }
                                "titleLink" = {
                                  "type" = "string"
                                }
                                "username" = {
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "snsConfigs" = {
                            "description" = "List of SNS configurations"
                            "items" = {
                              "description" = "SNSConfig configures notifications via AWS SNS. See https://prometheus.io/docs/alerting/latest/configuration/#sns_configs"
                              "properties" = {
                                "apiURL" = {
                                  "description" = "The SNS API URL i.e. https://sns.us-east-2.amazonaws.com. If not specified, the SNS API URL from the SNS SDK will be used."
                                  "type" = "string"
                                }
                                "attributes" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "SNS message attributes."
                                  "type" = "object"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "The message content of the SNS notification."
                                  "type" = "string"
                                }
                                "phoneNumber" = {
                                  "description" = "Phone number if message is delivered via SMS in E.164 format. If you don't specify this value, you must specify a value for the TopicARN or TargetARN."
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "sigv4" = {
                                  "description" = "Configures AWS's Signature Verification 4 signing process to sign requests."
                                  "properties" = {
                                    "accessKey" = {
                                      "description" = "AccessKey is the AWS API key. If not specified, the environment variable `AWS_ACCESS_KEY_ID` is used."
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
                                    "profile" = {
                                      "description" = "Profile is the named AWS profile used to authenticate."
                                      "type" = "string"
                                    }
                                    "region" = {
                                      "description" = "Region is the AWS region. If blank, the region from the default credentials chain used."
                                      "type" = "string"
                                    }
                                    "roleArn" = {
                                      "description" = "RoleArn is the named AWS profile used to authenticate."
                                      "type" = "string"
                                    }
                                    "secretKey" = {
                                      "description" = "SecretKey is the AWS API secret. If not specified, the environment variable `AWS_SECRET_ACCESS_KEY` is used."
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
                                "subject" = {
                                  "description" = "Subject line when the message is delivered to email endpoints."
                                  "type" = "string"
                                }
                                "targetARN" = {
                                  "description" = "The  mobile platform endpoint ARN if message is delivered via mobile notifications. If you don't specify this value, you must specify a value for the topic_arn or PhoneNumber."
                                  "type" = "string"
                                }
                                "topicARN" = {
                                  "description" = "SNS topic ARN, i.e. arn:aws:sns:us-east-2:698519295917:My-Topic If you don't specify this value, you must specify a value for the PhoneNumber or TargetARN."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "telegramConfigs" = {
                            "description" = "List of Telegram configurations."
                            "items" = {
                              "description" = "TelegramConfig configures notifications via Telegram. See https://prometheus.io/docs/alerting/latest/configuration/#telegram_config"
                              "properties" = {
                                "apiURL" = {
                                  "description" = "The Telegram API URL i.e. https://api.telegram.org. If not specified, default API URL will be used."
                                  "type" = "string"
                                }
                                "botToken" = {
                                  "description" = <<-EOT
                                  Telegram bot token. It is mutually exclusive with `botTokenFile`. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator. 
                                   Either `botToken` or `botTokenFile` is required.
                                  EOT
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
                                "botTokenFile" = {
                                  "description" = <<-EOT
                                  File to read the Telegram bot token from. It is mutually exclusive with `botToken`. Either `botToken` or `botTokenFile` is required. 
                                   It requires Alertmanager >= v0.26.0.
                                  EOT
                                  "type" = "string"
                                }
                                "chatID" = {
                                  "description" = "The Telegram chat ID."
                                  "format" = "int64"
                                  "type" = "integer"
                                }
                                "disableNotifications" = {
                                  "description" = "Disable telegram notifications"
                                  "type" = "boolean"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "Message template"
                                  "type" = "string"
                                }
                                "parseMode" = {
                                  "description" = "Parse mode for telegram message"
                                  "enum" = [
                                    "MarkdownV2",
                                    "Markdown",
                                    "HTML",
                                  ]
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "victoropsConfigs" = {
                            "description" = "List of VictorOps configurations."
                            "items" = {
                              "description" = "VictorOpsConfig configures notifications via VictorOps. See https://prometheus.io/docs/alerting/latest/configuration/#victorops_config"
                              "properties" = {
                                "apiKey" = {
                                  "description" = "The secret's key that contains the API key to use when talking to the VictorOps API. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "apiUrl" = {
                                  "description" = "The VictorOps API URL."
                                  "type" = "string"
                                }
                                "customFields" = {
                                  "description" = "Additional custom fields for notification."
                                  "items" = {
                                    "description" = "KeyValue defines a (key, value) tuple."
                                    "properties" = {
                                      "key" = {
                                        "description" = "Key of the tuple."
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value of the tuple."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "entityDisplayName" = {
                                  "description" = "Contains summary of the alerted problem."
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "The HTTP client's configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "messageType" = {
                                  "description" = "Describes the behavior of the alert (CRITICAL, WARNING, INFO)."
                                  "type" = "string"
                                }
                                "monitoringTool" = {
                                  "description" = "The monitoring tool the state message is from."
                                  "type" = "string"
                                }
                                "routingKey" = {
                                  "description" = "A key used to map the alert to a team."
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "stateMessage" = {
                                  "description" = "Contains long explanation of the alerted problem."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "webexConfigs" = {
                            "description" = "List of Webex configurations."
                            "items" = {
                              "description" = "WebexConfig configures notification via Cisco Webex See https://prometheus.io/docs/alerting/latest/configuration/#webex_config"
                              "properties" = {
                                "apiURL" = {
                                  "description" = "The Webex Teams API URL i.e. https://webexapis.com/v1/messages Provide if different from the default API URL."
                                  "pattern" = "^https?://.+$"
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "The HTTP client's configuration. You must supply the bot token via the `httpConfig.authorization` field."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "Message template"
                                  "type" = "string"
                                }
                                "roomID" = {
                                  "description" = "ID of the Webex Teams room where to send the messages."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "roomID",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "webhookConfigs" = {
                            "description" = "List of webhook configurations."
                            "items" = {
                              "description" = "WebhookConfig configures notifications via a generic receiver supporting the webhook payload. See https://prometheus.io/docs/alerting/latest/configuration/#webhook_config"
                              "properties" = {
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "maxAlerts" = {
                                  "description" = "Maximum number of alerts to be sent per webhook message. When 0, all alerts are included."
                                  "format" = "int32"
                                  "minimum" = 0
                                  "type" = "integer"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "url" = {
                                  "description" = "The URL to send HTTP POST requests to. `urlSecret` takes precedence over `url`. One of `urlSecret` and `url` should be defined."
                                  "type" = "string"
                                }
                                "urlSecret" = {
                                  "description" = "The secret's key that contains the webhook URL to send HTTP requests to. `urlSecret` takes precedence over `url`. One of `urlSecret` and `url` should be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                          "wechatConfigs" = {
                            "description" = "List of WeChat configurations."
                            "items" = {
                              "description" = "WeChatConfig configures notifications via WeChat. See https://prometheus.io/docs/alerting/latest/configuration/#wechat_config"
                              "properties" = {
                                "agentID" = {
                                  "type" = "string"
                                }
                                "apiSecret" = {
                                  "description" = "The secret's key that contains the WeChat API key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                "apiURL" = {
                                  "description" = "The WeChat API URL."
                                  "type" = "string"
                                }
                                "corpID" = {
                                  "description" = "The corp id for authentication."
                                  "type" = "string"
                                }
                                "httpConfig" = {
                                  "description" = "HTTP client configuration."
                                  "properties" = {
                                    "authorization" = {
                                      "description" = "Authorization header configuration for the client. This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+."
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
                                      "description" = "BasicAuth for the client. This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence."
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
                                      "description" = "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
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
                                    "followRedirects" = {
                                      "description" = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects."
                                      "type" = "boolean"
                                    }
                                    "oauth2" = {
                                      "description" = "OAuth2 client credentials used to fetch a token for the targets."
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
                                    "proxyURL" = {
                                      "description" = "Optional proxy URL."
                                      "type" = "string"
                                    }
                                    "tlsConfig" = {
                                      "description" = "TLS configuration for the client."
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
                                "message" = {
                                  "description" = "API request data as defined by the WeChat API."
                                  "type" = "string"
                                }
                                "messageType" = {
                                  "type" = "string"
                                }
                                "sendResolved" = {
                                  "description" = "Whether or not to notify about resolved alerts."
                                  "type" = "boolean"
                                }
                                "toParty" = {
                                  "type" = "string"
                                }
                                "toTag" = {
                                  "type" = "string"
                                }
                                "toUser" = {
                                  "type" = "string"
                                }
                              }
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
                    }
                    "route" = {
                      "description" = "The Alertmanager route definition for alerts matching the resource's namespace. If present, it will be added to the generated Alertmanager configuration as a first-level route."
                      "properties" = {
                        "activeTimeIntervals" = {
                          "description" = "ActiveTimeIntervals is a list of MuteTimeInterval names when this route should be active."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "continue" = {
                          "description" = "Boolean indicating whether an alert should continue matching subsequent sibling nodes. It will always be overridden to true for the first-level route by the Prometheus operator."
                          "type" = "boolean"
                        }
                        "groupBy" = {
                          "description" = "List of labels to group by. Labels must not be repeated (unique list). Special label \"...\" (aggregate by all possible labels), if provided, must be the only element in the list."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "groupInterval" = {
                          "description" = "How long to wait before sending an updated notification. Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$` Example: \"5m\""
                          "type" = "string"
                        }
                        "groupWait" = {
                          "description" = "How long to wait before sending the initial notification. Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$` Example: \"30s\""
                          "type" = "string"
                        }
                        "matchers" = {
                          "description" = "List of matchers that the alert's labels should match. For the first level route, the operator removes any existing equality and regexp matcher on the `namespace` label and adds a `namespace: <object namespace>` matcher."
                          "items" = {
                            "description" = "Matcher defines how to match on alert's labels."
                            "properties" = {
                              "matchType" = {
                                "description" = "Match operation available with AlertManager >= v0.22.0 and takes precedence over Regex (deprecated) if non-empty."
                                "enum" = [
                                  "!=",
                                  "=",
                                  "=~",
                                  "!~",
                                ]
                                "type" = "string"
                              }
                              "name" = {
                                "description" = "Label to match."
                                "minLength" = 1
                                "type" = "string"
                              }
                              "regex" = {
                                "description" = "Whether to match on equality (false) or regular-expression (true). Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead."
                                "type" = "boolean"
                              }
                              "value" = {
                                "description" = "Label value to match."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "muteTimeIntervals" = {
                          "description" = "Note: this comment applies to the field definition above but appears below otherwise it gets included in the generated manifest. CRD schema doesn't support self-referential types for now (see https://github.com/kubernetes/kubernetes/issues/62872). We have to use an alternative type to circumvent the limitation. The downside is that the Kube API can't validate the data beyond the fact that it is a valid JSON representation. MuteTimeIntervals is a list of MuteTimeInterval names that will mute this route when matched,"
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "receiver" = {
                          "description" = "Name of the receiver for this route. If not empty, it should be listed in the `receivers` field."
                          "type" = "string"
                        }
                        "repeatInterval" = {
                          "description" = "How long to wait before repeating the last notification. Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$` Example: \"4h\""
                          "type" = "string"
                        }
                        "routes" = {
                          "description" = "Child routes."
                          "items" = {
                            "x-kubernetes-preserve-unknown-fields" = true
                          }
                          "type" = "array"
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
