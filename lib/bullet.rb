class Bullet < Sprite
  def initialize(window, x, y)
    super(window, self)

    @window = window

    @x = x
    @y = y
    @speed = 25

    @image = Gosu::Image.new(window, 'media/bullet.png', true)

    window.bullets.push self

    @width = @image.width
    @height = @image.height

    @direction = 'right'
  end

  def draw
    @x += @speed
    @image.draw(@x - @image.width / 2.0, @y - @image.height / 2.0, 0)
  end

  def off_screen?
    super(self)
  end

  def collides_with?(obj)
    super(obj)
  end
end
