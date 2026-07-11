# 🧊 Reproducible APT Install for DevContainers

This project uses a frozen Ubuntu APT snapshot for repeatable builds across environments.

## 🔐 Freeze and Save

To install packages and save the snapshot state:

```bash
./apt-install.sh --lock --packages-file ./shell/apt/base.packages
```

To install packages from lock file and snapshot:

```bash
./apt-install.sh --from-lock --snapshot $(cat snapshot.timestamp)
```
