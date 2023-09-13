module Scene
  class Score < Scene::Base
    include Fixture::Select
    def initialize(stage_num, time, enemy_health)
      @stage_num = stage_num
      @time = time / 60
      @enemy_health = enemy_health
      @background = Image.load("images/result_background.jpg")

      button_size_x = 120
      button_image = Image.new(button_size_x, 100, C_WHITE)

      @retry_button = Sprite.new(Window.width / 4     - (button_size_x / 2), Window.height / 2, button_image)
      @choose_stage = Sprite.new(Window.width / 2     - (button_size_x / 2), Window.height / 2, button_image)
      @finish_button = Sprite.new(Window.width / 4 * 3 - (button_size_x / 2), Window.height / 2, button_image)
      @mouse = Mouse.new
      @checker = false
    end

    def update
      @mouse.update
      if @enemy_health <= 0
        Window.draw(0, 0, @background)
        Window.draw_font(100, Window.height / 3, "You Win!", Font.new(64))
        Window.draw_font(Window.width / 6,Window.height / 4 * 3, "Time : #{@time}", Font.new(96),)
      else #　負けた時
        @background = Image.load("./images/Lose_haikei.png")
        Window.draw(0, 0, @background)
        Window.draw_font(100, Window.height / 3, "You Lose...", Font.new(64))
      end
      @retry_button.draw
      Window.draw_font(Window.width / 4 - (120 / 2) + 10, Window.height / 2 + 30, "RETRY", Font.new(32), color: C_BLACK)
      @finish_button.draw
      Window.draw_font(Window.width / 4 * 3 - (120 / 2) + 10, Window.height / 2 + 30, "FINISH", Font.new(32), color: C_BLACK)

      if Input.mouse_push?(M_LBUTTON)
        if @mouse === @retry_button
          @next_scene = Scene::Opening.new
          @checker = true
        elsif @mouse === @finish_button
          @checker = true
          @next_scene = nil
        end
      end
    end


    def next_scene
      @next_scene
    end
    
    def finish?
      return true if @checker
      false
    end

  end
end