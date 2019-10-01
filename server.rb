require 'sinatra'
require 'sinatra/reloader'
require 'sprockets'
require 'sass'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'sinatra-pusher'

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

  get '/' do
    slim :start
  end

  get '/start/:name' do
    player = Player.new('You')
    cpu_count = (params[:name]).to_i
    session[:current_player] = player.name
    self.class.game.create_cpu(cpu_count)
    self.class.game.add_player(player)
    redirect '/game'
  end

  get '/game' do
    redirect '/' if self.class.game.empty?
    current_player = self.class.game.find_current_player(session[:current_player])
    slim :game, locals: {game: self.class.game, current_player: current_player}
  end
end