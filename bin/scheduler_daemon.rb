#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'
require 'fileutils'

boot_scheduler = File.join(File.dirname(__FILE__), 'boot.rb')
pid_dir = File.expand_path(File.join(File.dirname(__FILE__), %w(.. .. log)))

FileUtils.mkdir_p(pid_dir) unless File.exist?(pid_dir)

app_options = {
  :dir_mode => :normal,
  :dir => pid_dir,
  :multiple => false,
  :backtrace => true,
  :log_output => true
}

Daemons.run(boot_scheduler, app_options)
