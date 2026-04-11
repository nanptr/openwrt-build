# ImmortalWrt NanoPi R6C

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

GitHub Actions based full source build workflow for `FriendlyARM NanoPi R6C`.

## Build Target
- Source: official ImmortalWrt source tree
- Source branch: `openwrt-24.10`
- Preferred release selector: `immortalwrt-version.txt`
- Target: `rockchip/armv8`
- Device: `friendlyarm_nanopi-r6c`
- Rootfs partsize: `1024 MB`

## Build Config
- Main config: `configs/iwrt-nanopi-r6c.config`
- Custom files: `files/`
- Workflow: `.github/workflows/build-immortalwrt.yml`

## Included Features
- LuCI on `nginx` via `luci-ssl-nginx`
- `docker`, `dockerd`, `docker-compose`
- Docker cgroup compatibility options enabled in kernel config
- `zerotier`
- `luci-app-homeproxy`
- `luci-app-dockerman`
- `luci-app-ttyd`
- Storage utilities for NVMe, partitioning, and ext4 management

## Custom Files
- `files/etc/uci-defaults/99-nanopi-r6c-defaults`
- Default LAN IP: `192.168.10.1`

## GitHub Actions
- Workflow: `.github/workflows/build-immortalwrt.yml`
- Trigger: `workflow_dispatch` and automatic rebuild when `immortalwrt-version.txt`, build config, or custom files change
- Upstream checker: `.github/workflows/check-upstream-release.yml`
- Schedule: every 6 hours, only commits when a new stable ImmortalWrt release is detected
- Release target: GitHub Releases

## Secrets
- No custom Actions secret is required for the default build and release flow.
- Release publishing uses the built-in `GITHUB_TOKEN`.

## Notes
- This repository now builds full firmware images instead of using `ImageBuilder`, so kernel options can be changed together with package selection.
- Docker support depends on the full build path because the NanoPi R6C image needs Docker-related cgroup kernel options, not just extra packages.
- The firmware includes `nginx` as the LuCI web server and reverse-proxy entry point; site-specific `server` blocks are intended to be managed locally after deployment.

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
