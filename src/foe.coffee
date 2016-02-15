define ["Phaser" ,"Actor"], (Phaser, Actor) ->
  "use strict"
  exports = {}
  exports.Foe = class Foe extends Actor
    speed: 125
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "foe"
      @body.onBeginContact.add @whenBeginContact
      @body.fixedRotation = yes
      # Negative is towards right
      @speedSet = -200
    whenBeginContact: (a, b, c, d, e) =>
      return unless a
      direction = Math.atan2 a.x-@x, a.y-@y #rad
      if 1 < direction < 2.5
        @speedSet = @speed
      else if -1 > direction > -2.5
        @speedSet = -@speed
    update: =>
      @body.velocity.x = -@speedSet
  exports.makeFoes = (game, group, map, layer) ->
    for child in group.children
      x = child.x
      y = child.y
      w = child.width
      h = child.height
      new Foe(game, x, y)
      child.pendingDestroy = on
      map.removeTileWorldXY x, y, w, h, layer

  exports
