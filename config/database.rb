# Log queries to STDOUT in development
if Sinatra::Application.development?
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Automatically load every file in APP_ROOT/app/models/*.rb, e.g.,
#   autoload "Person", 'app/models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
#
Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

# We have to do this in case we have models that inherit from each other.
# If model Student inherits from model Person and app/models/student.rb is
# required first, it will throw an error saying "Person" is undefined.
#
# With this lazy-loading technique, Ruby will try to load app/models/person.rb
# the first time it sees "Person" and will only throw an exception if
# that file doesn't define the Person class.


require 'sinatra/activerecord'
