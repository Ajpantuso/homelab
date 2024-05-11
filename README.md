# TODO

- Add udisks2 install to ignition
- Add ansible install to ignition
- Use ansible-pull to manage baremetal
  - Define roles/playbooks in this repo
  - Define systemd units to run ansible-pull via timer
  - Or execute webhooks from systemd on timer and run ansible-rulebook on kube
- Setup RPi's with Fedora CoreOS https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-raspberry-pi4/
- Setup Self-Signed CA for Traefik
- Secure Grafana and Prometheus (TLS + passwords)
- Add persistence for grafana and prometheus
- Add PVC backups
- Add explicit requests for IP's in service annotations
- Setup working PXE server (try again on RPi with [cobbler](https://cobbler.readthedocs.io/en/latest/index.html))
