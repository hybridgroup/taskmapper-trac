# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ticketmaster-trac}
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rafael George"]
  s.date = %q{2011-04-20}
  s.description = %q{Allows ticketmaster to interact with Your System.}
  s.email = %q{rafael@hybridgroup.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".rvmrc",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/provider/comment.rb",
    "lib/provider/project.rb",
    "lib/provider/ticket.rb",
    "lib/provider/trac.rb",
    "lib/ticketmaster-trac.rb",
    "lib/trac/trac.rb",
    "spec/comments_spec.rb",
    "spec/commentutil_spec.rb",
    "spec/commentutils-data.html",
    "spec/fixtures/tickets.xml",
    "spec/projects_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/ticketmaster-trac_spec.rb",
    "spec/tickets_spec.rb",
    "ticketmaster-trac.gemspec"
  ]
  s.homepage = %q{http://github.com/hybridgroup/ticketmaster-trac}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.1}
  s.summary = %q{Ticketmaster Provider for Trac}
  s.test_files = [
    "spec/comments_spec.rb",
    "spec/commentutil_spec.rb",
    "spec/projects_spec.rb",
    "spec/spec_helper.rb",
    "spec/ticketmaster-trac_spec.rb",
    "spec/tickets_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<ticketmaster>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_runtime_dependency(%q<activeresource>, [">= 2.3.2"])
      s.add_runtime_dependency(%q<addressable>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<trac4r>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<ticketmaster>, [">= 0.1.0"])
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<activeresource>, [">= 2.3.2"])
      s.add_dependency(%q<addressable>, [">= 2.1.2"])
      s.add_dependency(%q<trac4r>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<ticketmaster>, [">= 0.1.0"])
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<activeresource>, [">= 2.3.2"])
    s.add_dependency(%q<addressable>, [">= 2.1.2"])
    s.add_dependency(%q<trac4r>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

