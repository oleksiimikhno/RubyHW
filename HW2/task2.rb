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
    feeling: #{@feeling_info}
    mood: #{@mood_info}
    hunger: #{@hungry_value}
    sleep: #{@sleep_info}
    poopy:
    "
  end

  def walk
    events = ['sunny', 'rainy', 'cloudy', 'coldy']

    event = events.sample()

    puts "You and #{@name} walk. Today #{event} in outside."

    case event
    when 'rainy' || 'coldy'
      @sick = [true, false].sample
      @feeling_value = dec_value(@feeling_value, 2)
    when 'sunny'
      puts "#{@name} happyes todays."
      @feeling_value = inc_value(@feeling_value, 2)
    else
      puts 'Nothing happened, you returns to home.'
    end
    
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

  def cure
    if @sick
      @sick = false
      health(inc_value(@health_array.size))
    else
      puts "#{@name} not need cures"
    end
    game_time_pass
  end

  def skip(value = 1)
    value.times do
      puts 'You passed some time...'
      game_time_pass
    end
  end

  private

  def pet_veriables(name)
    names = ['Dog', 'Dragon', 'Cat', 'Monster', 'Monkey']
    @name = name ? name : names.sample()
    @time = 0
    @age = 0
    @health = health(rand(1..6))
    @sick = false
    @sleep_value = 10
    @feeling_value = 10
    @hungry_value = rand(1..10)

    pet_state
    puts "#{@name} born."
  end

  def pet_state
    @feeling_info = @sick ? 'sick' : 'normal'
    @mood_info = mood? ? 'happy' : 'upset'
    @sleep_info = @sleep_need ? 'sleepy' : 'no need sleep'
  end

  # Pet methods






#########################


  def health(value)
    @health_array = value.times

    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(dec_value(@health_array.size))
  end

  def pet_sick
    @feeling_value = dec_value(@feeling_value)
    @feeling_value < 7 ? health_damaged : (puts "#{@name} need cures")
  end

  def pet_tired
    @sleep_value = dec_value(@sleep_value)
    @sleep_value.negative? ? health_damaged : (puts "#{@name} need some sleep")
  end

  def mood?
    @state_property = [@sleep_value, @feeling_value]
    p @state_property
    @state_property.all? { |v| v > 5}
  end

  ## Engine methods ##
  def game_time_pass
    game_timer
    pet_state

    if @sleep_need
      pet_tired
    end 

    if @sick
      pet_sick
    end

    return unless game_end?
    # if @name == 'Monster'
    #   puts "#{@name} eat you #{array_exit.sample}."
    #   exit
    # end

    game_ends = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    puts "Your creation is #{game_ends.sample}."
    exit
  end

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
