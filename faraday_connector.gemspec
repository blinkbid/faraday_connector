# frozen_string_literal: true

require_relative "lib/faraday_connector/version"

Gem::Specification.new do |spec|
  spec.name = "faraday_connector"
  spec.version = FaradayConnector::VERSION
  spec.authors = ["macedo"]
  spec.email = ["macedo@87labs.com"]

  spec.summary = "Ruby module that will have all the needed logic in order to make any kind of HTTP requests to Web API (JSON)."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["source_code_uri"] = "https://github.com/blinkbid/faraday_connector"
  spec.metadata["changelog_uri"] = "https://github.com/blinkbid/faraday_connector/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "concurrent-ruby", "~> 1.3", ">= 1.3.1"
  spec.add_dependency "faraday", "~> 2.9", ">= 2.9.1"
  spec.add_dependency "faraday_curl", "~> 0.0.2"
  spec.add_dependency "oj", "~> 3.3", ">= 3.3.5"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "standard", "~> 1.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
