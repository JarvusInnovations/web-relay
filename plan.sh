pkg_name=emergence-ingress
pkg_origin=emergence
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('MIT')
pkg_version=1.0.0
pkg_svc_user=root
pkg_svc_group=$pkg_svc_user
pkg_svc_run="nginx -c ${pkg_svc_config_path}/nginx.conf"
pkg_deps=(
  core/node
  core/nginx
)

do_build() {
  pushd "${PLAN_CONTEXT}" > /dev/null
  cp "build-config" "package.json" "package-lock.json" "${CACHE_PATH}/"
  popd > /dev/null


  pushd "${CACHE_PATH}" > /dev/null
  build_line "Installing dependencies with NPM"
  npm install
  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  popd > /dev/null
}
