#!/bin/ruby

require 'json'
state = JSON.parse(File.read("tf-setup/terraform.tfstate"))

iattributes = {}
state['modules'][0]['resources'].each { |k, v|
    iattributes[k] = v['primary']['attributes']
}

# write inspec attributes
require 'yaml'
File.open("attributes.yml", 'w') { |file| file.write(iattributes.to_yaml) }