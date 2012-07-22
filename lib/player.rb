class Player < Sprite
  attr_reader :gun, :x, :y, :animation

  def initialize(window)
    @window = window
    @animation = Gosu::Image::load_tiles(window, "media/mario.png", 48, 56, false)
    @x = 75
    @y = 75

    @death_song = Gosu::Song.new(window, "media/mario_dies.wav")

    @gun = Gun.new(window)

    @width = @animation.first.width
    @height = @animation.first.height
  end

  def draw
    image = @animation[Gosu::milliseconds / 100 % @animation.size]
    image.draw(@x - image.width / 2.0, @y - image.height / 2.0, 0, 1, 1, 0xffffffff)
  end

  def move_down
    7.times do
      @y += 1 unless @y > @window.height - @animation.first.height
    end
  end

  def move_up
    7.times do
      @y -= 1 unless @y <= @animation.first.height
    end
  end

  def collides_with?(obj)
    super(obj)
  end

  def die
    @death_song.play
  end
end
