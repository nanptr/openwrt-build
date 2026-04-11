# ImmortalWrt NanoPi R6C ImageBuilder

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

GitHub Actions based `ImageBuilder` workflow for `FriendlyARM NanoPi R6C`.

## Build Target
- Source: official ImmortalWrt `ImageBuilder`
- Version source: `immortalwrt-version.txt`
- Target: `rockchip/armv8`
- Profile: `friendlyarm_nanopi-r6c`
- Rootfs partsize: `1024 MB`

## Included Packages
- `luci`
- `luci-app-homeproxy`
- `luci-app-dockerman`
- `luci-app-ttyd`
- `luci-app-zerotier`
- `luci-i18n-base-zh-cn`
- `luci-i18n-homeproxy-zh-cn`
- `luci-i18n-dockerman-zh-cn`
- `luci-i18n-ttyd-zh-cn`
- `luci-i18n-zerotier-zh-cn`
- `docker`
- `dockerd`
- `docker-compose`
- `zerotier`
- `cgroupfs-mount`
- `block-mount`
- `e2fsprogs`
- `fdisk`
- `parted`
- `nvme-cli`
- `smartmontools`

## Custom Files
- `files/etc/uci-defaults/99-nanopi-r6c-defaults`
- Default LAN IP: `192.168.10.1`

## GitHub Actions
- Workflow: `.github/workflows/build-imagebuilder.yml`
- Trigger: `workflow_dispatch` and automatic rebuild when `immortalwrt-version.txt` changes
- Upstream checker: `.github/workflows/check-upstream-release.yml`
- Schedule: every 6 hours, only commits when a new stable ImmortalWrt release is detected
- Release target: GitHub Releases

## Secrets
- No custom Actions secret is required for the default build and release flow.
- Release publishing uses the built-in `GITHUB_TOKEN`.

## Notes
- This branch is intended to validate whether `ImageBuilder` can package `docker` successfully by increasing `ROOTFS_PARTSIZE`.
- `imagebuilder-packages.txt` controls the package list embedded into the firmware image.
- The current package set also prepares for SSD partitioning, ext4 formatting, SMART checks, and a LuCI web terminal.

## Credits

- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [immortalwrt](https://github.com/immortalwrt/immortalwrt)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)


## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
