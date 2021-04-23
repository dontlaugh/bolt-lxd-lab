# @summary Configure OVN mesh network
# @param targets The targets to run on.
plan lab::configure_ovn (
  TargetSpec $targets,
  String $local_address,
  Optional[String] $bootstrap_server_address = undef,
) {
  $ovn = epp('lab/ovn-central', {
    'local_address' => $local_address,
    'bootstrap_server_address' => $bootstrap_server_address,
    })
  write_file($ovn, '/etc/default/ovn-central', $targets, _run_as => 'root')
}
