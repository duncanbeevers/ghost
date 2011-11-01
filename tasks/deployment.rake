require File.dirname(__FILE__) + '/rake_helper'

GEM         = "ghost"
GEM_VERSION = [0,2,8]
AUTHOR      = "Bodaniel Jeanes"
EMAIL       = "me@bjeanes.com"
HOMEPAGE    = "http://github.com/bjeanes/ghost"
SUMMARY     = "Allows you to create, list, and modify local hostnames"
DESCRIPTION = SUMMARY + " by managing the /etc/hosts file or through the Directory Service on Mac OS"

spec = Gem::Specification.new do |s|
  s.name              = GEM
  s.rubyforge_project = GEM
  s.version           = GEM_VERSION.join('.')

  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "LICENSE", 'TODO']
  s.rdoc_options      << '--line-numbers'

  s.summary     = SUMMARY
  s.description = DESCRIPTION
  s.author      = AUTHOR
  s.email       = EMAIL
  s.homepage    = HOMEPAGE

  s.executables << 'ghost'
  s.executables << 'ghost-ssh'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{bin,lib}/**/*")
  s.test_files = Dir.glob("{spec/**/*")

  s.add_development_dependency('rspec', '= 1.3.2')
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION.join('.')}}
end

desc "Create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

desc "Create READMEs from README.mkdn"
task :readme do
  require 'rdiscount'
  readme = File.read('README.mkdn')
  readme_html = RDiscount.new(readme).to_html
  File.open('README.html', 'w') do |f|
    puts "Writing out HTML file"
    f.write readme_html
  end  
  
  File.open('README', 'w') do |f|
    puts "Writing out text file"
    f.write readme
  end
end

desc "Clean packages (alias for clobber_package)"
task :clean => :clobber_package
