$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rbsavvy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rbsavvy_commons"
  s.version     = RBSavvy::COMMONS_VERSION
  s.authors     = ["Phil Monroe", "Ricky Chilcott"]
  s.email       = ["phil@rbsavvy.com", "ricky@rbsavvy.com"]
  s.homepage    = "http://rbsavvy.com"
  s.summary     = "Common Rails config for RBSavvy"
  s.description = "Common Rails config for RBSavvy"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'unicorn'
  s.add_dependency 'rails_12factor'
  s.add_dependency 'newrelic_rpm'
  s.add_dependency 'lograge'
  s.add_dependency 'rollbar', '~> 1.2.7'

  s.add_development_dependency "sqlite3"
end
