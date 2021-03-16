# This is the structure of a simple plan. To learn more about writing
# Puppet plans, see the documentation: http://pup.pt/bolt-puppet-plans

# The summary sets the description of the plan that will appear
# in 'bolt plan show' output. Bolt uses puppet-strings to parse the
# summary and parameters from the plan.
# @summary A plan created with bolt plan new.
# @param targets The targets to run on.
plan demo::lxd_init (
  TargetSpec $targets = ["alpha", "beta"]
) {
  $command_result = run_command('lxd init --auto --trust-password=demo --network-address=0.0.0.0', $targets, _run_as => 'root')
  return $command_result
}
