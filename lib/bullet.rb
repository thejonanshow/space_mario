class Bullet < Sprite
  def initialize(window, x, y)
    super(window, self)

    @window = window

    @x = x
    @y = y
    @speed = rand(20) + 1
    @angle = [-rand(10), rand(10)].sample

    @image = Gosu::Image.new(window, 'media/bullet.png', true)

    window.bullets.push self

    @width = @image.width
    @height = @image.height

    @direction = 'right'
  end

  def draw
    move
    @image.draw(@x - @image.width / 2.0, @y - @image.height / 2.0, 0)
  end

  def move
    up_down = rand(2)
    @y += @angle
    @x += @speed
  end

  def off_screen?
    super(self)
  end

  def collides_with?(obj)
    super(obj)
  end
end
