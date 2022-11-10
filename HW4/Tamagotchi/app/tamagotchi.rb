# frozen_string_literal: true

require 'erb'
require 'inner_html_content'
require 'rack'
require 'json'

require './app/controllers/game_engine'
require './app/controllers/action_user'
require './app/controllers/game_command_list'
require './app/controllers/pet_state'

# Create new creation in Tamagotchi game
class Pet
  include GameEngine
  include ActionUser
  include GameCommandList
  include PetState

  def call(env)
    [200, {}, [action_response(env)]]
  end

  def initialize
    @start = false
    setup
    start_game
  end

  def restart
    setup
    start_game
  end

  def walk
    event = %w[sunny rainy cloudy coldy].sample
    case event
    when 'rainy' || 'coldy'
      @sick = [true, false].sample
      @feeling_value = dec_value(@feeling_value, 1)
    when 'sunny'
      game_message("#{@name} happyes todays.")
      @feeling_value = inc_value(@feeling_value, 2)
    else
      game_message('Nothing happened, you returns to home.')
    end
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
    if PetState.poopy(@intestine_value)
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
    @reborn_value = inc_value(@reborn_value)

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
    @intestine_value = 0 if PetState.poopy(@intestine_value)

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

  def setup
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
    @reborn_value = 0
    @emoji = "\u{1f604}"

    @mental_state = [@sleep_value, @feeling_value, @belly_value]

    state_info
    game_message("#{@name} born.")
  end

  def state_info
    @name = PetState.reborn(@reborn_value) ? 'Monster' : @name
    @feeling_info = @sick ? 'sick' : 'normal'
    @mood_info = PetState.mood(@mental_state) ? 'happy' : 'upset'
    @sleep_info = @sleep_need ? 'sleepy' : 'no need sleep'
    @hungry_info = PetState.hungry(@belly_value) ? 'wanna eat' : 'full'
    @poopy_info = PetState.poopy(@intestine_value) ? 'something smell' : 'everything fine'
  end

  ## Pet methods ##
  def health(value)
    @health_array = value.times
    @health = value.times.map { "\u{2764}" }.join(' ')
  end

  def health_damaged
    game_message('Your pet was damaged, something is wrong?', 'warring')
    health(dec_value(@health_array.size))
  end

  def sick
    @emoji = "\u{1f912}"
    @feeling_value = dec_value(@feeling_value)
    @feeling_value < 7 ? health_damaged : game_message("#{@name} need cures.")
  end

  def tired
    @emoji = "\u{1F614}"
    @feeling_value = dec_value(@feeling_value, 2)
    @sleep_value = dec_value(@sleep_value)
    @sleep_value.negative? ? health_damaged : game_message("#{@name} need some sleep.")
  end

  def belly
    if PetState.hungry(@belly_value)
      game_message("#{@name} eat you..", 'alert') unless @name == 'Monster' && @belly_value < 5
      health_damaged
    else
      game_message("#{@name} need feeding.")
    end
  end

  ## Engine methods ##
  def game_time_pass
    state_info

    sick if @sick
    tired if @sleep_need
    belly
    @sick = [true, false].sample if PetState.poopy(@intestine_value)

    @emoji = "\u{1f608}" if PetState.reborn(@reborn_value)
    game_message("#{@name} run away!", 'alert') if @feeling_value.negative?

    @belly_value = PetState.reborn(@reborn_value) ? dec_value(@belly_value, 4) : dec_value(@belly_value)
    @intestine_value = inc_value(@intestine_value)

    game_timer
    return unless PetState.dead(@health_array)

    @game_methods = ['restart'.to_sym]
    @emoji = "\u{2620}"
    end_event = ['dead', 'sleep forever', 'run away', 'return to Skytown']

    game_message("Your creation is #{end_event.sample}.", 'alert')
  end

  def game_timer(value = 1)
    @time = @time < 12 ? inc_value(@time, value) : 0
    @age = @time == 12 ? inc_value(@age, value) : @age

    @sleep_need = true if @time == 10
  end

  def start_game
    @start = true
    public_methods = self.class.instance_methods(false)

    @game_methods = GameEngine.methods(@start, public_methods)
  end

  def inc_value(value_name, num = 1)
    value_name + num
  end

  def dec_value(value_name, num = 1)
    value_name - num
  end

  # Handler user action
  def game_message(text, message_class = 'info')
    @message = GameEngine.message(text, message_class)
  end

  def render_html(file_name = 'content.html.erb')
    template = File.read("./app/view/template/#{file_name}")
    html_content = ERB.new(template).result(binding)
    style_path = '/app/view/style/default.css'
    InnerHTMLContent.add_content("Tamagochi - #{@name}", html_content, style_path, bypass_html: false)
  end

  def action_response(env)
    request = Rack::Request.new(env)
    case request.path
    when '/'
      # render_html
      render_html('login_page.html.erb')
    when '/login'
      request_data = request.body.read

      p request_data
      json = JSON.parse(request_data)
      render_html('404.html.erb')


      render_html
    when '/game'
      render_html
    when request.path
      virify_acttion = ActionUser.action_user(request.path, @game_methods)

      if virify_acttion.nil?
        render_html('404.html.erb')
      else
        public_send(virify_acttion)
        PetState.dead(@health_array) ? render_html('game_end.html.erb') : render_html
      end
    end
  end
end
