require_relative 'lib/fluent/plugin/signal/version'

Gem::Specification.new do |spec|
  spec.name          = 'fluent-plugin-signal'
  spec.version       = Fluent::Plugin::Signal::VERSION
  spec.authors       = ['Shun Yanaura']
  spec.email         = ['metroplexity@gmail.com']

  spec.summary       = 'A fluentd plugin to notify something to another process using POSIX signals'
  spec.description   = 'fluent-plugin-signal provides a way to notify another process by POSIX signals'
  spec.homepage      = 'https://github.com/yanana/fluent-plugin-signal'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  if spec.respond_to?(:metadata=)
    spec.metadata = {
      'bug_tracker_uri' => "#{spec.homepage}/issues",
      'homepage_uri' => spec.homepage,
      'source_code_uri' => spec.homepage,
      'changelog_uri' => "#{spec.homepage}/blob/master/CHANGELOG.md"
    }
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.79.0'
  spec.add_runtime_dependency 'fluentd', '>= 0.14.0', '< 2.0.0'
end
