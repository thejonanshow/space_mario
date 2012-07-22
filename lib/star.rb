class Star < Sprite

  def initialize(window, x = nil)
    super(window)

    @window = window
    @x = x ||= rand(window.width)
    @y = rand(window.height)

    colors = [
      0xff333333,
      0xff999999,
      0xffbbbbbb,
      0xffffffff,
      0xffffffff
    ]
    @color = colors[rand(5)]

    @size = rand(30) + 1
    @font = Gosu::Font.new(window, Gosu::default_font_name, @size)

    @speed = 3 + rand(12)

    @width = @height = @size
  end

  def draw
    @x -= @speed
    @font.draw('+', @x, @y, 0, 1, 1, @color, :default)
  end

  def off_screen?
    @x < -@size
  end
end
