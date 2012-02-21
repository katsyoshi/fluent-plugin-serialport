# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fluent/plugin/in_serialport/version"

Gem::Specification.new do |s|
  s.name        = "fluent-plugin-serialport"
  s.version     = Fluent::Plugin::SerialportInput::VERSION
  s.authors     = ["MATSUMOTO Katsuyoshi"]
  s.email       = ["matsumoto.katsuyoshi+github@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "fluent-plugin-serialport"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_depvelopment_dependency "fluentd"
  s.add_runtime_dependency "fluentd"
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
