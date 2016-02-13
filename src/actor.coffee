define ["Phaser"], (Phaser) ->
  "use strict"
  exports = class Actor extends Phaser.Sprite
    isActor: yes
    constructor: (game, x, y, key, frame) ->
      super game, x, y, key, frame
      @game = game
      @game.physics.p2.enable this, @game.global.debug
      @game.add.existing this
      @createEvents()
    createEvents: ->
