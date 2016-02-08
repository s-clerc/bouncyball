"use strict"
define ["Phaser", "Actor"], (Phaser, Actor) ->
  exports = class Player extends Actor 
    defaultBounceSpeed: 300
    defaultMovementSpeed: 200
    constructor: (game, x, y, key, frame) ->
      @game = game
      super game, x, y, "circle"
      @game.physics.p2.enable this, game.global.debug
      @body.velocity.y = 300
      @body.onBeginContact.add @whenBeginContact
      @bounceSpeed = @defaultBounceSpeed
      @movementSpeed = @defaultMovementSpeed
    whenBeginContact: (a, b, c, d) =>
      if @body.velocity.y < 0
        @body.velocity.y = @bounceSpeed
      else if @body.velocity.y > 0
        @body.velocity.y = -@bounceSpeed
      console.log @bounceSpeed
    # k is cursor keys
    updateMovement: (k) =>
      if k.left.isDown
        @body.velocity.x = -@movementSpeed
      else if k.right.isDown
        @body.velocity.x = @movementSpeed
