# bolt-lxd-lab

Explore configuring virtual machines and LXD containers with Puppet Bolt.

## Requirements

You must have Bolt version 3.4.0 or higher. That is when LXD support was
introduced. You also need Vagrant. Finally, you need the `lxc` command
line client, so you can talk to LXD clusters.

You should also have some basic knowledge of LXD.

## Getting Started

First, run `vagrant up`. Two Ubuntu virtual machines will launch. These
will **each be given 6 GB of RAM by default**. Adjust that via the 
Vagrantfile if you want to use less.

Next, we install LXD in our two VMs using the bolt plan located at
**plans/install_lxd.pp**. It's written in Puppet language. VS Code
has a very good extension for Puppet, so check it out.

```
bolt plan run lab::install_lxd
```

You can read the code, or you can get some basic information about
the plan with `bolt plan show lab::install_lxd`. It works for any
documented plan or task.

Now that we've installed LXD in our VMs, let's initialize one of 
them (alpha VM) as the cluster leader.

```
bolt plan run lab::lxd_init
```

Then we join the other node (beta) to create a two-node LXD cluster.

```
bolt plan run lab::lxd_join
```

The `lxd_join` plan extracted the cert from the alpha node bootstrapped in the 
`lxd_init` plan. A yaml configuration file was templated out, and uploaded to
the beta node. This was used to join beta to alpha and form the cluster.

We can see the uploaded file by running an ad hoc command.

```
bolt command run --target beta 'cat /tmp/join.yaml'
```

Bolt can help us download it as a backup, too.

```
bolt file download -t beta /tmp/join.yaml /tmp
```

We can also check that our clustering worked by running `lxc` inside the VMs.

```
bolt command run -t alpha,beta 'lxc cluster list' --run_as root
```

Root is required, because our ssh user isn't a member of the lxd group.

Let's fix that.

```
bolt command run -t alpha,beta "usermod -aG lxd $USER" --run_as root
```

## Configure lxc

To use the Bolt+LXD inventory integration, we need to configure a new LXD 
remote for our little lab cluster.

Accept the certificate. The remote trust password is "demo".

```
lxc remote add lab 172.100.10.2:8443
```

If successful, switch to our new remote and print the cluster members.

```
lxc remote switch lab
lxc cluster list
```

## Launch Containers

Remember the containers that were already listed in our inventory? Now it's
time to create them. They're called "one" and "two", and we'll use an
Ubuntu 20.10 base container image for both.

```
lxc launch ubuntu:20.10 one
lxc launch ubuntu:20.10 two
```

Now we can run a command inside both containers with bolt.

```
bolt command run -t one,two 'uptime'
```

Let's run another, but this time we can use our "containers" group. This is
defined in **inventory.yaml**, and aggregates targets "one" and "two".

```
bolt command run -t containers 'apt-get update'
```

## TODO

* Fix fan networking
* [Try something more complicated](https://sleeplessbeastie.eu/2020/10/07/how-to-install-kubernetes-on-lxd/)
