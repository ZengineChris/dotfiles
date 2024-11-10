# Local Development Setup


## Install lima

## Create the vm

## Use the docker in lima as context
``` shell
docker context create lima-default --docker "host=unix://${HOME}/.lima/default/sock/docker.sock"
docker context use lima-default


```
https://docs.dagger.io/integrations/nerdctl/


## Create a local registry 

``` shell
docker run -d --restart=always -p "0.0.0.0:5000:5000"  --name registry registry
```


## Set the Kube editor

```shell
export KUBE_EDITOR="nvim -m"
```
