module VirtualMonkey
  module Runner
    class IptablesRunner
      include VirtualMonkey::Mixin::DeploymentBase
      include VirtualMonkey::Mixin::Iptables
      include VirtualMonkey::Mixin::Chef
 
      # lookup all the RightScripts that we will want to run
      def lookup_scripts
       scripts = [
                   [ 'firewall_enable', 'rs_utils::firewall_enable' ],
                   [ 'firewall_rule' , 'rs_utils::firewall_rule' ]
                ]
  
        st = ServerTemplate.find(resource_id(s_one.server_template_href))
        load_script_table(st,scripts)
     end
 
    end
  end
end
