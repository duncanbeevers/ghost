$: << File.dirname(__FILE__)

case RUBY_PLATFORM
when /darwin/
  if `uname -r` =~ /^11\./
    require 'ghost/linux-host'
  else
    require 'ghost/mac-host'
  end
when /linux/
  require 'ghost/linux-host'
end

require 'ghost/ssh_config'
