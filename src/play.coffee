"use strict"
define ["Phaser", "player", "wall"], (Phaser, Player, Wall) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @player = new Player(game, 20, 20)
      @game.add.existing @player
      console.dir @player.isActor
      @game.camera.follow @player
      @createWorld()
    createWorld: ->
      @map = game.add.tilemap "map"
      @map.addTilesetImage "tileset"
      @layer = @map.createLayer "Tile Layer 1"
      @layer.resizeWorld()
      @map.setCollision 1
      @game.physics.p2.convertTilemap @map, @layer
    update: ->
      @player.updateMovement game.input.keyboard
  return exports
