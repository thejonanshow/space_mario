class Turtle < Sprite
  attr_reader :spawn_time, :x, :y

  def initialize(window, animation)
    super(window, self)

    @window = window
    @animation = animation

    @x = window.width
    @x_speed = rand(7) + 1

    @y_speed = rand(7) + 1
    @starting_y = @y = rand(@window.height)

    @spawn_time = Gosu::milliseconds

    @width = animation.first.width
    @height = animation.first.height

    @direction = 'left'
  end

  def draw
    @x -= @x_speed
    flight_directions = ['up', 'down']

    @flight_direction ||= flight_directions[rand(2)]

    if @flight_direction == 'down'
      @y += @y_speed
    elsif @flight_direction == 'up'
      @y -= @y_speed
    end

    if @y < @animation.first.height && @flight_direction == 'up'
      @flight_direction = 'down'
    elsif @y > @window.height - @animation.first.height && @flight_direction == 'down'
      @flight_direction = 'up'
    end

    image = @animation[Gosu::milliseconds / 100 % @animation.size]
    image.draw(@x - image.width / 2.0, @y - image.height / 2.0, 0, 1, 1, 0xffffffff)
  end

  def off_screen?
    super(self)
  end
end
