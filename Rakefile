require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "find_or_redirect"
    gem.summary = %Q{Refactor finder code in controllers}
    gem.description = %Q{Refactor finder code in controllers}
    gem.email = "nick@smartlogicsolutions.com"
    gem.homepage = "http://github.com/ngauthier/find_or_redirect"
    gem.authors = ["Nick Gauthier"]
    gem.files = FileList["[A-Z]*.*", "{bin,lib,test}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

task :default => :build

