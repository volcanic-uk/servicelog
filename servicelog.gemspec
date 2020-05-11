# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'servicelog/version'

Gem::Specification.new do |spec|
  spec.name          = 'servicelog'
  spec.version       = Servicelog::VERSION
  spec.authors       = ['Victor Perez Rodriguez']
  spec.email         = ['victor.mx14@gmail.com']

  spec.summary       = 'service logs'
  spec.description   = 'service logs for Rails 5+'
  spec.homepage      = 'https://github.com/volcanic-uk/servicelog'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/volcanic-uk/servicelog'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 5.0.0'
  spec.add_dependency 'request_store', '>= 1.4.0'

  spec.add_development_dependency 'activeresource', '>= 5.0.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.82.0'
end
