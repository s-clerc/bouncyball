define ["Phaser" ,"Actor"], (Phaser, Actor) ->
  "use strict"
  exports = class Foe extends Actor
    speed: 125
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "foe"
      @body.onBeginContact.add @whenBeginContact
      @body.gravity.y = 3000
      # Negative is towards right
      @speedSet = -200
    whenBeginContact: (a, b, c, d, e) =>
      direction = Math.atan2 a.x-@x, a.y-@y #rad
      if 1.4 < direction < 1.6
        @speedSet = @speed
      else if -1.4 > direction > -1.6
        @speedSet = -@speed
      console.log Math.atan2 a.x-@x, a.y-@y
    update: =>
      @body.velocity.x = -@speedSet