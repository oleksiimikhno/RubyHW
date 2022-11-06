# frozen_string_literal: true

# Handler Game actions
module GameEngine
  class << self
    # def start_game(start,)

    # end 

    def methods(start_game, methods)
      remove_usless_methods = %w[start_game restart call].map(&:to_sym)
      start_game ? methods - remove_usless_methods : methods
    end

    def message(text, message_class)
      puts text
      { text: text, message_class: message_class }
    end
  end
end
