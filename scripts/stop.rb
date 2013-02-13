require 'rubygems'
require 'aws-sdk'

workspace_info = YAML.load_file("var/workspace_info.yaml")

AWS.config(YAML.load_file('etc/config.yaml'))
ec2 = AWS::EC2.new(:ec2_endpoint => 'ec2.us-west-2.amazonaws.com')

instance = ec2.instances[workspace_info[:id]]
instance.terminate

while instance.status == :running
    sleep(10)
end
while instance.status == :shutting_down
    sleep(10)
end

ec2.key_pairs[workspace_info[:key_pair_name]].delete
ec2.security_groups[workspace_info[:security_group_id]].delete

File.delete("var/workspace_info.yaml", "var/workspace_key.pem")
