# OpenWrt x64 / ImmortalWrt NanoPi R6C

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

GitHub Actions based full source build workflow for official `OpenWrt x64` and `ImmortalWrt FriendlyARM NanoPi R6C` devices.

## Build Target
- x64 source: official OpenWrt source tree
- x64 source branch: selected automatically from the OpenWrt stable version series
- x64 preferred release selector: `openwrt-version.txt`
- R6C source: official ImmortalWrt source tree
- R6C source branch: selected automatically from the ImmortalWrt stable version series
- R6C preferred release selector: `immortalwrt-version.txt`
- x64 target: `x86/64`
- x64 device: `generic`
- R6C target: `rockchip/armv8`
- R6C device: `friendlyarm_nanopi-r6c`
- Rootfs partsize: `1024 MB`

## Build Config
- x64 main config: `configs/openwrt-x64.config`
- R6C main config: `configs/iwrt-nanopi-r6c.config`
- x64 custom files: `files-x64/`
- R6C custom files: `files/`
- Workflow: `.github/workflows/build-immortalwrt.yml` with matrix builds for OpenWrt x64 and ImmortalWrt R6C

## Included Features
- LuCI on `nginx` via `luci-ssl-nginx`
- `docker`, `dockerd`, `docker-compose`
- `coremark` on x64 via `sbwml/openwrt_pkgs`
- Docker cgroup compatibility options enabled in kernel config
- `zerotier` on both targets
- `OpenWrt-momo` on x64 for sing-box transparent proxy
- `luci-app-zerotier` on x64 via `sbwml/openwrt_pkgs`
- `luci-theme-argon` on x64
- `luci-app-diskman` on R6C
- `luci-app-homeproxy` on R6C
- `luci-app-dockerman`
- `luci-app-ttyd`
- `kmod-rtc-pcf8563` on R6C, `hwclock` on both targets
- Storage utilities for NVMe, partitioning, and ext4 management

## Custom Files
- x64: `files-x64/etc/uci-defaults/99-x64-defaults`
- x64 default LAN IP: `192.168.10.1`
- R6C: `files/etc/uci-defaults/99-nanopi-r6c-defaults`
- R6C default LAN IP: `192.168.11.1`

## GitHub Actions
- Workflow: `.github/workflows/build-immortalwrt.yml`
- Trigger: `workflow_dispatch` and automatic rebuild when `openwrt-version.txt`, `immortalwrt-version.txt`, build config, or custom files change
- Upstream checker: `.github/workflows/check-upstream-release.yml`
- Schedule: daily, only commits when a new stable OpenWrt or ImmortalWrt release is detected
- Release target: GitHub Releases
- One release contains both the x64 and R6C firmware assets
- Release asset names are normalized as `<device>-<original filename>`

## Secrets
- No custom Actions secret is required for the default build and release flow.
- Release publishing uses the built-in `GITHUB_TOKEN`.

## Notes
- This repository now builds full firmware images instead of using `ImageBuilder`, so kernel options can be changed together with package selection.
- The build workflow selects `openwrt-24.10` for `24.*` releases and `openwrt-25.12` for `25.*` releases for both upstreams.
- Docker support depends on the full build path because the x64 and NanoPi R6C images need Docker-related cgroup kernel options, not just extra packages.
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
