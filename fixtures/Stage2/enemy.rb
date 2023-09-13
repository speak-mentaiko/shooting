module Fixture::Stage2
  class Enemy < Sprite
    attr_accessor :v,:health,:beams

    include Setting

    def initialize(omega,speed,x,y)
      self.image = Image.load("images/enemy.png")
      self.image.set_color_key(C_WHITE)
      self.x = x
      self.y = y
      self.angle = omega - 90

      @omega = Setting.omega(omega)
      @speed = speed

      @health = 1
      @beams = []

      @beam_x = 0
      @beam_y = 0
      @times = 0

      @player = Player2.new
    end

    def update
      self.x += @speed * Math.cos(@omega)
      self.y += @speed * Math.sin(@omega)
      self.draw


      if @times%20 == 0
        @beams << Beam2.new(self.x,self.y,0,2,1)
      end

      @beams.each { |n| n.update }
      @times += 1
    end

    def damage
      @health -= 1
    end

    def beam_delete(i)
      @beams.delete_at(i)
    end
  end
end