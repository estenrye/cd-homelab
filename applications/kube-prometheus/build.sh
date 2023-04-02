#!/usr/bin/env bash

# This script uses arg $1 (name of *.jsonnet file to use) to generate the manifests/*.yaml files.

set -e
set -x
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail

# get build.sh parent directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Make sure to use project tooling
PATH="$SCRIPT_DIR/tmp/bin:${PATH}"

# Download Dashboard Updates
wget https://grafana.com/api/dashboards/3070/revisions/3/download -O "$SCRIPT_DIR/dashboards/etcd.json"

wget https://raw.githubusercontent.com/sladkoff/minecraft-prometheus-exporter/master/dashboards/minecraft-general-dashboard.json -O "$SCRIPT_DIR/dashboards/minecraft-general-dashboard.json"

jq '.__inputs = [ {"name": "DS_PROMETHEUS", "label": "prometheus", "description": "", "type": "datasource", "pluginId": "prometheus", "pluginName": "Prometheus" } ]' \
   "$SCRIPT_DIR/dashboards/minecraft-general-dashboard.json" \
   | tee "$SCRIPT_DIR/dashboards/minecraft-general-dashboard-1.json" \
   && mv "$SCRIPT_DIR/dashboards/minecraft-general-dashboard-1.json" "$SCRIPT_DIR/dashboards/minecraft-general-dashboard.json"

wget https://raw.githubusercontent.com/sladkoff/minecraft-prometheus-exporter/master/dashboards/minecraft-players-dashboard.json -O "$SCRIPT_DIR/dashboards/minecraft-players-dashboard.json"
wget https://raw.githubusercontent.com/sladkoff/minecraft-prometheus-exporter/master/dashboards/minecraft-server-dashboard.json -O "$SCRIPT_DIR/dashboards/minecraft-server-dashboard.json"

# Make sure to start with a clean 'manifests' dir
rm -rf manifests
mkdir -p manifests/setup

# Calling gojsontoyaml is optional, but we would like to generate yaml, not json
jsonnet -J vendor -m manifests "${1-build.jsonnet}" | xargs -I{} sh -c 'cat {} | gojsontoyaml > {}.yaml' -- {}

# Make sure to remove json files
find manifests -type f ! -name '*.yaml' -delete
rm -f kustomization

