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
    sleep: #{@sleep_info} #{@sleep_value}
    poopy:
    "
  end

  def walk
    

    puts "You and #{@name} walk outside"
    game_time_pass
  end

  def to_bed
    @sleep_need = false

    if @sleep_value.negative?
      puts "Your #{@name} not wanna sleep!"
      return
    end

    @sleep_value = @sleep_value.positive?() ? @sleep_value - 4 : @sleep_value
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
    @sleep_value = 1


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
    # puts age(@age += 1)2
    # health(@health - 1)
    # puts @health

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

  def sleep_tired
    @sleep_value = inc_value(@sleep_value)
    @sleep_value >= 6 ? health_damaged : (puts "#{@name} need some sleep")
  end


  def mood
    @state_property = [@sleep_value]
     p "@state_property #{@state_property}"
    @state_property.all? { |v| v > 5} ? 'happy' : 'upset'
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
