# frozen_string_literal: true

# Handler return list of commands
module GameCommandList
  class << self
    def commands(methods)
      methods.map { |method| commands_description(method.to_s) }
    end

    def commands_description(method)
      case method
      when 'help'
        "#{method} - view all methods"
      when 'feed'
        "#{method} - your pet"
      when 'clear'
        "#{method} - clear poopy in home"
      when 'walk'
        "#{method} - outside with pet"
      when 'to_bed'
        "#{method} - put your pet"
      when 'huge'
        "#{method} - your pet.?."
      when 'skip_time'
        "#{method} - some time in game"
      when 'cure'
        "#{method} - mayby your pet sick? Need cure his?"
      when 'play'
        "#{method} - with pet"
      else
        raise StandardError, 'Some error with methods'
      end
    end
  end
end
