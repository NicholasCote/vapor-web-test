# VAPOR web application testing

I got the container to build and use the NVIDIA GPU for OpenGL with the following command

`docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all -
p 5000:5000 --runtime=nvidia -e ENV_NAME=vapor ncote/vapor-test`

## Basic container for osgl test

I was able to get this to report everything required for OpenGL by running:

`docker run -e NVIDIA_DRIVER_CAPABILITIES=all --runtime=nvidia ncote/osgl-test`

## K3s setup that worked

```
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v0.15.0/deployments/static/nvidia-device-plugin.yml
kubectl patch daemonset -n kube-system nvidia-device-plugin-daemonset --type='json'   -p='[{"op": "add", "path": "/spec/template/spec/runtimeClassName", "value": "nvidia"}]'
sudo cp /var/lib/rancher/k3s/agent/etc/containerd/config.toml /var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl
sudo vi /var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl

# Add default_runtime_name="nvidia" to the file like so:
[plugins."io.containerd.grpc.v1.cri".containerd]
  default_runtime_name = "nvidia"

helm install --wait nvidiagpu \
    -n gpu-operator --create-namespace \
    --set toolkit.env[0].name=CONTAINERD_CONFIG \
    --set toolkit.env[0].value=/var/lib/rancher/k3s/agent/etc/containerd/config.toml \
    --set toolkit.env[1].name=CONTAINERD_SOCKET \
    --set toolkit.env[1].value=/run/k3s/containerd/containerd.sock \
    --set toolkit.env[2].name=CONTAINERD_RUNTIME_CLASS \
    --set toolkit.env[2].value=nvidia \
    --set toolkit.env[3].name=CONTAINERD_SET_AS_DEFAULT \
    --set-string toolkit.env[3].value=true \
    nvidia/gpu-operator
```