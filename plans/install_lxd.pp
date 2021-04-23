# @summary Install lxd with snap
# @param targets The targets to install LXD on.
plan lab::install_lxd (
  TargetSpec $targets = ['alpha', 'beta']
) {
  run_command('apt-get install snapcraft ovn-central ovn-host -y', $targets, _run_as => 'root')
  run_command('snap install lxd', $targets, _run_as => 'root')

  run_plan('lab::configure_ovn', 'alpha', local_address => '172.100.10.2')
  run_plan('lab::configure_ovn', 'beta', local_address => '172.100.10.3', bootstrap_server_address => '172.100.10.2')

  # Wipe existing ovn DBs, and restart.
  run_command('rm /var/lib/ovn/*', $targets, _run_as => 'root')
  run_command('systemctl restart ovn-central', $targets, _run_as => 'root')
}
