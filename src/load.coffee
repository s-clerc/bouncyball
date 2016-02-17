"use strict";
define ["Phaser"], (Phaser) -> 
  "use strict"
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(@game.world.centerX, 150, "loading...",
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
      @game.load.image "foe", "assets/foe.png"
      @game.load.spritesheet "levelselecticons", "assets/levelselecticons.png", 96, 96
      @game.load.image "tileset", "assets/tileset.png"
      @game.load.image "pixel1", "assets/pixel.png"
      @game.load.image "pixel2", "assets/cPixel.png"
      @game.load.image "pixel3", "assets/tPixel.png"
      @game.load.image "coin", "assets/coin.png"
      #levels
      numberOfLevels = 2
      i = 1
      while i <= numberOfLevels
        @game.load.tilemap "level" + i, "levels/" + i + ".json", null, Phaser.Tilemap.TILED_JSON
        i++
      # ...
      return
    create: ->
      @game.state.start "menu"
      return
  return exports
