resource "kubernetes_manifest" "customresourcedefinition_featureflagsources_core_openfeature_dev" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.15.0"
      }
      "name" = "featureflagsources.core.openfeature.dev"
    }
    "spec" = {
      "group" = "core.openfeature.dev"
      "names" = {
        "kind" = "FeatureFlagSource"
        "listKind" = "FeatureFlagSourceList"
        "plural" = "featureflagsources"
        "shortNames" = [
          "ffs",
        ]
        "singular" = "featureflagsource"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1beta1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "FeatureFlagSource is the Schema for the FeatureFlagSources API"
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
                  "description" = "FeatureFlagSourceSpec defines the desired state of FeatureFlagSource"
                  "properties" = {
                    "debugLogging" = {
                      "description" = "DebugLogging defines whether to enable --debug flag of flagd sidecar. Default false (disabled)."
                      "type" = "boolean"
                    }
                    "defaultSyncProvider" = {
                      "description" = "DefaultSyncProvider defines the default sync provider"
                      "type" = "string"
                    }
                    "envVarPrefix" = {
                      "description" = "EnvVarPrefix defines the prefix to be applied to all environment variables applied to the sidecar, default FLAGD"
                      "type" = "string"
                    }
                    "envVars" = {
                      "description" = <<-EOT
                      EnvVars define the env vars to be applied to the sidecar, any env vars in FeatureFlag CRs
                      are added at the lowest index, all values will have the EnvVarPrefix applied, default FLAGD
                      EOT
                      "items" = {
                        "description" = "EnvVar represents an environment variable present in a Container."
                        "properties" = {
                          "name" = {
                            "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                            "type" = "string"
                          }
                          "value" = {
                            "description" = <<-EOT
                            Variable references $(VAR_NAME) are expanded
                            using the previously defined environment variables in the container and
                            any service environment variables. If a variable cannot be resolved,
                            the reference in the input string will be unchanged. Double $$ are reduced
                            to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.
                            "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
                            Escaped references will never be expanded, regardless of whether the variable
                            exists or not.
                            Defaults to "".
                            EOT
                            "type" = "string"
                          }
                          "valueFrom" = {
                            "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                            "properties" = {
                              "configMapKeyRef" = {
                                "description" = "Selects a key of a ConfigMap."
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
                              "fieldRef" = {
                                "description" = <<-EOT
                                Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,
                                spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
                                EOT
                                "properties" = {
                                  "apiVersion" = {
                                    "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                    "type" = "string"
                                  }
                                  "fieldPath" = {
                                    "description" = "Path of the field to select in the specified API version."
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "fieldPath",
                                ]
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "resourceFieldRef" = {
                                "description" = <<-EOT
                                Selects a resource of the container: only resources limits and requests
                                (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
                                EOT
                                "properties" = {
                                  "containerName" = {
                                    "description" = "Container name: required for volumes, optional for env vars"
                                    "type" = "string"
                                  }
                                  "divisor" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "resource" = {
                                    "description" = "Required: resource to select"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "resource",
                                ]
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "secretKeyRef" = {
                                "description" = "Selects a key of a secret in the pod's namespace"
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
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "evaluator" = {
                      "description" = "Evaluator sets an evaluator, defaults to 'json'"
                      "type" = "string"
                    }
                    "logFormat" = {
                      "description" = "LogFormat allows for the sidecar log format to be overridden, defaults to 'json'"
                      "type" = "string"
                    }
                    "managementPort" = {
                      "description" = "ManagemetPort defines the port to serve management on, defaults to 8014"
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "otelCollectorUri" = {
                      "description" = "OtelCollectorUri defines whether to enable --otel-collector-uri flag of flagd sidecar. Default false (disabled)."
                      "type" = "string"
                    }
                    "port" = {
                      "description" = "Port defines the port to listen on, defaults to 8013"
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "probesEnabled" = {
                      "description" = "ProbesEnabled defines whether to enable liveness and readiness probes of flagd sidecar. Default true (enabled)."
                      "type" = "boolean"
                    }
                    "resources" = {
                      "description" = "Resources defines flagd sidecar resources. Default to operator sidecar-cpu-* and sidecar-ram-* flags."
                      "properties" = {
                        "claims" = {
                          "description" = <<-EOT
                          Claims lists the names of resources, defined in spec.resourceClaims,
                          that are used by this container.
                          
                          
                          This is an alpha field and requires enabling the
                          DynamicResourceAllocation feature gate.
                          
                          
                          This field is immutable. It can only be set for containers.
                          EOT
                          "items" = {
                            "description" = "ResourceClaim references one entry in PodSpec.ResourceClaims."
                            "properties" = {
                              "name" = {
                                "description" = <<-EOT
                                Name must match the name of one entry in pod.spec.resourceClaims of
                                the Pod where this field is used. It makes that resource available
                                inside a container.
                                EOT
                                "type" = "string"
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
                        "limits" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = <<-EOT
                          Limits describes the maximum amount of compute resources allowed.
                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                          EOT
                          "type" = "object"
                        }
                        "requests" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = <<-EOT
                          Requests describes the minimum amount of compute resources required.
                          If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                          otherwise to an implementation-defined value. Requests cannot exceed Limits.
                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                          EOT
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "rolloutOnChange" = {
                      "description" = <<-EOT
                      RolloutOnChange dictates whether annotated deployments will be restarted when configuration changes are
                      detected in this CR, defaults to false
                      EOT
                      "type" = "boolean"
                    }
                    "socketPath" = {
                      "description" = "SocketPath defines the unix socket path to listen on"
                      "type" = "string"
                    }
                    "sources" = {
                      "description" = "SyncProviders define the syncProviders and associated configuration to be applied to the sidecar"
                      "items" = {
                        "properties" = {
                          "certPath" = {
                            "description" = "CertPath is a path of a certificate to be used by grpc TLS connection"
                            "type" = "string"
                          }
                          "httpSyncBearerToken" = {
                            "description" = "HttpSyncBearerToken is a bearer token. Used by http(s) sync provider only"
                            "type" = "string"
                          }
                          "interval" = {
                            "description" = "Interval is a flag configuration interval in seconds used by http provider"
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "provider" = {
                            "description" = "Provider type - kubernetes, http(s), grpc(s) or file"
                            "type" = "string"
                          }
                          "providerID" = {
                            "description" = "ProviderID is an identifier to be used in grpc provider"
                            "type" = "string"
                          }
                          "selector" = {
                            "description" = "Selector is a flag configuration selector used by grpc provider"
                            "type" = "string"
                          }
                          "source" = {
                            "description" = "Source is a URI of the flag sources"
                            "type" = "string"
                          }
                          "tls" = {
                            "description" = "TLS - Enable/Disable secure TLS connectivity. Currently used only by GRPC sync"
                            "type" = "boolean"
                          }
                        }
                        "required" = [
                          "source",
                        ]
                        "type" = "object"
                      }
                      "minItems" = 1
                      "type" = "array"
                    }
                    "syncProviderArgs" = {
                      "description" = "SyncProviderArgs are string arguments passed to all sync providers, defined as key values separated by ="
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                  }
                  "required" = [
                    "sources",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "FeatureFlagSourceStatus defines the observed state of FeatureFlagSource"
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
