# frozen_string_literal: true

require './app/tamagotchi'

# Bundler.require

use Rack::Static,
  :urls => ["/app/view/style/"]

use Rack::Reloader, 0

run Pet.new
