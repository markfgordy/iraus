# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'iraus'
  app.version = "1.0"
  app.deployment_target = '7.0'
  app.interface_orientations = [:portrait, :portrait_upside_down]  
  app.identifier = 'com.iraus.iraus'
  app.provisioning_profile = "./resources/KeyChain:Certificate/iraus.mobileprovision"
  app.device_family = [:iphone]
  app.icons << 'iraus_icon_iphone.png'
end