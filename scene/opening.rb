module Scene
  class Opening < Scene::Base
    include Fixture::Select # for use Mouse class
    def initialize
      super
      @next_scene = Scene::Stage2.new
      @string = "Space or Enter"
      @mouse = Mouse.new
    end

    def update
      super
      just_draw

      Window.draw(0, 0, Image.load("images/opening.png"))
    end

    def next_scene
      @next_scene
    end

    def finish?
      # キーコード定数: https://download.eastback.co.jp/dxruby/api/constant_keycode.html
      decide_key = [K_RETURN, K_SPACE]
      decide_key.each do |key|
        return true if Input.key_push?(key)
      end
      return true if Input.pad_push?(6)
      false
    end
  end
end