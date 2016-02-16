define ["Phaser", "actor"], (Phaser, Actor) ->
  exports = class Coin extends Actor
    name: "coin"
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "coin"
      @body.data.gravityScale = 0
      @body.static = yes