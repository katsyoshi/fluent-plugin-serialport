# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fluent-plugin-serialport"
  s.version     = "0.0.3"
  s.authors     = ["MATSUMOTO Katsuyoshi"]
  s.email       = ["github@katsyoshi.org"]
  s.homepage    = "https://github.com/katsyoshi/fluent-plugin-serialport"
  s.summary     = "fluentd plugin for serial port"
  s.description = "fluentd plugin for serial port"
  s.license     = "Apache License, Version 2.0"
  s.has_rdoc = false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "fluentd"
  s.add_dependency "serialport"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "rake"
end
