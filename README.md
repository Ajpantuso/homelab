# TODO

- Cleanup `.mise.toml` and use sources/outputs and checksums to avoid unneccessary downloads
- Should verify signatures and checksums wherever possible
- Should record download timestamps and compare against last-modified header
- Should add local tmp dir
- Add ansible role for hypervisors
- Add PVC backups
  - https://github.com/vmware-tanzu/helm-charts/tree/main/charts/velero
  - https://github.com/minio/minio
  - https://velero.io/docs/main/contributions/minio/
- Setup ssh CA and certificates
- Automate DHCP/DNS management

## Parking Lot

- Add replicated storage (See [Replicated Storage Poc](docs/replicated-storage-poc.md))
  - Depends on control plane migration

## Architecture

![homelab_architecture](docs/assets/homelab_high-level_architecture.png)

## References

- https://docs.fedoraproject.org/en-US/fedora-coreos/
- https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-raspberry-pi4/
- https://coreos.github.io/butane/
- https://github.com/intel/intel-device-plugins-for-kubernetes/blob/main/cmd/gpu_plugin/README.md
- https://github.com/intel/intel-device-plugins-for-kubernetes/tree/main/cmd/gpu_plugin#testing-and-demos
- https://github.com/boliu83/ipxe-boot-server
- https://meshcentral.com/docs/MeshCentral2UserGuide.pdf
- https://bash-prompt.net/guides/ssh-certificates/
- https://docs.opnsense.org/development/api.html
