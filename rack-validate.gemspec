Gem::Specification.new do |gem|
  gem.name    = 'rack-validate'
  gem.version = '0.1.3'
  gem.date    = Date.today.to_s

  gem.summary = %q{Rack middleware that validates HTML with w3c validator and displays result in page.}
  gem.description = %q{Rack middleware that validates HTML with w3c validator and displays result in page.}

  gem.authors  = ["Ed Schmalzle"]
  gem.email    = %q{Jonas714@gmail.com}
  gem.homepage = %q{http://github.com/nerdEd/rack-validate}

  gem.add_dependency('rake')
  gem.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  gem.add_development_dependency(%q<rspec>, ["~> 1.3"])
  gem.add_development_dependency(%q<ruby-debug>, [">=0"])
  gem.add_runtime_dependency(%q<w3c_validators>, [">= 0"])
  gem.add_dependency(%q<rack>, [">= 0.9.1"])
  gem.add_dependency(%q<json>, [">= 0"])

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
