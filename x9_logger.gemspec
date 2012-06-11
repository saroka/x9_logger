# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "x9_logger/version"

Gem::Specification.new do |s|
  s.name        = "x9_logger"
  s.version     = X9Logger::VERSION
  s.authors     = ["Evandro Saroka"]
  s.email       = ["saroka@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Logger with regular output and error output}
  s.description = %q{A wrapper for Ruby Logger with two encapsulated logs: regular output and error output.}

  s.rubyforge_project = "x9_logger"

  s.files         = Dir['lib/**/*'].select { |f| File.file?(f) }
  s.require_paths = ['lib']
  s.executables   = Dir['bin/*'].collect { |f| f.split("\n").map{ |f| File.basename(f) } }.flatten

  s.add_runtime_dependency 'activesupport', '>= 3.2.5'
  s.add_development_dependency 'rspec', '>= 2.10.0'
end
