# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'corelogic/version'

Gem::Specification.new do |spec|
  spec.name          = 'corelogic-ruby'
  spec.version       = Corelogic::VERSION
  spec.authors       = ['Ilia Kriachkov']
  spec.email         = ['ilia.kriachkov@jetrockets.ru']

  spec.summary       = 'Ruby wrapper for the CoreLogic Property API'
  spec.description   = 'Ruby wrapper for the CoreLogic Property API. http://developer.corelogic.com/'
  spec.homepage      = 'https://github.com/jetrockets/corelogic-ruby'
  spec.license       = 'MIT'

  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'

  spec.require_paths = ['lib']
  spec.required_ruby_version = '> 3.1'

  # a b c d e f g h i j k l m n o p q r s t u v w x y z
  spec.add_dependency 'dry-auto_inject'
  spec.add_dependency 'dry-container'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'net-http', '~> 0.2'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'byebug', '~> 11'
  spec.add_development_dependency 'factory_bot', '~> 5.2'
  spec.add_development_dependency 'faker', '~> 2.20'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov', '~> 0.21'
  spec.add_development_dependency 'webmock', '~>3.14'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
