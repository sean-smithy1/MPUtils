Gem::Specification.new do |spec|
  spec.name        = 'mputils'
  spec.version     = '0.0.1'
  spec.date        = '2015-04-19'
  spec.summary     = "Update Majestic Park Database"
  spec.description = "Various utilities to Majestic Park Finances into a database format"
  spec.authorss     = ['Sean Smith']
  spec.email       = 'sean.smithy1@gmail.com'
  spec.files       += Dir.glob('{lib, spec}/**/*') + ['README.mb', 'LICENCE.md']
  spec.homepage    = 'http://rubygems.org/gems/mputils'
  spec.license       = 'MIT'
  spec.add_runtime_dependency 'sqlite3', '~>1.3.9'
  spec.add_runtime_dependency 'bcrypt', '~>3.1.7'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.require_paths = ["lib"]
end
