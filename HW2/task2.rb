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
    age: #{@age}
    HP: #{@health}
    feeling: 
    mood: #{mood}
    hunger:
    sleep: #{@sleep_info}
    poopy:
    "
  end

  def walk
    

    puts "You and #{@name} walk outside"
    game_time_pass
  end

  def to_bed
    @sleep_need = false
    sleep_max = 10
    sleep_recovered = 4

    if @sleep_value > sleep_max
      puts "Your #{@name} not wanna sleep!"
      return
    end

    @sleep_value = @sleep_value < sleep_max ? @sleep_value + sleep_recovered : @sleep_value
    puts "#{@name} sleep now..."
    skip(3)

    @sleep_need = false
  end

  def skip(value = 1)
    value.times do
      puts 'You passed some time...'
      game_time_pass
    end
  end

  private

  def pet_veriables(name)
    rand_name = ['Dog', 'Dragon', 'Cat', 'Monster', 'Monkey']
    @name = name ? name : rand_name.sample()
    @time = 0
    @age = 0
    @health = health(rand(1..6))
    @sleep_value = 10

    pet_state
    puts "#{@name} born."
  end

  def pet_state
    @sleep_info = @sleep_need ? 'sleepy' : 'no need sleep'
  end

  # Pet methods
  def game_time_pass
    game_timer
    pet_state

    if @sleep_need
      sleep_tired
    end 

    return unless game_end?
    # if @name == 'Monster'
    #   puts "#{@name} eat you #{array_exit.sample}."
    #   exit
    # end

    rand_exit = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    puts "Your creation is #{rand_exit.sample}."
    exit
  end





#########################
  def feeling 

  end



  def health(value)
    @health_array = value.times

    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(dec_value(@health_array.size))
  end

  def sleep_tired
    @sleep_value = dec_value(@sleep_value)
    @sleep_value.negative? ? health_damaged : (puts "#{@name} need some sleep")
  end

  def mood
    @state_property = [@sleep_value]
     p "@state_property #{@state_property}"
    @state_property.all? { |v| v > 5} ? 'happy' : 'upset'
  end

  ## Engine methods ##
  def game_timer(value = 1)
    @time = @time < 12 ? inc_value(@time, value) : 0
    @age = @time == 12 ? inc_value(@age, value) : @age

    if @time == 2
      @sleep_need = true
    end
  end

  def game_end?
    @health_array.size <= 0
  end

  def inc_value(value_name, num = 1)
    value_name += num
  end

  def dec_value(value_name, num = 1)
    value_name -= num
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
