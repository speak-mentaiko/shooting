module Fixture::Stage2
  class Beam2 < Sprite
    def initialize(x, y, speed_x,speed_y,type)
      self.x = x
      self.y = y
      @speed_x = speed_x
      @speed_y = speed_y
      @bomb = false

      if type == 0
        self.image = Image.load("images/player2_bullet.png")
        self.image.set_color_key(C_WHITE)
      elsif type == 1
        self.image = Image.load("images/enemy_bullet.png")
      elsif type == 2
        self.image = Image.load("images/beam.png")
      else type == 4
        self.image = Image.load("images/player2_bullet.png")
        self.image.set_color_key(C_WHITE)
        @bomb = true
      end
    end

    def update
        self.x += @speed_x
        self.y += @speed_y
        self.draw
    end
  end
end