$:.push File.expand_path(File.dirname(__FILE__) + '/lib')

require 'gosu'
require 'sprite'
require 'star'
require 'player'
require 'gun'
require 'bullet'
require 'turtle'

class GameWindow < Gosu::Window
  attr_accessor :bullets, :all_sprites

  def initialize
    super 960, 720, false
    self.caption = "Space Mario!"
    @stars = []
    @bullets = []
    @turtles = []
    @max_turtles = 100
    @max_bullets = 35
    @turtle_spawn_cooldown = 10

    @all_sprites = []

    @game_object_collections = []
    @game_object_collections.push @bullets, @turtles, @stars

    @turtle_animation = Gosu::Image::load_tiles(self, 'media/turtle.png', 32, 54, false)

    @player = Player.new(self)
  end

  def update
    @stars.push Star.new(self, (@stars.length > 40 ? self.width : nil)) unless @stars.length > 50
    @turtles.each do |turtle|
      mario_dies if @player.collides_with? turtle
      @bullets.each do |bullet|
        @turtles.delete turtle if bullet.collides_with? turtle
      end
    end

    if @turtles.length > 0
      last_turtle_spawn_time = @turtles.last.spawn_time
    else
      last_turtle_spawn_time = 0
    end

    @turtles.push Turtle.new(self, @turtle_animation) unless @turtles.length > @max_turtles || Gosu::milliseconds - last_turtle_spawn_time < @turtle_spawn_cooldown

    @game_object_collections.each do |array|
      cleanup(array)
    end

    if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
      @player.move_up
    end
    if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
      @player.move_down
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.move_right
    end
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.move_left
    end
    if button_down? Gosu::KbSpace or button_down? Gosu::GpButton0 then
      @player.gun.fire(@player.x, @player.y) unless @bullets.length > @max_bullets
    end
  end

  def draw
    @game_object_collections.each do |array|
      array.each {|el| el.draw}
    end

    @player.draw
  end

  def cleanup(array)
    array.each {|el| array.delete el if el.off_screen?}
    array
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def mario_dies
    @player.die
    # sleep(5)
    close
  end
end

window = GameWindow.new
window.show
