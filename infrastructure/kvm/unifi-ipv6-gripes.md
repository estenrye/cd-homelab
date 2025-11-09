# Unifi IPv6 Gripes

This document outlines some of the issues and gripes encountered with Unifi's handling of IPv6 in a KVM infrastructure setup.

## Lack of Fixed Internal IPv6 Addresses

One major issue is the lack of support for fixed IPv6 addresses in Unifi's DHCP server. In a KVM environment, it's important to have stable and predictable network configurations, and the inability to assign fixed IPv6 addresses to virtual machines can lead to a number of problems.
