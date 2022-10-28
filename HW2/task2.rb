# Create new creation in Tamagotchi game
class Pet
  def initialize(name = 'Unknown creation')
    @start = false

    @name = name
    @age = 0
    @sleep = false
    @health = health(rand(1..6))

    @time = 0

    puts "#{@name} born."

    start_game
  end

  def start_game
    @start = true
    custom_methods = self.class.instance_methods(false)
    @game_methods = @start ? custom_methods.reject { |v| v == 'start_game'.to_sym } : custom_methods

    action_message
  end

  def info
    puts "
    ________#{@name}________
    time: #{@time}
    HP: #{@health}
    age: #{@age}
    mood:
    hunger:
    sleep: #{sleep}
    poopy:
    "
  end

  def walk
    puts 'You and your pets walk outside'
    time_pass
  end

  def to_bad
    @sleep = false
    puts "#{@name} sleep now..."
    skip(3)
  end

  def skip(value = 1)
    puts 'You passed some time...'
    value.times do
      time_pass
    end
  end

  private

  # Pet methods
  def time_pass
    game_timer
    # puts age(@age += 1)
    # health(@health - 1)
    # puts @health

    if @time >= 2 && @time <= 4
      # @sleep = true
      sleep
      puts 'Pet tired'
    end

    return unless dead?

    puts 'Your creation is dead'
    exit
  end

  def game_timer(value = 1)
    @time = @time < 12 ? @time += value : 0

    @age = @time == 12 ? @age += value : @age
  end

  def sleep
    @sleep ? 'sleepy' : 'no need sleep'
  end

  def health(value)
    @health_array = value.times

    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(@health_array.size - 1)
  end

  def tired?
    
  end

  def dead?
    @health_array.size <= 0
  end

  # Handler user action
  def action_message
    title = "\n--------- Please select method name to interact with #{@name}! ---------"
    subtitle = '________________________________________________________________________________'

    puts "#{title}\n#{@game_methods.join("\n")}\n#{subtitle}
    "

    action_user(gets.chomp)
  end

  def action_user(action)
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
