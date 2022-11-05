require './app/tamagotchi'

Bundler.require

use Rack::Static,
  :urls => ["/app/view/style/"]

use Rack::Reloader
run Pet