rails_root = File.expand_path(File.join(File.dirname(__FILE__), %w(..)))
daemons_lib_dir = File.expand_path(File.join(File.dirname(__FILE__), %w(.. lib)))

require File.join(rails_root, 'config/environment.rb')
require File.join(daemons_lib_dir, 'scheduler')

Scheduler::Base.new(ARGV)
