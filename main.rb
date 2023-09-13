require 'dxruby'

Dir['setting.rb',
    'fixtures/*.rb',
    'fixtures/main_game/*.rb',
    'fixtures/Stage1/*.rb',
    'fixtures/Stage2/*.rb',
    'fixtures/Stage3/*.rb',
    'fixtures/mouse/*.rb',
    'scene/*.rb'].each do |file|
  require_relative file
end

$path = __dir__

scene = Scene::Opening.new

Window.loop do
  scene.update
  scene = scene.next_scene if scene.finish?
  Window.close unless scene
end
