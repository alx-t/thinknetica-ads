require 'rubygems'
require 'sinatra'
require 'sinatra/namespace'

require_relative './boot'

set :bind, '0.0.0.0'
set :port, 8081

class AdsApi < Sinatra::Application
  run! if app_file == $0
end