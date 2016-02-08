define ["actor"], (Actor) ->
  "use strict"
  exports = class Wall extends Actor
    constructor: (game, x, y, w, h) ->
      @game = game
      @draw w, h
      super game, x, y, @rect
      @game.physics.p2.enable this, false
      #@body.addRectangle 0, 0, w, h
      @body.dynamic = no
    draw: (w, h) ->
      rect = game.make.bitmapData w, h
      rect.ctx.fillStyle = '#00ff00'
      rect.ctx.fillRect 0, 0, w, h
      @rect = rect


