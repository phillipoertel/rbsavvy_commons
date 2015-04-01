$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rbsavvy_commons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rbsavvy_commons"
  s.version     = RbsavvyCommons::VERSION
  s.authors     = ["Phil Monroe", "Ricky Chilcott"]
  s.email       = ["phil@rbsavvy.com", "ricky@rbsavvy.com"]
  s.homepage    = "rbsavvy.com"
  s.summary     = "Common Rails config for RBSavvy"
  s.description = "Common Rails config for RBSavvy"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
