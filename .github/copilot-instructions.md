# AI Agent Instructions for Pseudo Design Linux

## Project Overview
**Pseudo Design Linux** is a Yocto/BitBake-based embedded Linux distribution system supporting multiple Xilinx and ARM-based boards (Cora-Z7, Raspberry Pi 5, ZCU102). The project uses `kas` for build orchestration and manages a complex multi-layer meta-layer structure.  Learn more about kas at [kas.readthedocs.io](https://kas.readthedocs.io/en/latest/).

## Architecture

### Layer Structure
- **meta-pd-core**: Core recipes, distro configuration (pd-linux), images, and packagegroups
- **meta-pd-xilinx**: Xilinx hardware-specific layers (machine configs for cora-z7, zcu102)
- **meta-raspberrypi**: Raspberry Pi BSP layer (fetched via KAS from agherzan/meta-raspberrypi)
- **Upstream layers**: openembedded-core, meta-openembedded, meta-xilinx (2025.1 release)

Layer priority in [meta-pd-core/conf/layer.conf](meta-pd-core/conf/layer.conf): `pseudo-design = "85"` (high priority for recipe overrides)

### Build Configuration Flow
1. **KAS files** The top-level kas contains files for each machine pseudo-design-linux supports.  
2. **Machine configs** (e.g., [meta-pd-xilinx/conf/machine/cora-z7.conf](meta-pd-xilinx/conf/machine/cora-z7.conf)) set hardware-specific defaults and device tree handling
3. **Distro config** [pd-linux.conf](meta-pd-core/conf/distro/pd-linux.conf) defines: linux-yocto 6.12, RPM packaging, Xilinx SDK support
4. **Image recipes** inherit from `core-image` and specify `IMAGE_INSTALL` packagegroups (see [pd-image-host.bb](meta-pd-core/recipes-core/images/pd-image-host.bb))
5. **Packagegroups** ([packagegroup-pd-host.bb](meta-pd-core/recipes-core/packagegroups/packagegroup-pd-host.bb)) define RDEPENDS for base packages (openvpn, etc.)

### Key Integrations
- **Xilinx hardware**: Requires `LICENSE_FLAGS_ACCEPTED = "xilinx"` in local.conf; auto-configures via meta-xilinx-core/meta-xilinx-bsp
- **Mender OTA**: Configured in kas file with MENDER_* variables; uses U-Boot and SD partitioning
- **Device trees**: Handled by external-hdf bbappend; IMAGE_BOOT_FILES filtered per-machine

## Critical Conventions

### Recipe Patterns
- **Append files** (.bbappend) override upstream recipes in higher-priority layers (e.g., [busybox_%.bbappend](meta-pd-core/recipes-core/busybox/busybox_%.bbappend))
- **Custom classes** (e.g., [image-types-pseudo-design.bbclass](meta-pd-core/classes/image-types-pseudo-design.bbclass)) define CONVERSIONTYPES and CONVERSION_CMD for image post-processing
- **BBClass inheritance**: `inherit packagegroup`, `inherit core-image` are standard; custom classes add image conversion logic

### Configuration Hierarchy
- Machine-specific overrides use `${MACHINE}` conditionals (see cora-z7.conf EXTRA_IMAGEDEPENDS, MACHINEOVERRIDES pattern)
- TODO markers in config files indicate intentional deferred refactoring (line 31 in cora-z7.conf)

### Distro Versioning
- Distro version: 5.0.14 (aligned with scarthgap Yocto branch)
- Image FSTYPES: wic.pseudo-design-sd (custom 256MB SD image format)
- Supported host distros: Ubuntu 20.04–24.04, Fedora 38–40, Debian 11–12, etc.

## Developer Workflows

### Building for a Target
```bash
# Source the kas configuration (from mybuild/)
kas shell kas/cora-z7.yml  # or raspberrypi5.yml
# Build the image
bitbake pd-image-host
```

### Adding a Recipe
1. Place .bb file in `meta-pd-*/recipes-core|bsp|connectivity`/
2. If overriding, use .bbappend in same layer with BBFILE_PRIORITY override
3. Declare COMPATIBLE_MACHINE or machine-specific EXTRA_IMAGEDEPENDS in distro/machine conf

### Debugging Image Contents
- IMAGE_INSTALL controls root packages
- RDEPENDS/RRECOMMENDS cascade through packagegroups
- Use `bitbake -g <image>` to generate dependency graphs

### WIC Customization
- WKS file: [pseudo-design-linux-sdcard.wks](meta-pd-core/wic/pseudo-design-linux-sdcard.wks)
- Custom conversions defined in bbclass; enable via IMAGE_FSTYPES

## Common Pitfalls

- **Layer ordering**: Recipe priority (BBFILE_PRIORITY) determines precedence; verify layer.conf includes
- **Machine vs Distro**: Machine configs (.conf) set hardware; distro sets software features (DISTRO_FEATURES)
- **License flags**: Xilinx recipes require LICENSE_FLAGS_ACCEPTED in local.conf (kas local_conf_header)
- **Append files**: Must reference the same variable names as upstream; typos silently fail

## Key Files Reference

| File | Purpose |
|------|---------|
| [kas/cora-z7.yml](kas/cora-z7.yml) | Build config: repos, Mender OTA, machine selection |
| [meta-pd-core/conf/distro/pd-linux.conf](meta-pd-core/conf/distro/pd-linux.conf) | Distro features, kernel version, toolchain |
| [meta-pd-xilinx/conf/machine/cora-z7.conf](meta-pd-xilinx/conf/machine/cora-z7.conf) | Cora-Z7 hardware (u-boot, device tree, boot files) |
| [meta-pd-core/recipes-core/images/pd-image-host.bb](meta-pd-core/recipes-core/images/pd-image-host.bb) | Root image; specifies packagegroup-pd-host |
| [meta-pd-core/classes/image-types-pseudo-design.bbclass](meta-pd-core/classes/image-types-pseudo-design.bbclass) | Custom SD image 256MB padding/truncation |
