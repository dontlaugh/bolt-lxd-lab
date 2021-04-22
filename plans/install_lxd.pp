# @summary Install lxd with snap
# @param targets The targets to install LXD on.
plan lab::install_lxd (
  TargetSpec $targets = ['alpha', 'beta']
) {
  run_command('apt-get install snapcraft -y', $targets, _run_as => 'root')
  run_command('snap install lxd', $targets, _run_as => 'root')
}
