require 'sinatra'
require './lib/gothonweb/map.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    session[:room] = 'START'
    redirect to('/game')
end

get '/game' do
    room = Map::load_room(session)

    if room
        erb :show_room, :locals => {:room => room}
    else
        erb :you_died
    end
end