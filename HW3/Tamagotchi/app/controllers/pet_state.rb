# frozen_string_literal: true

# Check state pet
module PetState
  class << self
    def hungry(belly_value)
      belly_value < 2
    end

    def reborn(reborn)
      reborn >= 4
    end

    def poopy(intestine)
      intestine > 6
    end

    def mood(mental_values)
      mental_values.all? { |v| v > 5 }
    end

    def dead(health_array)
      health_array.size <= 0
    end
  end
end
