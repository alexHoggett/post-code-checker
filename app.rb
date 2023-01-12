require 'sinatra/base'
require "sinatra/reloader"
require './lib/postcode_checker'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/postcode_checker.rb'
  end

  get '/' do
    return erb(:index)
  end

  post '/check' do
    if check_user_input
      status 400
      return ''
    end

    @valid = PostcodeChecker.new.valid?(params[:postcode])
    return erb(:check)
  end

  private

  def check_user_input
    params[:postcode].include?('<') || params[:postcode].include?('>')
  end
end
