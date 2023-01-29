#encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_content_blocks'
  s.version     = '1.0'
  s.summary     = 'Adds Content Blocks to Solidus static content gem'
  s.required_ruby_version = '>= 2.0'

  s.author    = 'Stefan Hartmann'
  s.email     = 'sh@wemove.com'
  s.homepage  = 'http://wemove.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib','lib/paperclip_processors']
  s.requirements << 'none'

  s.add_dependency 'solidus_static_content' 

end
