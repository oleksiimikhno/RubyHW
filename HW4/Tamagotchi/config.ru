# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.setup
Bundler.require(:default)

require './app/tamagotchi'

use Rack::Static,
  :urls => ["/app/view/style/"]

use Rack::Reloader, 0

run Pet.new
