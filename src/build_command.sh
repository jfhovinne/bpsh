image=${args[image]}
src=${args[--path]}
builder=${args[--builder]}

CT=$(podman run -itd ${builder} /bin/sh)
podman cp $src $CT:/src
podman exec $CT bash -c "/cnb/lifecycle/creator -app=/src ${image}" 1>&2
podman exec $CT bash -c "cat /layers/report.toml"
podman stop $CT > /dev/null
podman rm $CT > /dev/null
