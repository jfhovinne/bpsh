image=${args[image]}
src=${args[--path]}
builder=${args[--builder]}
authfile=${args[--authfile]}
eval "envs=(${args[--env]})"

CT=$(podman run -itd ${builder} /bin/sh)
podman cp $src $CT:/src
if [[ -n ${authfile} ]]; then
  podman exec $CT bash -c "mkdir -p /home/cnb/.docker"
  podman cp $authfile $CT:/home/cnb/.docker/config.json
fi
for env in "${envs[@]}"; do
    IFS='=' read -r key value <<< "$env"
    if [[ "$key" != "" && "$value" != "" ]]; then
        tmp=$(mktemp)
        echo -n "$value" > $tmp
        podman cp $tmp $CT:/platform/env/$key
        rm $tmp
    fi
done
podman exec $CT bash -c "/cnb/lifecycle/creator -app=/src ${image}" 1>&2
podman exec $CT bash -c "cat /layers/report.toml"
podman stop $CT > /dev/null
podman rm $CT > /dev/null
