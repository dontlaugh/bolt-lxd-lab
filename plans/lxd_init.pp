# @summary A plan created with bolt plan new.
# @param bootstrap_node The initial node to bootstrap LXD
plan lab::lxd_init (
  TargetSpec $bootstrap_node = ['alpha'],
) {
  $preseed = epp('lab/preseed.yaml', {})
  write_file($preseed, '/tmp/preseed.yaml', $bootstrap_node)
  $result = run_command('cat /tmp/preseed.yaml | lxd init --preseed', $bootstrap_node, _run_as => 'root')

  return $result
}
