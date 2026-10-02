# OpenWrt NanoPi R6C

[![LICENSE](https://img.shields.io/github/license/nanptr/openwrt-build.svg?style=flat-square&label=LICENSE)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/nanptr/openwrt-build.svg?style=flat-square&label=Stars&logo=github)](https://github.com/nanptr/openwrt-build/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/nanptr/openwrt-build.svg?style=flat-square&label=Forks&logo=github)](https://github.com/nanptr/openwrt-build/forks)

GitHub Actions based full source build workflow for `FriendlyARM NanoPi R6C`, based on the official OpenWrt source tree.

## Build Target
- Source: official OpenWrt source tree (`github.com/openwrt/openwrt`)
- Source branch: selected automatically from the OpenWrt stable version series
- Preferred release selector: `openwrt-version.txt`
- R6C target: `rockchip/armv8`
- R6C device: `friendlyarm_nanopi-r6c`
- Rootfs partsize: `1024 MB`

## Build Config
- R6C main config: `configs/openwrt-nanopi-r6c.config`
- R6C custom files: `files/`
- Workflow: `.github/workflows/build-openwrt.yml`

## Included Features
- LuCI on `nginx` via `luci-ssl-nginx`
- `docker`, `dockerd`, `docker-compose`
- `coremark`
- Docker cgroup compatibility options enabled in kernel config
- `dnsmasq-full`
- `luci-app-nikki` with `mihomo` (via the [OpenWrt-mihomo](https://github.com/morytyann/OpenWrt-mihomo) feed)
- `zerotier`
- `luci-app-diskman` (via [sbwml/luci-app-diskman](https://github.com/sbwml/luci-app-diskman))
- `luci-app-dockerman`
- `luci-app-ttyd` through the same-origin `/ttyd/` HTTPS reverse proxy
- `ddns-scripts` and common provider integrations
- Transparent proxy kernel modules: `kmod-tun`, `kmod-nf-socket`, `kmod-nft-socket`, `kmod-nft-tproxy`
- `kmod-rtc-pcf8563` (RTC via busybox `hwclock`)
- Storage utilities for NVMe, partitioning, and ext4 management

## Third-Party Package Sources
The build uses only the four official OpenWrt feeds (packages, luci, routing, telephony) plus one extra feed:

- `src-git nikki https://github.com/morytyann/OpenWrt-mihomo.git` — `luci-app-nikki` / `mihomo`

Additional packages are cloned directly into `package/new/` during the build:

- `luci-app-zerotier` — sparse checkout from [immortalwrt/luci](https://github.com/immortalwrt/luci) (not present in the official LuCI feed)
- `luci-app-diskman` — [sbwml/luci-app-diskman](https://github.com/sbwml/luci-app-diskman)
- `luci-app-ota` — [breeze303/luci-app-ota](https://github.com/breeze303/luci-app-ota)
- `zerotier` — replaced with the [sbwml](https://github.com/sbwml/feeds_packages_net_zerotier) variant

`luci-app-dockerman` and `luci-app-ttyd` come from the official LuCI feed.

## Custom Files
- R6C: `files/etc/uci-defaults/99-nanopi-r6c-defaults`
- R6C default LAN IP: `192.168.10.1`
- ttyd: loopback-only on `127.0.0.1:7681`, proxied by nginx at `/ttyd/`

## GitHub Actions
- Workflow: `.github/workflows/build-openwrt.yml`
- Trigger: `workflow_dispatch` and automatic rebuild when `openwrt-version.txt`, build config, or custom files change
- Upstream checker: `.github/workflows/check-upstream-release.yml`
- Schedule: every 2 days, only commits when a new stable OpenWrt release is detected
- Release target: GitHub Releases
- OTA metadata assets: `version.latest`, `version.index`, `fw.json`, and release changelog files are published alongside firmware images
- Release asset names are normalized as `<device>-<original filename>`

## Secrets
- No custom Actions secret is required for the default build and release flow.
- Release publishing uses the built-in `GITHUB_TOKEN`.

## Notes
- This repository builds full firmware images instead of using `ImageBuilder`, so kernel options can be changed together with package selection.
- The build workflow currently tracks the `openwrt-25.12` release series.
- LuCI OTA is wired to GitHub Releases `latest/download` for NanoPi R6C online upgrade checks, using `25.12.x-r<run_number>` style build keys so same-version rebuilds are still detected.
- Docker support depends on the full build path because the NanoPi R6C image needs Docker-related cgroup kernel options, not just extra packages.
- The firmware includes `nginx` as the LuCI web server and reverse-proxy entry point. The ttyd backend is not exposed directly to the LAN; set a root password after installation because the `/ttyd/` proxy does not inherit LuCI session authentication.
- This branch (`openwrt-official`) tracks official OpenWrt. The `main` branch tracks ImmortalWrt; the first switch between them should be a clean reflash, not a settings-preserving sysupgrade.

## Credits

- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)


## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
