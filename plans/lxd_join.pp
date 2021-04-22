# @summary Join one or more nodes to a bootstrapped cluster node.
# @param bootstrap_node A cluster member to join to. Must have cert on disk.
# @param join_nodes A list of nodes to join to LXD cluster
# @param cert_path Absolute path to cert on bootstrap_node
plan lab::lxd_join (
  TargetSpec $bootstrap_node = ['alpha'],
  TargetSpec $join_nodes = ['beta'],
  String $cert_path = '/var/snap/lxd/common/lxd/server.crt',
) {
  $cert_result = run_task('lab::mangle_cert', $bootstrap_node, 'cert_path' => $cert_path)
  # out::message($cert_result)
  $certificate = $cert_result[0].value['_output']
  # out::message($certificate)
  $preseed = epp('lab/joiner.yaml',  'server_name' => 'beta', 'certificate' => $certificate)
  write_file($preseed, '/tmp/join.yaml', $join_nodes)
  $result = run_command('cat /tmp/join.yaml | lxd init --preseed', $join_nodes, _run_as => 'root')

  return $result
}
