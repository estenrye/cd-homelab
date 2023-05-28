# 6. Build an IDP using Backstage, Crossplane, and PhoenixNAP BMC

Date: 2023-05-26

## Status

In Design

## Context

To demonstrate the value of an Internal Development Platform (IDP)
this project will provide an IDP that allows for the provisioning of
bare metal servers using the PhoenixNAP BMC.

### Prior Art

| Date | YouTube URL | Presenter | Event |
| --- | --- | --- | --- |
| 2022-05-30 | [GitOps Infrastructure with Backstage + Crossplane + ArgoCD](https://www.youtube.com/watch?v=Ii-lpLuzPxw) | Diego Luisi | N/A |
| 2022-06-01 | [Crossplane Intro & Deep Dive - Compose Your Custom Cloud Platform](https://youtu.be/xECc7XlD5kY) | Jared Watts, Steven Borreli, Yury Tsarev, Christopher Haar | KubeCon + CloudNativeCon North America 2022 |
| 2022-06-26 | [How to improve the development journey in your company with Backstage.](https://youtu.be/qFP_CcLp0Ao) | Diego Luisi | N/A |

## Decision

Design and implement an Internal Development Platform Workshop for a conference
talk submission.

## Architecture Diagram

![IDP Architecture Diagram](../diagrams/internal-developer-platform.png)
![BMC Provider Flow](../diagrams/xrd-bmctag.png)

## Core Components

### Backstage

|     |     |
| --- | --- |
| Project Website | [backstage.io](http://backstage.io) |
| Project Github  | [github.com/backstage/backstage](https://github.com/backstage/backstage) |
| Project Docs    | [backstage.io/docs](https://backstage.io/docs) | 

Backstage will be the frontend developer portal that allows a developer to
provision a bare metal server on the PhoenixNAP Bare Metal Cloud (BMC).

### Crossplane

|     |     |
| --- | --- |
| Project Website | [crossplane.io](https://crossplane.io)
| Project Github | [github.com/crossplane/crossplane](https://github.com/crossplane/crossplane) |
| Project Docs | [docs.crossplane.io](https://docs.crossplane.io/) |
| Project Marketplace | [marketplace.crossplane.io](https://marketplace.upbound.io/) |

Crossplane will be the desired state controller that manages the provisioning and
destruction of resources on the PhoenixNAP Bare Metal Cloud (BMC).

#### Crossplane Providers

| Provider | Github |
| --- | --- |
| [Ansible Provider](https://marketplace.upbound.io/providers/crossplane-contrib/provider-ansible) | [crossplane-contrib/provider-ansible](https://github.com/crossplane-contrib/provider-ansible) |

#### Installation Notes

- Installed Crossplane provider.
- Installed Ansible provider.

## Consequences

- [ ] Identify what tools, components and architecture will be used to build an IDP.
- [ ] Document a proposed architecture.
- [ ] Write an RFP document for a conference workshop.
