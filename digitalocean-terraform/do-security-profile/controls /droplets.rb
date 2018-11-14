control 'only use allowed images' do
  title 'verify that only droplets are located in ams and run ubuntu'
  only_if { digitalocean_droplets.exists? }
  
  digitalocean_droplets.id.each { |id| 
    describe digitalocean_droplet(id: id) do
      it { should exist }
      its('image') { should eq 'ubuntu-16-04-x64' }
      its('region') { should eq 'ams3' }
      its('size') { should eq 's-1vcpu-1gb' }
    end
  }
end