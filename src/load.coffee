"use strict";
define ["Phaser"], (Phaser) -> 
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(game.world.centerX, 150, "loading...",
        font: "30px Arial"
        fill: "#ffffff")
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, 200, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      @game.load.spritesheet "mute", "assets/muteButton.png", 28, 22
      @game.load.image "circle", "assets/circle.png"
      # ...
      return
    create: ->
      @game.state.start "menu"
      return
  return exports
