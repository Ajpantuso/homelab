# Replicated Storage POC

## ignition/k0s.bu

Load `nvme-tcp` kernel module and add hugepage space

```yaml
storage:
  disks:
  - device: /dev/sda
    wipe_table: true
  # drop all of this configuration
  #   partitions:
  #   - size_mib: 0
  #     start_mib: 0
  #     wipe_partition_entry: true
  #     label: ebs
  # filesystems:
  # - path: /var/openebs/local
  #   device: /dev/disk/by-partlabel/ebs
  #   format: ext4
  #   wipe_filesystem: true
  #   with_mount_unit: true
  files:
  - path: /etc/modules-load.d/nvme-tcp.conf
    contents:
      inline: |
        nvme-tcp
  - path: /etc/sysctl.d/51-vm.conf
    contents:
      inline: |
        vm.nr_hugepages = 1024
```

## k0s/k0s.Cluster.patch.yaml

Update openebs charts and disable local engines

```yaml
spec:
  k0s:
    config:
      spec:
        extensions:
          helm:
            repositories:
            - name: openebs
              url: https://openebs.github.io/openebs
            charts:
            - name: openebs
              chartname: openebs/openebs
              version: "4.0.1"
              namespace: openebs-system
              order: 1
              values: |
                engines:
                  local:
                    lvm:
                      enabled: false
                    zfs:
                      enabled: false
```

May also require [Mayastore Extensions](https://github.com/openebs/mayastor-extensions/tree/develop/chart)

## .mise.toml

Generate diskpools from host device information

```toml
[tasks."apply:diskpools"]
run = """
    #! /usr/bin/env bash
    for host in $(echo ${K0SCTL_HOSTS}); do
        dev=$(ssh labadm@${host} -i ${K0SCTL_IDENTITY_PATH} "lsblk -Sn -o ID_LINK")

        kubectl apply -f - << EOF
        apiVersion: openebs.io/v1beta2
        kind: DiskPool
        metadata:
          name: ${host}-pool
          namespace: openebs
        spec:
          node: ${host}
          disks: [${dev}]
EOF
    done
"""
```

## Firewall

Open up ports 10124, 8420, 4421 https://github.com/coreos/fedora-coreos-tracker/blob/main/Design.md#firewall-management
> Should be open by default on Fedora CoreOS

## Node Labels

Add node labels `openebs.io/engine=mayastor` to all nodes with diskpools

## References

- https://openebs.io/docs/user-guides/replicated-storage-user-guide/replicated-pv-mayastor/rs-installation
- https://openebs.io/docs/user-guides/replicated-storage-user-guide/replicated-pv-mayastor/rs-configuration
