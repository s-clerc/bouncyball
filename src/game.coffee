# Initialize Phaser
requirejs.config (
    baseUrl: "js"
    paths: 
      Phaser:   "../phaser"
)
require ["Phaser", "boot", "load", "menu", "play"], (Phaser, boot, load, menu, play) ->
  "use strict"
# Our "globals" variable
  global = 
    score: 0
    debug: on
    width: 500
    height: 350
    spacebarReset: on
    autoReset: off
  window.game = new Phaser.Game(global.width, global.height, Phaser.AUTO, "gameDiv")
  game.global = global
  # Define states
  game.state.add "boot", new boot.BootState
  game.state.add "load", new load.LoadState
  game.state.add "menu", new menu.MenuState
  game.state.add "play", new play.PlayState
  # Start the "boot" state
  game.state.start "boot"
