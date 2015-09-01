# Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}
# require("bundler/setup")
# Bundler.require(:default)
require('sinatra')
require('sinatra/reloader')

get('/') do
  erb(:index)
end

get('/parents') do
  erb(:parents)
end
