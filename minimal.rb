require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra';

get '/' do
  'Minimal Sinatra Hello World!'
end
