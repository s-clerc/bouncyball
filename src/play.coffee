"use strict"
define ["Phaser", "player"], (Phaser, Player) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @player = new Player(game, 20, 20)
      game.add.existing @player
      console.dir @player.isActor
      @cursor = game.input.keyboard.createCursorKeys()
    update: ->
      @player.updateMovement @cursor
  return exports
