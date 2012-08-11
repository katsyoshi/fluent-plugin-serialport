# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fluent-plugin-serialport"
  s.version     = "0.0.1.1"
  s.authors     = ["MATSUMOTO Katsuyoshi"]
  s.email       = ["matsumoto.katsuyoshi+rubygems@gmail.com"]
  s.homepage    = "https://github.com/katsyoshi/fluent-plugin-serialport"
  s.summary     = "fluentd plugin for serial port"
  s.description = "fluentd plugin for serial port"
  s.has_rdoc = false
#  s.rubyforge_project = "fluent-plugin-serialport"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "fluentd"
  s.add_dependency "serialport"
end
