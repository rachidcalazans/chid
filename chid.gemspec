# coding: utf-8
lib  = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chid/version'
chid = File.expand_path('../lib/chid', __FILE__)
require chid

Gem::Specification.new do |spec|
  spec.name          = "chid"
  spec.version       = Chid::VERSION
  spec.authors       = ["Rachid Calazans"]
  spec.summary       = "Simple assistant for day-to-day life. Developers and common users"
  spec.email         = ["rachidcalazans@gmail.com"]
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/rachidcalazans/chid"
  spec.description   = "Chid is an assistant to help your day-to-day life. It can be used in some installations, news, configurations, workstations and more."

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "tasks"]

  spec.add_development_dependency 'pry'

  # Tasks runner
  spec.add_dependency 'rake'
  # Simple HTTP request
  spec.add_dependency 'http'
  # Prompt utils
  spec.add_dependency 'tty-prompt'

end
