# TODO

- Configure k0s to use local containerd if possible
- Add probes to services
- Add requests/limits to services
- Add selinux context to services
- Secure Grafana and Prometheus (TLS + passwords)
- Add persistence for grafana and prometheus
- Add PVC backups
- Add replicated storage (See [Replicated Storage Poc](docs/replicated-storage-poc.md))

## IXPE Boot Parameters

```bash
set BASEURL http://pxe.ajphome.com/os/fedora/coreos/40.20240416.3.1/x86_64
kernel ${BASEURL}/k0s-live-kernel initrd=main ignition.firstboot ignition.platform.id=metal coreos.live.rootfs_url=${BASEURL}/k0s-live-rootfs.img
initrd --name main ${BASEURL}/k0s-live-initramfs.img
boot
```

## References

- https://docs.fedoraproject.org/en-US/fedora-coreos/
- https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-raspberry-pi4/
- https://coreos.github.io/butane/
- https://github.com/intel/intel-device-plugins-for-kubernetes/blob/main/cmd/gpu_plugin/README.md
- https://github.com/intel/intel-device-plugins-for-kubernetes/tree/main/cmd/gpu_plugin#testing-and-demos
- https://github.com/boliu83/ipxe-boot-server
