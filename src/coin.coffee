define ["Phaser", "actor"], (Phaser, Actor) ->
  exports = class Coin extends Actor
    tileType: "coin"
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "coin"
      @body.data.gravityScale = 0
      #@body.static = yes
      game.add.tween(this.body)
        .to({y:"-20"}, 300)
        .to({y:"+20"}, 300)
        .loop()
        .start()
