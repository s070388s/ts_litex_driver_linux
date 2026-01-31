# Thunderscope LiteX Linux Driver and Library

This repo contains the Thunderscope Linux driver and litepcie library and test application.  This driver comes from the [LitePCIe LiteX core](https://github.com/enjoy-digital/litepcie) project, with some Thunderscope-specific modifications and optimizations.

## Manual Install

This driver may be manually built and installed using the provided makefile.  The module will build locally and then can be loaded to the kernel using `insmod`.

### Building

```bash
> make kernel
```

### Install

Before connecting the Thunderscope, install the driver and the udev rules.

```bash
> sudo make -C kernel install
> sudo make udev-install
```

### Removing

You may remove the driver with `rmmod`.

```bash
> sudo rmmod thunderscope
```

## DKMS Install

Kernel modules can be managed with `dkms`.  This will automatically rebuild sources for a kernel driver if a new kernel version is installed.

**Prerequisite:** Install `dkms` from your system's package manager.

### Install

To install the kernel module using DKMS:

```bash
> sudo make dkms
```

### Post-Install

If using dkms, you will also need to install the udev rules file to the appropriate directory.  This should be done manually, using the `make udev-install` target, or configuring the package (`.deb`, `.rpm`, `aur`, etc.) to do so.

```bash
> sudo make udev-install
```


### Remove

To remove the module from DKMS:

```bash
> sudo make dkms-remove
```


### DKMS Configuration Customization

If your system or distrobution requires changes to the provided dkms.conf, you can generate the default file with the `dkms-conf` target.

```bash
> make dkms-conf
```

The file `kernel/dkms.conf` can then be modified before running `make dkms` as needed.
