# frozen_string_literal: true

require 'erb'
require 'inner_html_content'
require 'rack'

# Create new creation in Tamagotchi game
class Pet
  def call(env)
    [200, {}, [response(env)]]
  end

  def initialize
    @start = false
    veriables
    start_game
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

  def walk
    events = %w[sunny rainy cloudy coldy]
    event = events.sample

    case event
    when 'rainy' || 'coldy'
      @sick = [true, false].sample
      @feeling_value = dec_value(@feeling_value, 2)
      game_message('Pet feeling not good.') if @sick
    when 'sunny'
      game_message("#{@name} happyes todays.")
      @feeling_value = inc_value(@feeling_value, 2)
    else
      game_message('Nothing happened, you returns to home.')
    end

    game_message("You and #{@name} walk. Today #{event} in outside.")

    game_time_pass
  end

  def to_bed
    @sleep_need = false
    sleep_max = 10
    sleep_recovered = 4
    @emoji = "\u{1F605}"

    if @sleep_value > sleep_max
      game_message("Your #{@name} not wanna sleep!")
      return
    end

    @feeling_value = inc_value(@feeling_value, 2)
    @sleep_value = @sleep_value < sleep_max ? @sleep_value + sleep_recovered : @sleep_value
    game_message("#{@name} sleep now...")
    skip_time(3)
    @emoji = "\u{1F634}"
    @sleep_need = false
  end

  def feed
    if poppy?
      @emoji = "\u{1f922}"
      game_message('Need clear area :(. Mess, smell...')
      return
    end

    @belly_value = inc_value(@belly_value, 3)
    @intestine_value = inc_value(@intestine_value, 1)

    game_message('feeding...')
    game_time_pass
  end

  def huge
    @belly_value = inc_value(@belly_value, 2)
    @feeling_value = inc_value(@feeling_value, 2)
    @sleep_value = inc_value(@sleep_value, 2)
    @sick = false
    # it's magic method but what price?
    @reborn = inc_value(@reborn)

    game_message("#{@name} filled self perfectly...")
    game_time_pass
  end

  def cure
    if @sick
      @sick = false
      health(inc_value(@health_array.size))
    else
      game_message("#{@name} recovered.")
    end
    @emoji = "\u{1f604}"
    game_time_pass
  end

  def play(value = 2)
    if @sleep_need
      game_message("Your #{@name} feeling tired!")
    else
      @feeling_value = inc_value(@feeling_value, value)
      game_message("#{@name} play with you and sooooo happy.")
      game_time_pass
    end
  end

  def clear
    @intestine_value = 0 if poppy?

    @feeling_value = inc_value(@feeling_value, 1)
    game_message("You clear our house, #{@name} happy now.")
    game_time_pass
  end

  def skip_time(value = 1)
    value.times do
      game_message('You passed some time...')
      game_time_pass
    end
  end

  private

  def veriables
    names = %w[Dog Dragon Cat Unicorn Monkey]
    @name = names.sample
    @time = 0
    @age = 0
    @health = @name == 'Cat' ? health(9) : health(rand(1..6))
    @sick = false
    @sleep_value = 10
    @feeling_value = 10
    @belly_value = 10
    @intestine_value = 0
    @reborn = 0
    @emoji = "\u{1f604}"

    state
    info
    game_message("#{@name} born.")
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
    hungry? ? health_damaged : game_message("#{@name} need feeding.")
  end

  def poppy?
    @intestine_value >= 6
  end

  def health(value)
    @health_array = value.times
    @health = value.times.map { "\u{2764}" }.join(' ')
  end

  def health_damaged
    game_message('Your pet was damaged, something is wrong?')
    health(dec_value(@health_array.size))
  end

  def sick
    @feeling_value = dec_value(@feeling_value)
    @feeling_value < 7 ? health_damaged : game_message("#{@name} need cures.")
  end

  def tired
    @emoji = "\u{1F614}"
    @feeling_value = dec_value(@feeling_value, 2)
    @sleep_value = dec_value(@sleep_value)
    @sleep_value.negative? ? health_damaged : game_message("#{@name} need some sleep.")
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
    state

    @belly_value = if reborn?
                     dec_value(@belly_value, 4)
                   else
                     dec_value(@belly_value)
                   end

    @intestine_value = inc_value(@intestine_value)

    tired if @sleep_need

    if @sick
      sick
      @emoji = "\u{1f912}"
    end

    if hungry?
      if reborn? && @belly_value < 5
        game_message("#{@name} ear you..")
        exit
      end
      belly
    end

    @emoji = "\u{1f608}" if reborn?

    @sick = [true, false].sample if poppy?

    if @feeling_value.negative?
      game_message("#{@name} run away!")
      exit
    end

    game_timer
    render_html

    return unless game_end?

    game_ends = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    game_message("Your creation is #{game_ends.sample}.")
    @emoji = "\u{2620}"
    render_html
    exit
  end

  def game_timer(value = 1)
    @time = @time < 12 ? inc_value(@time, value) : 0
    @age = @time == 12 ? inc_value(@age, value) : @age

    @sleep_need = true if @time == 10
  end

  def game_message(text)
    puts text
    @message = text
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

  def commands
    @game_methods.map { |v| commands_description(v.to_s) }
  end

  def commands_description(method)
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
    else
      raise StandardError, 'Some error with methods'
    end
  end

  def render_html(file_name = 'content.html.erb')
    template = File.read("./app/view/template/#{file_name}")
    html_content = ERB.new(template).result(binding)
    style_path = '/app/view/style/default.css'
    InnerHTMLContent.add_content("Tamagochi - #{@name}", html_content, style_path, bypass_html: false)
  end

  def start_game
    @start = true
    custom_methods = self.class.instance_methods(false)
    remove_methods = %w[start_game call info help].map(&:to_sym)
    @game_methods = @start ? custom_methods - remove_methods : custom_methods
  end

  def response(env)
    @request = Rack::Request.new(env)
    case @request.path
    when '/'
      render_html
    # when '/leave'
    #   render_html('game_end.html.erb')
    when @request.path
      action_user(@request.path.delete_prefix('/'))
      render_html
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
    puts '_____'
    !action.empty? ? action_reducer(action) : (puts '▼ Empty action, please type anything from there ▼▼▼! ▼')
  end

  def action_reducer(action)
    action = action.to_sym

    case action
    when action_helper(action)
      public_send(action)
    else
      puts "▼ Unknown command --- #{action.upcase} ---, please select current! ▼"
    end
  end

  def action_helper(action)
    @game_methods.detect { |method| method == action }
  end
end
