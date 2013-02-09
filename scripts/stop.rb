require 'rubygems'
require 'aws-sdk'

AWS.config(YAML.load_file('etc/config.yml'))
ec2 = AWS::EC2.new(:ec2_endpoint => 'ec2.us-west-2.amazonaws.com')
instance = ec2.instances[File.read("var/workspace_id")]
instance.terminate
while instance.status == :running
    sleep(10)
end
while instance.status == :shutting_down
    sleep(10)
end
File.delete("var/workspace_id", "var/workspace_ip", "var/workspace_key.pem")
