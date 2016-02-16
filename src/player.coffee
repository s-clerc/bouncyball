define ["Phaser", "Actor"], (Phaser, Actor) ->
  "use strict"
  exports = class Player extends Actor 
    defaultBounceSpeed: 300
    defaultMovementSpeed: 200
    constructor: (game, x, y, key, frame) ->
      @game = game
      super game, x, y, "circle"
      @game.add.existing this
      @body.clearShapes()
      @body.addCircle 15
      @body.onBeginContact.add @whenBeginContact
      @body.data.gravityScale = 0
      @bounceSpeed = @defaultBounceSpeed
      @movementSpeed = @defaultMovementSpeed
      @body.velocity.y = @bounceSpeed
    whenBeginContact: (a, b, c, d, e) =>
      @body.data.gravityScale = 0
      if @body.velocity.y < 0
        @body.velocity.y = @bounceSpeed
      else if @body.velocity.y > 0
        @body.velocity.y = -@bounceSpeed 
      # collide with killer tile
      return unless a
      tile = @game.map.getTileWorldXY a.x, a.y if a
      if tile
        if tile.properties.damage > 0
          @die()
      # not tile
      else
        if a.sprite.tileType == "foe"
          @die()
        else if a.sprite.tileType == "coin"
          @game.coinsCollected += 1
          a.sprite.kill()
        else if a.sprite.tileType == "end"
          game.state.start "menu"
    # k is cursor keys
    update: =>
      # m is key mappings
      k = @game.input.keyboard
      m = Phaser.Keyboard
      if (k.isDown m.RIGHT) and
         (k.isDown m.LEFT) and 
         @game.global.spacebarReset
        @body.velocity.x = 0
      else if k.isDown m.LEFT
        @body.velocity.x = -@movementSpeed
        @scale.setTo(-1, 1);
      else if k.isDown m.RIGHT
        @body.velocity.x = @movementSpeed
      else if k.isDown m.UP
        @body.velocity.y = 0
      else if (k.isDown m.SPACEBAR) and @game.global.spacebarReset
        @body.velocity.x = 0
      else if @game.global.autoReset
        @body.velocity.x = 0
    die: ->
      @game.emitter.x = @x 
      @game.emitter.y = @y;
      @game.emitter.start true, 600, null, 15
      @kill()
      @game.time.events.add 700, @restart, this
    restart: ->
      @game.state.start "play"