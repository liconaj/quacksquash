require "app/game"

def tick args
  $console.open if args.keyboard.key_down.c
  $gtk.reset if args.inputs.keyboard.key_down.r

  $game ||= Game.new
  $game.args = args
  $game.tick
end

$gtk.reset
$game = nil
