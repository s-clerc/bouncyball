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
    whenBeginContact: (a, b, c, d, e) =>
      console.dir this
      if @body.velocity.y < 0
        @body.velocity.y = @bounceSpeed
      else if @body.velocity.y > 0
        @body.velocity.y = -@bounceSpeed
      tile = @game.map.getTileWorldXY a.x, a.y
      if tile.properties.damage > 0
        @kill()
        @game.state.start "menu"
    whenHitRed: (sprite, tile) ->
      console.log "sprite"
    # k is cursor keys
    updateMovement: (k) =>
      # m is key mappings
      m = Phaser.Keyboard
      if (k.isDown m.RIGHT) and (k.isDown m.LEFT) and @game.global.spacebarReset
        @body.velocity.x = 0
      else if k.isDown m.LEFT
        @body.velocity.x = -@movementSpeed
      else if k.isDown m.RIGHT
        @body.velocity.x = @movementSpeed
      else if (k.isDown m.SPACEBAR) and @game.global.spacebarReset
        @body.velocity.x = 0
      else if @game.global.autoReset
        @body.velocity.x = 0
