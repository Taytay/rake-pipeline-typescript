# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rake-pipeline-typescript/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Taylor Brown"]
  gem.email         = ["taylor@youneedabudget.com"]
  gem.description   = %q{A typescript web filter for rake-pipeline}
  gem.summary       = %q{Contains a Typescript to Javascript filter for use in rake-pipeline}
  gem.homepage      = "http://github.com/taytay/rake-pipeline-typescript"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rake-pipeline-typescript"
  gem.require_paths = ["lib"]
  gem.version       = Rake::Pipeline::Typescript::VERSION
  gem.license       = "MIT License"

  gem.add_dependency "rake-pipeline", "~> 0.6"
  gem.add_dependency "rack"
  gem.add_dependency "typescript-node"
  gem.add_dependency "typescript-src", "~> 0.9.0"
  gem.add_dependency "execjs"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "therubyracer"
end
