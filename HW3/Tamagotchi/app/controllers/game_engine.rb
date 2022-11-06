# frozen_string_literal: true

# Handler Game actions
module GameEngine
  class << self
    def methods(start_game, methods)
      remove_usless_method = %w[start_game call].map(&:to_sym)
      start_game ? methods - remove_usless_method : methods
    end

    def message(text, message_class)
      puts text
      { text: text, message_class: message_class }
    end
  end
end
