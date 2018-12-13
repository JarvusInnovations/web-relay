pkg_name=relay
pkg_origin=emergence
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('MIT')
pkg_version=1.0.0
pkg_svc_user=root
pkg_svc_group=$pkg_svc_user
pkg_svc_run="traefik --configfile=${pkg_svc_config_path}/traefik.toml"
pkg_deps=(
  core/traefik
)

do_build() {
  return 0
}

do_install() {
  return 0
}
