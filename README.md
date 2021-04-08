# bolt-lxd-demo

Explore configuring virtual machines and LXD containers with Puppet Bolt.


```
bolt plan new demo::install_lxd --pp
bolt plan new demo::lxd_init --pp
```

## Set Up LXD

First we set up LXD in our two VMs.

```
bolt plan run -t vms demo::install_lxd
bolt plan run -t vms demo::lxd_init
```

After LXD is installed, we add our two remotes from **outside** the VMs. 

Accept the certificate. The remote trust password is "demo" for both remotes.

``` sh
lxc remote add alpha 127.0.0.1:2443
lxc remote add beta  127.0.0.1:3443
```

If successful, list all your remotes with `lxc remote ls`.

## Launch Containers

Launch an ubuntu container on each remote.

``` sh
lxc remote switch alpha
lxc launch ubuntu/20.10 one
lxc remote switch beta
lxc launch ubuntu/20.10 two
```

TODO https://discuss.linuxcontainers.org/t/how-to-use-preesed-to-join-to-existing-cluster/9320/5

