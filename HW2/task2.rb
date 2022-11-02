# Create new creation in Tamagotchi game
class Pet
  def initialize(name: nil)
    @start = false
    veriables(name)
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
    -------- #{@name} --------
    timelife: #{@time}
    age: #{@age}
    HP: #{@health}
    feeling: #{@feeling_info}
    mood: #{@mood_info}
    hungry: #{@hungry_info}
    sleep: #{@sleep_info}
    poopy: #{@poopy_info}
    "
  end

  def help
    # description_methods
    puts @game_methods.map { |v| help_description(v.to_s) }
  end

  def walk
    events = %w[sunny rainy cloudy coldy]
    event = events.sample

    case event
    when 'rainy' || 'coldy'
      @sick = [true, false].sample
      @feeling_value = dec_value(@feeling_value, 2)
      puts 'Pet feeling not good' if @sick
    when 'sunny'
      puts "#{@name} happyes todays."
      @feeling_value = inc_value(@feeling_value, 2)
    else
      puts 'Nothing happened, you returns to home.'
    end

    puts "You and #{@name} walk. Today #{event} in outside."
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

    @feeling_value = inc_value(@feeling_value, 2)
    @sleep_value = @sleep_value < sleep_max ? @sleep_value + sleep_recovered : @sleep_value
    puts "#{@name} sleep now..."
    skip_time(3)

    @sleep_need = false
  end

  def feed
    if poppy?
      puts 'Need clear area :(. Mess, smell...'
      return
    end

    @belly_value = inc_value(@belly_value, 3)
    @intestine_value = inc_value(@intestine_value, 1)
    puts 'feeding...'
    game_time_pass
  end

  def huge
    @belly_value = inc_value(@belly_value, 2)
    @feeling_value = inc_value(@feeling_value, 2)
    @sleep_value = inc_value(@sleep_value, 2)
    @sick = false
    puts "#{@name} filled self perfectly..."
    # it's magic method but what price?
    @reborn = inc_value(@reborn)
    game_time_pass
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

  def play(value = 2)
    if @sleep_need
      puts "Your #{@name} feeling tired!"
    else
      @feeling_value = inc_value(@feeling_value, value)

      puts "#{@name} play with you and sooooo happy."
      game_time_pass
    end
  end

  def clear
    @intestine_value = 0 if poppy?

    @feeling_value = inc_value(@feeling_value, 1)
    puts "You clear our house, #{@name} happy now."
    game_time_pass
  end

  def skip_time(value = 1)
    value.times do
      puts 'You passed some time...'
      game_time_pass
    end
  end

  def leave
    puts 'You walk outside buy something stuff and never return...'
    exit
  end

  private

  def veriables(name)
    names = %w[Dog Dragon Cat Unicorn Monkey]
    @name = name || names.sample
    @time = 0
    @age = 0
    @health = @name == 'Cat' ? health(9) : health(rand(1..6))
    @sick = false
    @sleep_value = 10
    @feeling_value = 10
    @belly_value = 10
    @intestine_value = 0
    @reborn = 0

    state
    info
    puts "#{@name} born."
  end

  def state
    @name = reborn? ? 'Monster' : @name
    @feeling_info = @sick ? 'sick' : 'normal'
    @mood_info = mood? ? 'happy' : 'upset'
    @sleep_info = @sleep_need ? 'sleepy' : 'no need sleep'
    @hungry_info = hungry? ? 'wanna eat' : 'full'
    @poopy_info = poppy? ? 'something smell' : 'everything fine'
  end

  ## Pet methods ##
  def hungry?
    @belly_value < 2
  end

  def belly
    @belly_value = dec_value(@belly_value)
    hungry? ? health_damaged : (puts "#{@name} need feeding")
  end

  def poppy?
    @intestine_value >= 6
  end

  def health(value)
    @health_array = value.times
    @health = value.times.map { '♥' }.join(' ')
  end

  def health_damaged
    puts 'Your pet was damaged, something is wrong?'
    health(dec_value(@health_array.size))
  end

  def sick
    @feeling_value = dec_value(@feeling_value)
    @feeling_value < 7 ? health_damaged : (puts "#{@name} need cures")
  end

  def tired
    @feeling_value = dec_value(@feeling_value, 2)
    @sleep_value = dec_value(@sleep_value)
    @sleep_value.negative? ? health_damaged : (puts "#{@name} need some sleep")
  end

  def mood?
    return false if poppy?

    state_property = [@sleep_value, @feeling_value, @belly_value]
    state_property.all? { |v| v > 5 }
  end

  def reborn?
    @reborn >= 4
  end

  ## Engine methods ##
  def game_time_pass
    game_timer
    state

    @belly_value = if reborn?
                     dec_value(@belly_value, 4)
                   else
                     dec_value(@belly_value)
                   end

    @intestine_value = inc_value(@intestine_value)

    tired if @sleep_need

    sick if @sick

    if hungry?
      if reborn? && @belly_value < 5
        puts "#{@name} ear you.."
        exit
      end
      belly
    end

    @sick = [true, false].sample if poppy?

    if @feeling_value.negative?
      puts "#{@name} run away"
      exit
    end

    return unless game_end?

    game_ends = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    puts "Your creation is #{game_ends.sample}."
    exit
  end

  def game_timer(value = 1)
    @time = @time < 12 ? inc_value(@time, value) : 0
    @age = @time == 12 ? inc_value(@age, value) : @age

    @sleep_need = true if @time == 10
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

  def help_description(method)
    case method
    when 'help'
      "#{method} - view all methods"
    when 'feed'
      "#{method} - your pet"
    when 'info'
      "#{method} - view all information about pet"
    when 'clear'
      "#{method} - clear poopy in home"
    when 'walk'
      "#{method} - outside with pet"
    when 'to_bed'
      "#{method} - put your pet"
    when 'huge'
      "#{method} - your pet.?."
    when 'skip_time'
      "#{method} - some time in game"
    when 'cure'
      "#{method} - mayby your pet sick? Need cure his?"
    when 'play'
      "#{method} - with pet"
    when 'leave'
      "#{method} - game, its your chose"
    else
      raise StandardError, 'Some error with methods'
    end
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
      public_send(action)
    else
      puts "▼ Unknown command --- #{action.upcase} ---, please select current! ▼"
    end

    action_message
  end

  def action_helper(action)
    @game_methods.detect { |method| method == action }
  end
end

pet = Pet.new
pet.info
