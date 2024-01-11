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
- [Proxmox 8 Setup: 7 Things to Do After Installing Proxmox 8](https://youtu.be/1hP1anXex4k)
- [First Steps After Installing Proxmox 8: A Comprehensive Guide](https://theramblingtech.com/setup-proxmox8/)
- [Proxmox 8.0 - PCIe Passthrough Tutorial](https://youtu.be/_hOBAGKLQkI)
- [Before I do anything on Proxmox, I do this first...](https://youtu.be/GoZaMgEgrHw)
- [Tuesday Tech Tip - Tuning and Benchmarking for your workload with Ceph](https://youtu.be/7C9HI_f0bBo)
- [Tuesday Tech Tip - Highly Available Virtualization with Proxmox and Ceph](https://youtu.be/LAz67Dx5C04?list=PL0q6mglL88APuQhucTzEQWi_eXNcXRmWi)

## Ceph Benchmarking

### Disk benchmarks

The following benchmarks were run on the ceph disks.

```bash
# install fio
apt install -y fio

# 4k synchronus random write
fio --filename=/dev/sdb --direct=1 --fsync=1 --rw=randwrite --bs=4k --numjobs=1 --iodepth=1 --runtime=60 --time_based --group_reporting --name=4k-sync-write-test

# 4k synchronus sequential write
fio --filename=/dev/sdb --direct=1 --fsync=1 --rw=write --bs=4k --numjobs=1 --iodepth=1 --runtime=60 --time_based --group_reporting --name=4k-sync-write-test

```

#### 4k synchronus random write

| Host  | Disk | Min IOPS | Max IOPS | Avg IOPS | Min lat(usec) | Max lat(usec) | Avg lat(usec) | Min clat(usec) | Max clat(usec) | Avg clat(usec) | Min BW (KiB/s) | Max BW (KiB/s) | Avg BW (KiB/s) |
| ----- | ---- | -------- | -------- | -------- | ------------- | ------------- | ------------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |
| pve01 | sdb  | 4        | 6        | 5        | 78            | 10344         | 207.46        | 78             | 10342          | 206.72         | 16             | 24             | 22.52          |
| pve01 | sdc  | 12       | 2012     | 513.04   | 61            | 564           | 148.52        | 61             | 563            | 147.95         | 48             | 8048           | 2052.17        |
| pve01 | sdd  | 12       | 1908     | 517.16   | 61            | 546           | 152.19        | 61             | 545            | 151.61         | 48             | 7632           | 2068.64        |
| pve01 | sde  | 1232     | 1918     | 1440.67  | 62            | 618           | 69.21         | 61             | 618            | 68.78          | 4928           | 7672           | 5762.69        |
| pve02 | sdb  | 46       | 2368     | 596.24   | 58            | 978           | 112.76        | 57             | 977            | 112.15         | 184            | 9472           | 2384.94        |
| pve02 | sdc  | 46       | 2438     | 622.30   | 58            | 968           | 92.75         | 57             | 967            | 92.15          | 184            | 9752           | 2489.21        |
| pve02 | sdd  | 42       | 2238     | 591.23   | 58            | 2208          | 133.49        | 57             | 925            | 132.80         | 168            | 8952           | 2364.91        |
| pve03 | sdb  | 12       | 2356     | 520.35   | 50            | 1660          | 124.46        | 49             | 1659           | 123.85         | 48             | 9424           | 2081.41        |
| pve03 | sdc  | 44       | 2390     | 615.03   | 49            | 739           | 105.98        | 49             | 739            | 105.37         | 176            | 9560           | 2460.10        | 
| pve03 | sdd  | 12       | 1888     | 486.97   | 52            | 511           | 156.24        | 52             | 510            | 155.63         | 48             | 7552           | 1947.87        |

#### 4k synchronus sequential write

| Host  | Disk | Min IOPS | Max IOPS | Avg IOPS | Min lat(usec) | Max lat(usec) | Avg lat(usec) | Min clat(usec) | Max clat(usec) | Avg clat(usec) | Min BW (KiB/s) | Max BW (KiB/s) | Avg BW (KiB/s) |
| ----- | ---- | -------- | -------- | -------- | ------------- | ------------- | ------------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |
| pve01 | sdb  | 4        | 6        | 5        | 78            | 242           | 183.90        | 78             | 241            | 183.18         | 16             | 32             | 22.73          |
| pve01 | sdc  | 1606     | 2306     | 1851.34  | 57            | 930           | 141.24        | 57             | 929            | 140.67         | 48             | 8048           | 2052.17        |
| pve01 | sdd  | 44       | 2092     | 1735.28  | 58            | 1529          | 144.98        | 57             | 1528           | 144.42         | 176            | 8368           | 6941.11        |
| pve01 | sde  | 1180     | 2008     | 1841.76  | 52            | 6787          | 70.74         | 52             | 6786           | 70.74          | 4720           | 8032           | 7367.06        |
| pve02 | sdb  | 560      | 2432     | 1964.27  | 57            | 497           | 122.47        | 56             | 496            | 121.88         | 2240           | 9728           | 7857.08        |
| pve02 | sdc  | 46       | 2392     | 1956.29  | 58            | 1083          | 117.73        | 57             | 1083           | 117.15         | 184            | 9568           | 7825.14        |
| pve02 | sdd  | 46       | 2396     | 2029.76  | 57            | 562           | 107.07        | 57             | 561            | 106.48         | 184            | 9584           | 8119.06        |
| pve03 | sdb  | 466      | 2070     | 1804.40  | 52            | 510           | 148.33        | 51             | 509            | 147.74         | 1864           | 8280           | 7217.61        |
| pve03 | sdc  | 46       | 2404     | 1781.76  | 49            | 634           | 145.40        | 49             | 634            | 144.80         | 184            | 9616           | 7127.06        |
| pve03 | sdd  | 44       | 2298     | 1759.87  | 49            | 935           | 153.80        | 49             | 935            | 153.22         | 176            | 9192           | 7039.46        |

### Network benchmarks

The following benchmarks were run on the ceph network.

```bash
# install iperf3
apt install -y iperf3

# use pve01 as the server
iperf3 -B 10.6.0.50 -s

# use pve02 as the client
iperf3 -B 10.6.0.51 -c 10.6.0.50
iperf3 -B 10.6.0.51 -c 10.6.0.50 -R

# use pve03 as the client
iperf3 -B 10.6.0.52 -c 10.6.0.50
iperf3 -B 10.6.0.52 -c 10.6.0.50 -R

# use pve02 as the server
iperf3 -B 10.6.0.51 -s

# use pve03 as the client
iperf3 -B 10.6.0.52 -c 10.6.0.51
iperf3 -B 10.6.0.52 -c 10.6.0.51 -R

```

#### pve01 as the server, pve02 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.07 GBytes  9.16 Gbits/sec    0   1.64 MBytes
[  5]   1.00-2.00   sec   918 MBytes  7.70 Gbits/sec    0   1.64 MBytes
[  5]   2.00-3.00   sec  1.06 GBytes  9.12 Gbits/sec    0   1.81 MBytes
[  5]   3.00-4.00   sec   994 MBytes  8.34 Gbits/sec    0   1.90 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.90 MBytes
[  5]   5.00-6.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.90 MBytes
[  5]   6.00-7.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.90 MBytes
[  5]   7.00-8.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.90 MBytes
[  5]   8.00-9.00   sec  1.05 GBytes  9.01 Gbits/sec    0   2.00 MBytes
[  5]   9.00-10.00  sec  1.09 GBytes  9.40 Gbits/sec    0   2.00 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.5 GBytes  9.03 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  10.5 GBytes  9.03 Gbits/sec                  receiver
```

#### pve02 as the server, pve01 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.07 GBytes  9.19 Gbits/sec    0   1.63 MBytes
[  5]   1.00-2.00   sec  1.01 GBytes  8.65 Gbits/sec    0   1.63 MBytes
[  5]   2.00-3.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.72 MBytes
[  5]   3.00-4.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.72 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.72 MBytes
[  5]   5.00-6.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.81 MBytes
[  5]   6.00-7.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.81 MBytes
[  5]   7.00-8.00   sec  1.01 GBytes  8.72 Gbits/sec    0   1.90 MBytes
[  5]   8.00-9.00   sec  1.01 GBytes  8.64 Gbits/sec    0   1.90 MBytes
[  5]   9.00-10.00  sec  1.09 GBytes  9.40 Gbits/sec    0   1.90 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.7 GBytes  9.16 Gbits/sec    0             sender
```

#### pve01 as the server, pve03 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.10 GBytes  9.41 Gbits/sec    0   1.51 MBytes
[  5]   1.00-2.00   sec  1.09 GBytes  9.37 Gbits/sec   38   1.20 MBytes
[  5]   2.00-3.00   sec  1.09 GBytes  9.35 Gbits/sec    0   1.38 MBytes
[  5]   3.00-4.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.38 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.37 Gbits/sec    0   1.43 MBytes
[  5]   5.00-6.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.48 MBytes
[  5]   6.00-7.00   sec  1.05 GBytes  9.01 Gbits/sec    0   1.53 MBytes
[  5]   7.00-8.00   sec  1.02 GBytes  8.73 Gbits/sec    0   1.53 MBytes
[  5]   8.00-9.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.53 MBytes
[  5]   9.00-10.00  sec  1.04 GBytes  8.92 Gbits/sec    0   1.57 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.8 GBytes  9.24 Gbits/sec   38             sender
[  5]   0.00-10.00  sec  10.7 GBytes  9.23 Gbits/sec                  receiver
```

#### pve03 as the server, pve01 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.10 GBytes  9.42 Gbits/sec    0   1.49 MBytes
[  5]   1.00-2.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.57 MBytes
[  5]   2.00-3.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.57 MBytes
[  5]   3.00-4.00   sec  1.09 GBytes  9.39 Gbits/sec    0   1.57 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.64 MBytes
[  5]   5.00-6.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.64 MBytes
[  5]   6.00-7.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.64 MBytes
[  5]   7.00-8.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.73 MBytes
[  5]   8.00-9.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.73 MBytes
[  5]   9.00-10.00  sec  1.09 GBytes  9.40 Gbits/sec    0   1.73 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.9 GBytes  9.40 Gbits/sec    0             sender
```

#### pve02 as the server, pve03 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   967 MBytes  8.11 Gbits/sec    0   1.64 MBytes
[  5]   1.00-2.00   sec  1.02 GBytes  8.80 Gbits/sec    0   1.73 MBytes
[  5]   2.00-3.00   sec   998 MBytes  8.37 Gbits/sec    0   1.81 MBytes
[  5]   3.00-4.00   sec  1.09 GBytes  9.39 Gbits/sec    0   1.90 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.37 Gbits/sec    0   2.00 MBytes
[  5]   5.00-6.00   sec  1.07 GBytes  9.21 Gbits/sec    0   2.00 MBytes
[  5]   6.00-7.00   sec  1.04 GBytes  8.98 Gbits/sec    0   2.10 MBytes
[  5]   7.00-8.00   sec  1.08 GBytes  9.30 Gbits/sec    0   2.10 MBytes
[  5]   8.00-9.00   sec  1.07 GBytes  9.15 Gbits/sec    0   2.10 MBytes
[  5]   9.00-10.00  sec  1.01 GBytes  8.71 Gbits/sec    0   2.10 MBytes
```

#### pve03 as the server, pve02 as the client

```
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.09 GBytes  9.36 Gbits/sec    0   1.52 MBytes
[  5]   1.00-2.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.52 MBytes
[  5]   2.00-3.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.52 MBytes
[  5]   3.00-4.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   4.00-5.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   5.00-6.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   6.00-7.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   7.00-8.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   8.00-9.00   sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
[  5]   9.00-10.00  sec  1.09 GBytes  9.40 Gbits/sec    0   1.59 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.9 GBytes  9.39 Gbits/sec    0             sender
```

#### netstat

```
apt install -y net-tools

root@pve01:~# netstat -i | column -t
Kernel  Interface  table
Iface   MTU        RX-OK      RX-ERR  RX-DRP  RX-OVR  TX-OK      TX-ERR  TX-DRP  TX-OVR  Flg
eno1    1500       18264670   0       12945   0       16407529   0       0       0       BMRU
enp4s0  1500       292401924  0       26308   13201   295467564  0       0       0       BMRU
lo      65536      9580002    0       0       0       9580002    0       0       0       LRU
vmbr0   1500       755367     0       0       0       207239     0       0       0       BMRU
vmbr1   1500       125105288  0       391     0       117144199  0       0       0       BMRU

root@pve02:~# netstat -i | column -t
Kernel  Interface  table
Iface   MTU        RX-OK     RX-ERR  RX-DRP  RX-OVR  TX-OK     TX-ERR  TX-DRP  TX-OVR  Flg
eno3    1500       127093    0       3019    0       3483      0       0       0       BMRU
enp4s0  1500       21402110  0       3060    0       20794644  0       0       0       BMRU
lo      65536      72        0       0       0       72        0       0       0       LRU
vmbr0   1500       123269    0       0       0       2984      0       0       0       BMRU
vmbr1   1500       6439529   0       64      0       5243399   0       0       0       BMRU

root@pve03:~# netstat -i | column -t
Kernel  Interface  table
Iface   MTU        RX-OK     RX-ERR  RX-DRP  RX-OVR  TX-OK     TX-ERR  TX-DRP  TX-OVR  Flg
eno1    1500       126784    0       3058    0       2705      0       0       0       BMRU
enp4s0  1500       30097539  0       3079    0       20884835  0       0       0       BMRU
lo      65536      444       0       0       0       444       0       0       0       LRU
vmbr0   1500       122900    0       0       0       2646      0       0       0       BMRU
vmbr1   1500       6869489   0       64      0       5548860   0       0       0       BMRU
```

#### ping test

```
root@pve01:~# ping 10.6.0.51
PING 10.6.0.51 (10.6.0.51) 56(84) bytes of data.
64 bytes from 10.6.0.51: icmp_seq=1 ttl=64 time=0.248 ms
64 bytes from 10.6.0.51: icmp_seq=2 ttl=64 time=0.196 ms
64 bytes from 10.6.0.51: icmp_seq=3 ttl=64 time=0.196 ms
64 bytes from 10.6.0.51: icmp_seq=4 ttl=64 time=0.194 ms

root@pve01:~# ping 10.6.0.52
PING 10.6.0.52 (10.6.0.52) 56(84) bytes of data.
64 bytes from 10.6.0.52: icmp_seq=1 ttl=64 time=0.263 ms
64 bytes from 10.6.0.52: icmp_seq=2 ttl=64 time=0.194 ms
64 bytes from 10.6.0.52: icmp_seq=3 ttl=64 time=0.198 ms
64 bytes from 10.6.0.52: icmp_seq=4 ttl=64 time=0.201 ms

root@pve02:~# ping 10.6.0.50
PING 10.6.0.50 (10.6.0.50) 56(84) bytes of data.
64 bytes from 10.6.0.50: icmp_seq=1 ttl=64 time=0.236 ms
64 bytes from 10.6.0.50: icmp_seq=2 ttl=64 time=0.219 ms
64 bytes from 10.6.0.50: icmp_seq=3 ttl=64 time=0.182 ms
64 bytes from 10.6.0.50: icmp_seq=4 ttl=64 time=0.178 ms

root@pve02:~# ping 10.6.0.52
PING 10.6.0.52 (10.6.0.52) 56(84) bytes of data.
64 bytes from 10.6.0.52: icmp_seq=1 ttl=64 time=0.224 ms
64 bytes from 10.6.0.52: icmp_seq=2 ttl=64 time=0.236 ms
64 bytes from 10.6.0.52: icmp_seq=3 ttl=64 time=0.189 ms
64 bytes from 10.6.0.52: icmp_seq=4 ttl=64 time=0.222 ms

root@pve03:~# ping 10.6.0.50
PING 10.6.0.50 (10.6.0.50) 56(84) bytes of data.
64 bytes from 10.6.0.50: icmp_seq=1 ttl=64 time=0.194 ms
64 bytes from 10.6.0.50: icmp_seq=2 ttl=64 time=0.198 ms
64 bytes from 10.6.0.50: icmp_seq=3 ttl=64 time=0.180 ms
64 bytes from 10.6.0.50: icmp_seq=4 ttl=64 time=0.169 ms
64 bytes from 10.6.0.50: icmp_seq=5 ttl=64 time=0.218 ms

root@pve03:~# ping 10.6.0.51
PING 10.6.0.51 (10.6.0.51) 56(84) bytes of data.
64 bytes from 10.6.0.51: icmp_seq=1 ttl=64 time=0.194 ms
64 bytes from 10.6.0.51: icmp_seq=2 ttl=64 time=0.202 ms
64 bytes from 10.6.0.51: icmp_seq=3 ttl=64 time=0.195 ms
64 bytes from 10.6.0.51: icmp_seq=4 ttl=64 time=0.207 ms
64 bytes from 10.6.0.51: icmp_seq=5 ttl=64 time=0.204 ms
```

## Tuning for low latency

Install tuned

```bash
apt install -y tuned tuned-utils
```

Listing tuned profiles

```bash
tuned-adm list
```

Show the active profile

```bash
cat /etc/tuned/active_profile
```

Enable the network-latency profile, then reboot

```bash
tuned-adm profile network-latency
reboot
```

After rebooting, confirm the active profile is working

```bash
turbostat sleep 5
```

## Configure an HA Group
## Decision

The change that we're proposing or have agreed to implement.

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
