Gem::Specification.new do |lp|
  lp.name        = 'link_preview_generator'
  lp.version     = '1.0.0'
  lp.date        = '2014-03-08'
  lp.summary     = "Link Preview Generator"
  lp.description = "Instantly get preview elements for a link"
  lp.author      = "Dalvir Suri"
  lp.email       = 'dalvir30@gmail.com'
  lp.files       = ["lib/link_preview_generator.rb"]
  lp.platform    = "Gem::Platform::RUBY"
  lp.license     = "MIT"
  lp.homepage    = "http://rubygems.org/gems/link_preview_generator"

  lp.add_dependency "nokogiri", "~> 1.6.1"  
  lp.post_install_message = "Voila!!! You have succeeded in installing this gem. Drinks are on you the next time we meet."
end