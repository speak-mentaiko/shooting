module Fixture::Stage2
  class Player2 < Sprite
    attr_accessor :health,:beams

    def initialize
      self.x = Window.width/2
      self.y = 500
      self.image = Image.load("images/player.png")
      @beams = []
      @health = 10
      self.image.set_color_key(C_WHITE)
    end

    def update
      @input = Input.pads

      if Input.key_down?(K_W) || @input.include?(2) || @input.include?(22) || Input.key_down?(K_UPARROW)
        self.y -= 3
      elsif Input.key_down?(K_S) || @input.include?(3) || @input.include?(23) || Input.key_down?(K_DOWNARROW)
        self.y += 3
      end
      if Input.key_down?(K_A) || @input.include?(0) || @input.include?(20) || Input.key_down?(K_LEFTARROW)
        self.x -= 3
      elsif Input.key_down?(K_D) || @input.include?(1) || @input.include?(21) || Input.key_down?(K_RIGHTARROW)
        self.x += 3
      end
      if Input.key_push?(K_SPACE) || Input.pad_push?(5)
        @beams << Beam2.new(self.x,self.y,0,-4,0)
      end
      if Input.key_push?(K_B) || Input.pad_push?(6)
        i = 1
        while i <= 8
          x = 8 * Math.cos(i * 45)
          y = 8 * Math.sin(i * 45)
          @beams << Beam2.new(self.x,self.y,x,y,4)
          i += 1
        end
      end
      @beams.each do |n|
        n.update
      end

      if self.x < 0
        self.x = 0
      elsif self.x > Window.width - 30
        self.x = Window.width - 30
      end

      if self.y < 0
        self.y = 0
      elsif self.y > Window.height - 40
        self.y = Window.height - 40
      end
    end

    def damage
      @health -= 1
    end

    def beam_delete(i)
      @beams.delete_at(i)
    end
  end
end