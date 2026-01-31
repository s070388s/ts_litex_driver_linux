
include version.mk


.PHONY: all kernel user clean dkms-conf dkms dkms-remove dkms-install

all: kernel util

kernel:
	$(MAKE) -C kernel

user:
	$(MAKE) -C user

clean:
	$(MAKE) -C kernel clean
	$(MAKE) -C user clean

dkms-conf: kernel/dkms.conf
kernel/dkms.conf: dkms.conf.in
	@echo "Generating dkms.conf with version $(DRIVER_VERSION)"
	@sed "s/MAKE_VERSION/$(DRIVER_VERSION)/g" dkms.conf.in > kernel/dkms.conf

dkms: kernel/dkms.conf
	dkms add ./kernel
	dkms build -m thunderscope -v $(DRIVER_VERSION)
	dkms install -m thunderscope -v $(DRIVER_VERSION)

dkms-remove:
	dkms remove -m thunderscope -v $(DRIVER_VERSION) --all

udev-install:
	@cp 70-thunderscope.rules /etc/udev/rules.d && \
	udevadm control --reload-rules && udevadm trigger