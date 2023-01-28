image=${args[image]}
builder=${args[--builder]}

CT=$(podman run -itd ${builder} /bin/sh)
podman exec $CT bash -c "/cnb/lifecycle/rebaser ${image}" 1>&2
podman exec $CT bash -c "cat /layers/report.toml"
podman stop $CT > /dev/null
podman rm $CT > /dev/null
