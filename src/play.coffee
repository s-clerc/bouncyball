"use strict"
define ["Phaser", "player", "wall"], (Phaser, Player, Wall) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @player = new Player(game, 50, 50)
      @game.add.existing @player
      console.dir @player.isActor
      #@game.camera.follow @player
      @createWorld()
      @game.map.setTileIndexCallback 2, @player.whenHitRed
      game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @end, this
    createWorld: ->
      map = game.add.tilemap "map"
      map.addTilesetImage "tileset"
      layer = map.createLayer "Tile Layer 1"
      layer.resizeWorld()
      map.setCollisionBetween 1, 2
      @game.physics.p2.convertTilemap map, layer
      @game.map = map
      @game.layer = layer
    update: ->
      @player.updateMovement game.input.keyboard
      @game.camera.focusOnXY @player.x, 0
    end: ->
      game.state.start "menu"
  return exports
