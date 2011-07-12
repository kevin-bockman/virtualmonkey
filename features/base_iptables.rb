  set :runner, VirtualMonkey::Runner::IptablesRunner

before do
  #@runner.stop_all
  @runner.chef_download_once_lookup_scripts
  @runner.launch_all
  @runner.wait_for_all("operational")
  @port = "1"
end

test "default" do
  @runner.check_monitoring
  @runner.reboot_all
  @runner.wait_for_all("operational")
  @runner.check_monitoring
#  @runner.run_logger_audit
end

test "iptables_any_ip" do
  @runner.test_firewall_rule("any", @port)
  @runner.test_firewall_rule("0.0.0.0", @port)
end

test "iptables_specific_ip" do
  @runner.test_firewall_rule("1.2.3.4", @port)
end

test "iptables_enable" do
  @runner.test_firewall_enable
end
