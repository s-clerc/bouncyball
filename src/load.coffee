"use strict";
define ["Phaser"], (Phaser) -> 
  "use strict"
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(game.world.centerX, 150, "loading...",
        font: "30px Arial"
        fill: "#ffffff")
      game.load.image "tileset", "assets/tileset.png"
      game.load.tilemap "map", "assets/tilemap.json", null, Phaser.Tilemap.TILED_JSON
      game.load.image "pixel1", "assets/pixel.png"
      game.load.image "pixel2", "assets/cPixel.png"
      game.load.image "pixel3", "assets/tPixel.png"
      game.load.image "coin", "assets/coin.png"
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, 200, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      @game.load.spritesheet "mute", "assets/muteButton.png", 28, 22
      @game.load.image "circle", "assets/circle.png"
      @game.load.image "foe", "assets/foe.png"
      # ...
      return
    create: ->
      @game.state.start "menu"
      return
  return exports
