# Initialize Phaser
requirejs.config (
    baseUrl: "js"
    paths: 
      Phaser:   "../phaser"
)
require ["Phaser", "boot", "load", "menu", "play", "levelSelect"], (Phaser, boot, load, menu, play, LevelSelect) ->
  "use strict"
# Our "globals" variable
  global = 
    score: 0
    debug: on
    width: 500
    height: 360
    spacebarReset: on
    autoReset: off
  window.game = new Phaser.Game(global.width, global.height, Phaser.AUTO, "gameDiv")
  game.global = global
  # Define states
  game.state.add "boot", new boot.BootState
  game.state.add "load", new load.LoadState
  game.state.add "menu", new menu.MenuState
  game.state.add "play", new play.PlayState
  game.state.add "levelSelect", new LevelSelect
  # Start the "boot" state
  game.state.start "boot"
