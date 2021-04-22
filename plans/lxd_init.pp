# @summary A plan created with bolt plan new.
# @param bootstrap_node The initial node to bootstrap LXD
# @param join_nodes A list of nodes to join to LXD cluster
plan demo::lxd_init (
  TargetSpec $bootstrap_node = ['alpha'],
  Option[TargetSpec] $join_nodes = ['beta'],
) {
  $preseed = epp('demo/preseed.yaml', {})
  #TODO: find a way to bootstrap another cluster node. Where are the certs on the bootstrap node
  # /var/snap/lxd/common/lxd/server.crt
  write_file($preseed, '/tmp/preseed.yaml', $bootstrap_node)
  $result = run_command('cat /tmp/preseed.yaml | lxd init --preseed', $bootstrap_node, _run_as => 'root')

  # $command_result = run_command('lxd init --auto --trust-password=demo --network-address=0.0.0.0', $bootstrap_node, _run_as => 'root')
  return $result
}
