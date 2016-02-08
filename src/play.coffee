"use strict"
define ["Phaser", "player"], (Phaser, Player) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @player = new Player(game, 20, 20)
      game.add.existing @player
      console.dir @player.isActor
    update: ->
      sprites = game.world.children
      # Do checks
      for sprite in sprites
        # only actors allowed
        return unless sprite.isActor
        
  return exports
