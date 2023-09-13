module Util
  def calc_length_per_drawing(distance: 0, time: 0) # distance [px], time [sec]
    # timeが 0 以下の場合は 移動できないので、0
    return 0 if time < 1

    # Window.real_fpsはコマ落ち考慮なので、objectのupdate用計算では使用しない
    return (length / time) * Window.fps
  end
end