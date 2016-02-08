define ["Phaser", "Actor"], (Phaser, Actor) ->
  "use strict"
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
      # m is key mappings
      m = Phaser.Keyboard
      if k.isDown m.LEFT
        @body.velocity.x = -@movementSpeed
      else if k.isDown m.RIGHT
        @body.velocity.x = @movementSpeed
      else if (k.isDown m.SPACEBAR) and @game.global.spacebarReset
        @body.velocity.x = 0
      else if @game.global.autoReset
        @body.velocity.x = 0
