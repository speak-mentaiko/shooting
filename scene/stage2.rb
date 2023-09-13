module Scene
  # クラス名変更
  class Stage2 < Scene::Base

    # ステージ番号に変更
    include Fixture::Stage2
    def initialize
      super

      @player = Player2.new
      @boss = Enemy2.new
      @enemys = []

      @times = 0
      @e_num = 0

      @background = Image.load("images/back.png", 0, 0, Window.width, Window.height)
    end

    def update
      super
      move_background_down_and_draw

      @player.update
      @player.draw

      if @e_num >= 20
        @boss.update
        @boss.draw
      end

      @enemys.each do |n|
        n.update
      end


      if @times%25 == 0
        if rand(0..1) == 1
          x = -10
          omega = rand(-90..90)
        else
          x = Setting::X_MAX + 10
          omega = rand(90..270)
        end
        y = rand(0..Setting::Y_MAX)
        @enemys << Enemy.new(omega,5,x,y)
      end

      # 衝突判定
      if @player === @boss
        @player.damage
      end

      f = 0
      for enemy_beam in @boss.beams
        if @player === enemy_beam
          @player.damage
          @boss.beam_delete(f)
        end
        if enemy_beam.y >= Window.height + 10
          @boss.beam_delete(f)
        end
        f += 1
      end

      i = 0
      for player_beam in @player.beams
        if @boss === player_beam
          @boss.damage
          @player.beam_delete(i)
        end
        @enemys.each_with_index do |m,j|
          if m === player_beam
            m.damage
            @e_num += 1
            @player.beam_delete(i)
            @enemys.delete_at(j)
          end
        end
        if player_beam.y <= -10
          @player.beam_delete(i)
        end
        i += 1
      end

      @enemys.each_with_index do |enemy,i|
        enemy.beams.each_with_index do |y,i|
          if y === @player
            @player.damage
            enemy.beam_delete(i)
          end
        end
        if enemy === @player
          @player.damage
          @enemys.delete_at(i)
        end
        if enemy.x <= -20 || enemy.x >= Setting::X_MAX + 20 || enemy.y >= Setting::Y_MAX
          @enemys.delete_at(i)
        end
      end

      Window.draw_font(10, 0, "PLAYER HP:#{@player.health}", Font.default,:color => C_WHITE)

      @times += 1
    end

    def next_scene
      # 勝利判定で敵の体力を使います
      Scene::Score.new(2,@times,@boss.health)
    end

    def finish?
      return true if @player.health <= 0 || @boss.health <= 0 || Input.key_push?(K_ESCAPE)
      false
    end
  end
end