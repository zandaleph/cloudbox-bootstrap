Cloudbox-Bootstrap
==================

So I was sitting around one evening and thought to myself: "If I'm so
keen on this idea of having a cloud-based development box, how do I get
into the box when I'm at someone else's computer?"  This package was the
result.

Tl;dr
-----

+ `bin/boostrap.sh`
+ edit `etc/config.yaml`
+ `bin/launch.sh`
+ `bin/connect.sh`
+ `bin/terminate.sh`

Requirements
------------

The only requirements for using this package are curl, bash, and
whatever is needed to compile ruby (probably the gcc toolchain).

Installing
----------

Clone this package to the computer you want to connect to ec2 from, and
run `bin/bootstrap.sh` once to setup a directory-local copy of rvm, ruby,
and the aws-sdk.  This might take a short while to compile everything.

Once that is done (or while it is running), log into the AWS Management
Console and grab your Access and Secret keys.  You need to create an
`etc/config.yaml` file with that information, see the provided template
for format.

Usage
-----

Run `bin/launch.sh` to start an instance.  This will create
three files in the local `var` directory:

+ `workspace_key.pem` - your ssh key for the box
+ `workspace_info.yaml` - details about your instance

After `bin/launch.sh` is done, you can run `bin/connect.sh` at any
time to ssh to your cloud box.

When you want to shut down your workspace, run `bin/terminate.rb`.
Remember that you are charged a full hour for each time you start an
instance, so do not feel the need to compulsively start and stop your
instance every time you log out.

Known Issues
------------

After running `bin/launch.sh`, `bin/connect.sh` will receive errors for
a while as the operating system starts up.  One of these two scripts
should probably detect this state and block until it clears.

Future Plans
------------

This package still has a lot of limitations:

+ hardcoded ami - Amazon Linux
+ hardcoded instance size - t1.micro
+ only supports one instance at a time
+ approximately zero fault tolerance
+ spot instances for cheap workspaces
+ setup cloudwatch to terminate idle workspaces?

For the hardcoded stuff it might eventually be nice to have those as
arguments to `bin/launch.sh`.  Supporting more than one instance
at a time is probably worth pursuing to support multiple users of the
same AWS account.  Fault tolerance - meh, networks are 100% reliable :)

