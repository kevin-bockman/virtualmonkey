module VirtualMonkey
  module Mixin
    module Iptables

      def check_iptables_rules(port, ip = "0.0.0.0")
        s_one.spot_check_command("iptables --list FWR --numeric | grep -E '#{ip}.* dpt:#{port} '")
      end

      def test_firewall_rule_ip_port(ip, port)
        #ip = "1.2.3.5"
        #port = "1"

	run_script("firewall_rule", s_one, {"rs_utils/firewall/rule/enable" => "text:true", "rs_utils/firewall/rule/ip_address" => "text:#{ip}", "rs_utils/firewall/rule/port" => "text:#{port}"})
        res = check_iptables_rules(port, ip)
        raise "Test failed to add by IP/port" unless res[:status] == 0

        run_script("firewall_rule", s_one, {"rs_utils/firewall/rule/enable" => "text:false", "rs_utils/firewall/rule/ip_address" => "text:#{ip}", "rs_utils/firewall/rule/port" => "text:#{port}"})
        res = check_iptables_rules(port, ip)
        raise "Test failed to delete by IP/port" unless res[:status] == 1
      end

      def test_firewall_rule_port(port)
        #port = "1"

        run_script("firewall_rule", s_one, {"rs_utils/firewall/rule/enable" => "text:true", "rs_utils/firewall/rule/ip_address" => "text:any", "rs_utils/firewall/rule/port" => "text:#{port}"})
        res = check_iptables_rules(port)
        raise "Test failed to add by port" unless res[:status] == 0

        run_script("firewall_rule", s_one, {"rs_utils/firewall/rule/enable" => "text:false", "rs_utils/firewall/rule/ip_address" => "text:any", "rs_utils/firewall/rule/port" => "text:#{port}"})
        res = check_iptables_rules(port)
        raise "Test failed to delete by port" unless res[:status] == 1
      end
 
      def test_firewall_enable
        run_script("firewall_enable", s_one, {"rs_utils/firewall/enabled" => "text:true" })
        res = probe(s_one, 'service iptables status')
        raise "IPTables service not running." unless res

        run_script("firewall_enable", s_one, {"rs_utils/firewall/enabled" => "text:false" })
        res = s_one.spot_check_command("service iptables status")
        raise "Failed to disable IPtables service." unless res[:status] == 1
      end

    end
  end
end
