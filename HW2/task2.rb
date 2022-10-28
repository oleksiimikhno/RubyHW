# Create new creation in Tamagotchi game
class Pet
  def initialize(name = false)
    @start = false
    pet_veriables(name)

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
    timelife: #{@time}
    HP: #{@health}
    age: #{@age}
    mood:
    hunger:
    sleep: #{tired}
    poopy:
    "
  end

  def walk
    puts 'You and your pets walk outside'
    time_pass
  end

  def to_bed
    @sleep_need = false
    @sleep_value = @sleep_value.positive?() ? @sleep_value - 4 : @sleep_value
    puts "#{@name} sleep now..."
    skip(3)
  end

  def skip(value = 1)
    value.times do
      puts 'You passed some time...'
      time_pass
    end
  end

  private

  def pet_veriables(name)
    array_name = ['Dog', 'Dragon', 'Cat', 'Monster', 'Monkey']
    @name = name ? name : array_name.sample()
    @time = 0
    @age = 0
    @health = health(rand(1..6))
    @sleep_value = 0

    puts "#{@name} born."
  end

  # Pet methods
  def time_pass
    game_timer
    # puts age(@age += 1)2
    # health(@health - 1)
    # puts @health



    if @sleep_need
      tired
    end 

    return unless game_end?
    # if @name == 'Monster'
    #   puts "#{@name} eat you #{array_exit.sample}."
    #   exit
    # end

    array_exit = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    puts "Your creation is #{array_exit.sample}."
    exit
  end

  def game_timer(value = 1)
    @time = @time < 12 ? @time += value : 0
    @age = @time == 12 ? @age += value : @age

    if @time == 10
      @sleep_need = true
    end
  end

  def health(value)
    @health_array = value.times

    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(@health_array.size - 1)
  end

  def tired
    @sleep_value += 1
    @sleep_value >= 6 ? health_damaged : (puts "#{@name} need some sleep")
    @sleep_info ? 'sleepy' : 'no need sleep'
  end

  def game_end?
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

pet = Pet.new('Creation')
pet.info
