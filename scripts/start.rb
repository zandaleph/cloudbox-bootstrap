require 'rubygems'
require 'aws-sdk'

AWS.config(YAML.load_file('etc/config.yml'))
ec2 = AWS::EC2.new(:ec2_endpoint => 'ec2.us-west-2.amazonaws.com')
key_pair = ec2.key_pairs.create("workspace key")
File.open("var/workspace_key.pem", mode="w", 0600) do |f|
    f.write(key_pair.private_key)
end
instance = ec2.instances.create(
        :image_id => 'ami-2a31bf1a',
        :instance_type => 't1.micro',
        :count => 1,
        :security_groups => 'quicklaunch-1',
        :key_pair => key_pair)
while instance.status == :pending
    sleep(10)
end
File.open("var/workspace_ip", mode="w") do |f|
    f.write(instance.ip_address)
end
File.open("var/workspace_id", mode="w") do |f|
    f.write(instance.id)
end

