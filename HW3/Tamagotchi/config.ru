require './app/tamagotchi'

require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Static,
  :urls => ["/app/view/style/"]

use Rack::Reloader
run Pet.new