#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/asset_pipeline'
require 'slim'
require 'coffee-script'

class App < Sinatra::Base
  set :assets_css_compressor, :yui
  set :assets_js_compressor, :uglifier

  configure do
    set :bind, '0.0.0.0'
    set :port, 5001
  end

  configure :test, :development do
    Sprockets::Helpers.configure do |config|
      config.debug = true
    end
  end

  register Sinatra::AssetPipeline

  get '/' do
    slim :index
  end

  get '/cameras' do
    slim :cameras
  end

  get '/key' do
    key = params[:key]
    puts "Sending key: #{key}"
    res = `$(which osascript) key.scpt #{key}`
    puts "Result: #{res}"
    res
  end
end
