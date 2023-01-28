image=${args[image]}
builder=${args[--builder]}
authfile=${args[--authfile]}

CT=$(podman run -itd ${builder} /bin/sh)
if [[ -n ${authfile} ]]; then
  podman exec $CT bash -c "mkdir -p /home/cnb/.docker"
  podman cp $authfile $CT:/home/cnb/.docker/config.json
fi
podman exec $CT bash -c "/cnb/lifecycle/rebaser ${image}" 1>&2
podman exec $CT bash -c "cat /layers/report.toml"
podman stop $CT > /dev/null
podman rm $CT > /dev/null
