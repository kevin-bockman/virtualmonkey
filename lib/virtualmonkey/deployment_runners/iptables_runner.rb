module VirtualMonkey
  module Runner
    class IptablesRunner
      include VirtualMonkey::Mixin::DeploymentBase
      include VirtualMonkey::Mixin::Iptables
      include VirtualMonkey::Mixin::Chef
 
      # lookup all the RightScripts that we will want to run
      def lookup_scripts
       scripts = [
                   [ 'firewall_enable', 'rs_utils::setup_firewall' ],
                   [ 'firewall_rule' , 'rs_utils::setup_firewall_rule' ]
#                   [ 'firewall_close' , '::do_firewall_close' ],
#                   [ 'firewall_open' , '::do_firewall_open' ],
#                   [ 'firewall_request_close' , '::do_firewall_request_close' ],
#                   [ 'firewall_request_open' , '::do_firewall_request_open' ]
               ]
  
        st = ServerTemplate.find(resource_id(s_one.server_template_href))
        load_script_table(st,scripts)
     end
 
    end
  end
end
