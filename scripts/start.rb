require 'rubygems'

require 'yaml'
require 'open-uri'
require 'socket'
require 'timeout'

require 'aws-sdk'

# see http://stackoverflow.com/questions/3097589/getting-my-public-ip-via-api
ip_addr = open("http://api.exip.org/?call=ip").read
ip_cidr = ip_addr + "/0"

AWS.config(YAML.load_file('etc/config.yaml'))
ec2 = AWS::EC2.new(:ec2_endpoint => 'ec2.us-west-2.amazonaws.com')

security_group = ec2.security_groups.create("workspace security group")
security_group.authorize_ingress(:tcp, 22, ip_cidr)

key_pair = ec2.key_pairs.create("workspace key pair")
File.open("var/workspace_key.pem", mode="w", 0600) do |f|
    f.write(key_pair.private_key)
end

instance = ec2.instances.create(
        :image_id => 'ami-2a31bf1a',
        :instance_type => 't1.micro',
        :count => 1,
        :security_groups => security_group,
        :key_pair => key_pair)

while instance.status == :pending
    sleep(10)
end

workspace_info = {
    :ip => instance.ip_address,
    :id => instance.id,
    :security_group_id => security_group.id,
    :key_pair_name => key_pair.name,
}
File.open("var/workspace_info.yaml", mode="w") do |f|
    YAML.dump(workspace_info, f)
end

online = false
until online
    s = nil
    begin
        timeout(10) do
            s = TCPSocket.new(workspace_info[:ip], 22)
        end
        online = true
    rescue Exception => e
        online = false
        sleep(10)
    ensure
        s.close unless s.nil?
    end
end
