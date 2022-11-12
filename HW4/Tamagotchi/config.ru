# frozen_string_literal: true

require './app/tamagotchi'

use Rack::Static, urls: ['/app/view/style/']

use Rack::Reloader, 0
# use Rack::Auth::Basic do |user, password|
#   user == 'aa' && password == 'aaa'
# end
run Pet.new
