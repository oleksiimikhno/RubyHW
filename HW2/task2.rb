# Create new creation in Tamagotchi game
class Pet
  def initialize(name = 'Unknown creation')
    @start = false

    @name = name
    @sleep = false
    @health = health(rand(1..6))

    puts "#{@name} born."

    start_game
  end

  def start_game
    @start = true
    custom_methods = self.class.instance_methods(false)
    @game_methods = @start ? custom_methods.reject { |v| v == 'start_game'.to_sym } : custom_methods

    age

    action_message
  end

  def info
    puts "
    ________#{@name}________
    HP: #{@health}
    age: #{@age}
    mood:
    hunger:
    sleep:
    poopy:
    "
  end

  def walk
    puts 'You and your pets walk outside'
    time_pass
  end

  def sleep
    @sleep = true
    puts "#{@name} sleep now..."
    time_pass
  end

  private

  # Pet methods
  def time_pass
    # puts age(@age += 1)
    # health(@health - 1)
    # puts @health

    return unless dead?

    puts 'Your creation is dead'
    exit
  end

  def health(value)
    @health_array = value.times

    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(@health_array.size - 1)
  end

  def age(value = 0)
    @age = value
    # half_age 0
    # p half_age
    # if half_age == 4
    #   @age += 1
    # end

    @age
  end

  def dead?
    @health_array.size <= 0
  end

  # User action
  def action_message
    title = "\n--------- Please select method name to interact with #{@name}! ---------"
    subtitle = '________________________________________________________________________________'

    puts "#{title}\n#{@game_methods.join("\n")}\n#{subtitle}
    "

    user_action(gets.chomp)
  end

  def user_action(action)
    !action.empty? ? action_reducer(action) : (puts '▼ Empty action, please type anything from there ▼▼▼! ▼')

    action_message
  end

  def action_reducer(action)
    action = action.to_sym

    case action
    when action_helper(action)
      self.send(action)
    else
      puts "▼ Unknown command --- #{action.upcase} ---, please select current! ▼"
    end

    action_message
  end

  def action_helper(action)
    @game_methods.detect { |i| i == action }
  end
end

pet = Pet.new
pet.info
