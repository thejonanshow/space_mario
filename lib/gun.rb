class Gun
  def initialize(window)
    @window = window
    @last_firing_time = 0
    @cooldown = 0
  end

  def fire(x, y)
    if Gosu::milliseconds - @last_firing_time > @cooldown
      Bullet.new(@window, x, y)
      @last_firing_time = Gosu::milliseconds
    end
  end
end
