# 画面サイズ設定
Window.width = 800
Window.height = 600

# ウィンドウのタイトル
Window.caption = "shooting"

module Setting
  DEFAULT_FONT_SIZE = 24
  TITLE_FONT_SIZE   = 48
  ENDING_FONT_SIZE  = 48

  X_MAX = 800
  Y_MAX = 600

  def omega(t)
    return (t * Math::PI / 180)
  end

  module_function :omega
end
