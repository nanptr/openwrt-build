# ImmortalWrt NanoPi R6C Builder

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

GitHub Actions based ImmortalWrt build for `FriendlyARM NanoPi R6C`.

## Build Target
- Source: `immortalwrt/immortalwrt`
- Branch: `openwrt-24.10`
- Target: `rockchip/armv8`
- Device: `friendlyarm_nanopi-r6c`

## Included Packages
- `luci`
- `luci-app-homeproxy`
- `luci-app-dockerman`
- `luci-app-zerotier`
- `docker`
- `dockerd`
- `docker-compose`
- `zerotier`

## GitHub Actions
- Workflow: `.github/workflows/build-immortalwrt.yml`
- Trigger: `workflow_dispatch` or `repository_dispatch`
- Release target: GitHub Releases
- Default LAN IP: `192.168.10.1`

## Secrets
- No custom Actions secret is required for the default build and release flow.
- Release publishing uses the built-in `GITHUB_TOKEN`.
- If you later add remote debugging back, that may require extra secrets.

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
