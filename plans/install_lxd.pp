# This is the structure of a simple plan. To learn more about writing
# Puppet plans, see the documentation: http://pup.pt/bolt-puppet-plans

# The summary sets the description of the plan that will appear
# in 'bolt plan show' output. Bolt uses puppet-strings to parse the
# summary and parameters from the plan.
# @summary A plan created with bolt plan new.
# @param targets The targets to run on.
plan demo::install_lxd (
  TargetSpec $targets = ["alpha", "beta"]
) {
  out::message("Hello from demo::install_lxd")
  run_command('apt-get install snapcraft -y', $targets, _run_as => 'root')
  run_command('snap install lxd', $targets, _run_as => 'root')
}
