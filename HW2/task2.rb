# app/models/user.rb

# Create new creation in Tamagotchi game
class Pet
  def initialize(name = 'Unknown creation')
    @name = name
    @health = health(rand(1..6))
    puts "#{@name} burn."
  end

  def walk
    puts 'You and your pets walk outside'
    time_past
  end

  def info
    puts "
    ________#{@name}________
    HP: #{@health}
    age creation: #{@age}
    ☻☹㋡
    "
  end

  private

  def time_past
    # puts age(@age += 1)
    # health(@health - 1)
    # puts @health

    if dead?
      puts 'Your creation is dead'
    end
    # puts info
  end

  def health(value)
    @health = value.times.map { '♥' }.join(' ')
  end

  def age(value = 0)
    @age = value
  end

  def dead?
    @health.split(' ').to_a.size <= 0
  end
end

pet = Pet.new

pet.info
pet.info
