link_preview_generator
======================

Simple library to get url previews


To use the link_preview_generator add the following to your Gemfile :

```ruby
gem "link_preview_generator"

then run 

```ruby
bundle install

OR

```ruby
gem install link_preview_generator

to install it to your system.



Then simply use : 

```ruby
LinkPreviewGenerator.get_preview_elements("www.youtube.com")

and get a Hash of all the preview elements 
