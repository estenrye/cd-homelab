# 20. Configuring Proxmox HA with Ceph

Date: 2023-12-23

## Status

Completed

## Context

In order to support the high availability of the Proxmox cluster, I have chosen to use Ceph as the storage backend. This will allow the cluster to continue to operate in the event of a node failure and will also allow for the live migration of VMs between nodes.

### References

- [Proxmox 8 Cluster with Ceph Storage configuration](https://youtu.be/-qk_P9SKYK4)
- [I built another server cluster... - Promxox HA Cluster w/ Ceph](https://youtu.be/lELrvffVP04)
- [Proxmox 8 cluster setup with ceph and HA](https://youtu.be/Mz-nXlqovLI)
- [$250 Proxmox Cluster gets HYPER-CONVERGED with Ceph! Basic Ceph, RADOS, and RBD for Proxmox VMs](https://www.youtube.com/watch?v=Vd8GG9twjRU)


## Decision

The change that we're proposing or have agreed to implement.

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
