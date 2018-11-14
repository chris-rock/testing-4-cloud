describe http('http://0.0.0.0/') do
  its('status') { should eq 200 }
  its('body') { should match /<title>InSpec landing<\/title>/ }
end