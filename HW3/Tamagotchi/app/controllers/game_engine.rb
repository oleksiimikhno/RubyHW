# frozen_string_literal: true

# Handler Game actions
module GameEngine
  class << self
    def message(text, message_class)
      puts text
      { text: text, message_class: message_class }
    end
  end
end
