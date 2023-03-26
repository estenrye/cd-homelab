local service(name, namespace, labels, selector, ports) = {
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: name,
    namespace: namespace,
    labels: labels,
  },
  spec: {
    ports+: ports,
    selector: selector,
    clusterIP: 'None',
  },
};

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
  (import 'github.com/etcd-io/etcd/contrib/mixin/mixin.libsonnet') +
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
        dashboards+:: {  // use this method to import your dashboards to Grafana
          'etcd-dashboard.json': (import './dashboards/etcd.json'),
          'minecraft-general-dashboard.json': (import './dashboards/minecraft-general-dashboard.json'),
          'minecraft-players-dashboard.json': (import './dashboards/minecraft-players-dashboard.json'),
          'minecraft-server-dashboard.json': (import './dashboards/minecraft-server-dashboard.json'),
        },
      },
      kubernetesControlPlane+: {
        kubeProxy: true,
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
          serviceMonitorSelector: {
            matchLabels: {
              serviceMonitorDiscovery: "enabled"
            }
          },
          serviceMonitorNamespaceSelector: {
            matchLabels: {
              serviceMonitorDiscovery: "enabled"
            }
          },
        },
      },
      serviceEtcd: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          name: 'etcd',
          namespace: 'kube-system',
          labels: { 'app.kubernetes.io/name': 'etcd' },
        },
        spec: {
          ports: [
            { name: 'metrics', targetPort: 2381, port: 2381 },
          ],
          clusterIP: 'None',
        },
      },
      endpointsEtcd: {
        apiVersion: 'v1',
        kind: 'Endpoints',
        metadata: {
          name: 'etcd',
          namespace: 'kube-system',
          labels: { 'app.kubernetes.io/name': 'etcd' },
        },
        subsets: [{
          addresses: [
            { ip: etcdIP }
            for etcdIP in ['10.5.11.1', '10.5.11.2', '10.5.11.3']
          ],
          ports: [
            { name: 'metrics', port: 2381, protocol: 'TCP' },
          ],
        }],
      },
      serviceMonitorEtcd: {
        apiVersion: 'monitoring.coreos.com/v1',
        kind: 'ServiceMonitor',
        metadata: {
          name: 'etcd',
          namespace: 'kube-system',
          labels: {
            'app.kubernetes.io/name': 'etcd',
          },
        },
        spec: {
          jobLabel: 'app.kubernetes.io/name',
          endpoints: [
            {
              port: 'metrics',
              interval: '30s',
              scheme: 'http',
            },
          ],
          selector: {
            matchLabels: {
              'app.kubernetes.io/name': 'etcd',
            },
          },
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
    kubernetesControlPlane+: {
      kubeControllerManagerPrometheusDiscoveryService: service(
        'kube-controller-manager-prometheus-discovery',
        'kube-system',
        { 'k8s-app': 'kube-controller-manager', 'app.kubernetes.io/name': 'kube-controller-manager' },
        { 'k8s-app': 'kube-controller-manager' },
        [{ name: 'https-metrics', port: 10257, targetPort: 10257 }]
      ),
      kubeSchedulerPrometheusDiscoveryService: service(
        'kube-scheduler-prometheus-discovery',
        'kube-system',
        { 'k8s-app': 'kube-scheduler', 'app.kubernetes.io/name': 'kube-scheduler' },
        { 'k8s-app': 'kube-scheduler' },
        [{ name: 'https-metrics', port: 10259, targetPort: 10259 }]
      ),
      kubeDnsPrometheusDiscoveryService: service(
        'kube-dns-prometheus-discovery',
        'kube-system',
        { 'k8s-app': 'kube-controller-manager', 'app.kubernetes.io/name': 'kube-dns' },
        { 'k8s-app': 'kube-dns' },
        [{ name: 'metrics', port: 10055, targetPort: 10055 }, { name: 'http-metrics-dnsmasq', port: 10054, targetPort: 10054 }]
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
+ { ['kubernetes-' + name]: kp.kubernetesControlPlane[name] for name in std.objectFields(kp.kubernetesControlPlane) }

{ ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) }
+ { ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) }
// + { ['prometheus-adapter-' + name]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) }