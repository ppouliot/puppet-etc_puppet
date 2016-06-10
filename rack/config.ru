####################################################################
####################################################################
##
## File controlled by Puppet Module puppet::master
## Any changes you make will be overwritten.
##
####################################################################
####################################################################

# a config.ru, for use with every rack-compatible webserver.
# SSL needs to be handled outside this, though.

# Ruby 1.9 cares about encoding, and apache starts up as US-ASCII in most
# cases.  If you have a manifest that is UTF-8, then puppet won't be able to
# handle it.  To work around that, we change the default encoding.  See
# https://tickets.puppetlabs.com/browse/PUP-1386 and
# https://github.com/puppetlabs/puppet/pull/1666 for more details.
if RUBY_VERSION >= "1.9"
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

# if puppet is not in your RUBYLIB:
# $LOAD_PATH.unshift('/opt/puppet/lib')

$0 = "master"

# if you want debugging:
# ARGV << "--debug"

ARGV << "--rack"

# Rack applications typically don't start as root.  Set --confdir and --vardir
# to prevent reading configuration from ~puppet/.puppet/puppet.conf and writing
# to ~puppet/.puppet
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir"  << "/var/lib/puppet"

# NOTE: it's unfortunate that we have to use the "CommandLine" class
#  here to launch the app, but it contains some initialization logic
#  (such as triggering the parsing of the config file) that is very
#  important.  We should do something less nasty here when we've
#  gotten our API and settings initialization logic cleaned up.
#
# Also note that the "$0 = master" line up near the top here is
#  the magic that allows the CommandLine class to know that it's
#  supposed to be running master.
#
# --cprice 2012-05-22

require 'puppet/util/command_line'
# we're usually running inside a Rack::Builder.new {} block,
# therefore we need to call run *here*.
run Puppet::Util::CommandLine.new.execute
