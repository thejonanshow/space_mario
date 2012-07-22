class Sprite
  attr_reader :x, :y, :size, :width, :height, :direction
end

def initialize(window, obj = nil)
  window.all_sprites.push obj if obj

  @window = window

  @screen_width = window.width
  @screen_height = window.height
end

def off_screen?(obj)
  if obj.direction == 'right'
    obj.x > @screen_width + obj.width
  elsif obj.direction == 'left'
    obj.x < 0 - obj.width
  end
end

def collides_with?(obj)
  x_collision?(obj) && y_collision?(obj)
end

def x_collision?(obj)
  lpoint = obj.x - obj.width / 2.0
  rpoint = obj.x + obj.width / 2.0
  lpoint > (self.x - self.width / 2.0) && lpoint < (self.x + self.width / 2.0) ||
  rpoint > (self.x - self.width / 2.0) && rpoint < (self.x + self.width / 2.0)
end

def y_collision?(obj)
  tpoint = obj.y - obj.width / 2.0
  bpoint = obj.y + obj.width / 2.0
  tpoint > (self.y - self.height / 2.0) && tpoint < (self.y + self.height / 2.0) ||
  bpoint > (self.y - self.height / 2.0) && bpoint < (self.y + self.height / 2.0)
end
