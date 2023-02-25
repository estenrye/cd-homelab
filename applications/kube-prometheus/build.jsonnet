local ingress(name, namespace, svc_host, svc_name, svc_port) = {
  apiVersion: 'networking.k8s.io/v1',
  kind: 'Ingress',
  metadata: {
    name: name,
    namespace: namespace,
    annotations: {
      // 'nginx.ingress.kubernetes.io/auth-type': 'basic',
      // 'nginx.ingress.kubernetes.io/auth-secret': 'basic-auth',
      // 'nginx.ingress.kubernetes.io/auth-realm': 'Authentication Required',
      'kubernetes.io/tls-acme': 'true',
      'cert-manager.io/cluster-issuer': 'cloudflare-dns01-issuer',
      'external-dns.alpha.kubernetes.io/hostname': svc_host,
    },
  },
  spec: { 
    rules: [{
          host: svc_host,
          http: {
            paths: [{
              path: '/',
              pathType: 'Prefix',
              backend: {
                service: {
                  name: svc_name,
                  port: {
                    name: svc_port,
                  },
                },
              },
            }],
          },
        }],
    tls: [{
      hosts: [ svc_host ],
      secretName: 'tls-' + name,
    }]
  },
};

local kp =
  (import 'kube-prometheus/main.libsonnet') +
  {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
      grafana+: {
        config+: {
          sections+: {
            server+: {
              root_url: 'https://grafana.rye.ninja/',
            },
          },
        },
        dashboards: std.mergePatch(super.dashboards, {
          // Add more unwanted dashboards here
          // 'alertmanager-overview.json': null,
        }),
      },
    },
    alertmanager+:: {
      alertmanager+: {
        spec+: {
          externalUrl: 'https://alertmanager.rye.ninja',
        },
      },
    },
    prometheus+:: {
      prometheus+: {
        spec+: {
          externalUrl: 'https://prometheus.rye.ninja',
        },
      },
    },
    ingress+:: {
      'alertmanager-main': ingress(
        'alertmanager-main',
        $.values.common.namespace,
        'alertmanager.rye.ninja',
        'alertmanager-main',
        'web',
      ),
      grafana: ingress(
        'grafana',
        $.values.common.namespace,
        'grafana.rye.ninja',
        'grafana',
        'http',
      ),
      'prometheus-k8s': ingress(
        'prometheus-k8s',
        $.values.common.namespace,
        'prometheus.rye.ninja',
        'prometheus-k8s',
        'web',
      ),
    },
  };


{ 'setup/0namespace-namespace': kp.kubePrometheus.namespace }
+ {
  ['setup/prometheus-operator-' + name]: kp.prometheusOperator[name]
  for name in std.filter((function(name) name != 'serviceMonitor' && name != 'prometheusRule'), std.objectFields(kp.prometheusOperator))
}
// serviceMonitor and prometheusRule are separated so that they can be created after the CRDs are ready
+ { 'prometheus-operator-serviceMonitor': kp.prometheusOperator.serviceMonitor }
+ { 'prometheus-operator-prometheusRule': kp.prometheusOperator.prometheusRule }
+ { 'kube-prometheus-prometheusRule': kp.kubePrometheus.prometheusRule }
+ { ['alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) }
// + { ['blackbox-exporter-' + name]: kp.blackboxExporter[name] for name in std.objectFields(kp.blackboxExporter) }
+ { ['grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) }
+ { ['kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) }
+ { ['kubernetes-' + name]: kp.kubernetesControlPlane[name] for name in std.objectFields(kp.kubernetesControlPlane) }
+ { [name + '-ingress']: kp.ingress[name] for name in std.objectFields(kp.ingress) }

{ ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) }
+ { ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) }
// + { ['prometheus-adapter-' + name]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) }