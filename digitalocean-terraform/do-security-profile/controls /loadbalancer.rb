control 'only use https' do
  title 'verify that only https is used for load balancers'
  only_if { digitalocean_loadbalancers.exists? }

  digitalocean_loadbalancers.forwarding_rules.flatten.each { |rule|
    describe rule do
      its('entry_protocol') { should eq 'https' }
      its('entry_port') { should eq 443 }
    end
  }  
end

