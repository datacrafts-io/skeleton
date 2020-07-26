require_relative "lib/datacrafts_io_skeleton/version"

Gem::Specification.new do |spec|
  spec.name          = "datacrafts-io-skeleton"
  spec.version       = DatacraftsIoSkeleton::VERSION
  spec.authors       = ["Roman Ovcharov"]
  spec.email         = ["overchind@gmail.com"]

  spec.summary       = "Simple gem for fast rails apps creation."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/datacrafts-io/skeleton"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/datacrafts-io/skeleton"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", ">= 2.0"
  spec.add_dependency "rails", ">= 5.2"
  spec.add_dependency "thor", "~> 1.0.1"
end
