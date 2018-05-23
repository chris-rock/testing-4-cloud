# encoding: utf-8

title 'sample gcp test section'

PROJECT_NUMBER = attribute('project_number', description: 'gcp project number')

control 'gcp-1' do
  impact 0.7
  title 'Check development project'
  describe google_project(project: PROJECT_NUMBER) do
    it { should exist }
    its('name') { should eq 'inspec-gcp' }
    its('project_number') { should cmp PROJECT_NUMBER }
    its('lifecycle_state') { should eq 'ACTIVE' }
  end
end

BUCKET = attribute('storage_bucket', description: 'gcp storage bucket identifier')

control 'gcp-2' do
  impact 0.3
  title 'Check that the storage bucket was created'
  describe google_storage_bucket(name: BUCKET) do
    it { should exist }
    its('storage_class') { should eq 'STANDARD' }
    its('location') { should eq 'EUROPE-WEST2' }
  end
end

INSTANCE_NAME = attribute('instance_name', description: 'gcp instance identifier')
ZONE = attribute('instance_zone', description: 'instance zone')

control 'gcp-3' do
  impact 0.5
  title 'Check the GCP instance'
  describe google_compute_instance(project: PROJECT_NUMBER, zone: ZONE, name: INSTANCE_NAME) do
    it { should exist }
    its('name') { should eq 'gcp-inspec-int-linux-vm' }
    its('machine_type') { should eq 'f1-micro' }
    its('cpu_platform') { should match 'Intel' }
    its('status') { should eq 'RUNNING' }
  end
end


