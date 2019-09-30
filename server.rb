require 'sinatra'
require 'sinatra/reloader'
require 'sprockets'
require 'sass'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'sinatra-pusher'
require 'webdrivers'
require 'pusher'

class Server < Sinatra::Base

  configure :development do 
    register Sinatra::Reloader
  end
  enable :sessions
  set :environment, Sprockets::Environment.new
  environment.append_path "assets/stylesheets"
  environment.append_path "assets/javascripts"
  environment.css_compressor = :scss
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end
  
  def self.game
    @@game ||= Game.new
  end

  def self.clear_game
    @@game = nil
  end
end