module Fixture::Stage2
  class Enemy2 < Sprite
    attr_accessor :v,:health,:beams

    def initialize
      self.image = Image.load("images/boss.png")
      self.image.set_color_key(C_WHITE)
      self.x, self.y, = Window.width/2, 10

      @health = 75
      @beams = []

      @beam_x = 0
      @beam_y = 0
      @times = 0

      @player = Player2.new

      @v = rand(7) - 3
    end

    def update
      # 加速度をランダムで決定(-3 ~ 3)
      acceleration = rand(7) - 3
      # 速さのスカラーを最大10として、速度を計算
      @v += acceleration
      limitted_v = @v.abs % 10
      @v = @v < 0 ? -limitted_v : limitted_v
      self.x = self.x + @v

      if self.x < 0
        self.x = 0
      elsif self.x > Window.width - 30
        self.x = Window.width - 30
      end

      if @times%20 == 0
        @beams << Beam2.new(self.x,self.y,0,2,1)
      end

      if @times%75 == 0
         @beam_y = (@player.y - self.y)/100
         @beam_x = (@player.x - self.x)/100
         @beams << Beam2.new(self.x + 200,self.y + 10,@beam_x,@beam_y,2)
         @beams << Beam2.new(self.x - 200,self.y + 10,@beam_x,@beam_y,2)
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