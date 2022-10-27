
# Create new creation in Tamagotchi game
class Pet
  def initialize(name = 'Unknown creation')
    @start = false

    @name = name
    @health = health(rand(1..6))
    puts "#{@name} burn."


    

    start_game
  end

  def start_game
    @start = true
    @custom_methods = self.class.instance_methods(false)

    @game_methods = @start ? @custom_methods.join(' ').split(' ').reject { |v| v == "start_game" } : @custom_methods

    action_message
  end

  def walk
    puts 'You and your pets walk outside'
    time_pass
  end

  def sleep
    puts "#{@name} sleep now..."
    time_pass
  end

  def info
    puts "
    ________#{@name}________
    HP: #{@health}
    age creation: #{@age}
    ☻☹㋡
    "
  end

  def minus
    health(@health.size - 1)
  end

  def add
    health(@health.size + 1)
  end

  private

  # Pet methods
  def time_pass
    # puts age(@age += 1)
    # health(@health - 1)
    # puts @health

    if dead?
      puts 'Your creation is dead'
    end
    # puts info
  end

  def health(value)
    p value
    @health = value.times.map { '♥' }.join(' ')
  end

  def age(value = 0)
    @age = value
  end

  def dead?
    @health.split(' ').to_a.size <= 0
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
    case true
    when action_helper(action)
      eval("self.#{action}")
    else
      puts "▼ Unknown command #{action.upcase}, please select current! ▼"
    end
    action_message
  end

  def action_helper(action)
    @game_methods.join(' ').split(' ').include? action.downcase
  end
end

pet = Pet.new