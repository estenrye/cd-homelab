# Applying patches to Running Nodes

## Adding the docker registry

```bash
talosctl patch mc --nodes 10.5.11.4 --patch @docker-io-registry.yaml
```