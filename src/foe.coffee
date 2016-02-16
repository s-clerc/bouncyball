define ["Phaser" ,"Actor"], (Phaser, Actor) ->
  "use strict"
  exports = {}
  exports = class Foe extends Actor
    speed: 125
    tileType: "foe"
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "foe"
      @body.onBeginContact.add @whenBeginContact
      @body.fixedRotation = yes
      # Negative is towards right
      @speedSet = -200
      @kinematic = yes
    whenBeginContact: (a, b, c, d, e) =>
      return unless a
      direction = Math.atan2 a.x-@x, a.y-@y #rad
      if 0.5 < direction < 2.5
        @speedSet = @speed
      else if -0.5 > direction > -2.5
        @speedSet = -@speed
    update: =>
      @body.velocity.x = -@speedSet


  exports
