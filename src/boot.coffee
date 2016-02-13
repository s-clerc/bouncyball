"use strict"
define ["Phaser"], (Phaser) -> 
  "use strict"
  exports = {}
  exports.BootState = class BootState extends Phaser.State
    preload: ->
      @game.load.image "progressBar", "assets/progressBar.png"
      return
    create: ->
      # Set a background color and the physics system
      @game.stage.backgroundColor = "#3498db"
      @game.physics.startSystem Phaser.Physics.P2JS
      @game.state.start "load"
      return
  return exports