"use strict"
define ["Phaser", "player", "foe", "loadLevel"], (Phaser, Player, Foe, ll) -> 
  "use strict"
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      window.p = @
      @game = game
      @player = new Player(game, 100, 200)
      ll.load game
      @game.map.setTileIndexCallback 2, @player.whenHitRed
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @end, this
      @game.physics.p2.gravity.y = 500
      @game.coinsCollected = 0
      @setupCamera()
      @setupEmitter()
      @setupScoreText()
    setupCamera: ->
      width = @game.global.width
      height = @game.global.height
      w = width / 8
      h = height / 3
      @game.camera.follow @player 
      @game.camera.deadzone = 
        new Phaser.Rectangle((500 - (500/8)) / 2, 0 + 30, 40, height - 50)
    setupEmitter: ->
      emitter = game.add.emitter 0, 0, 0, 25
      emitter.makeParticles ["pixel1", "pixel2"]
      emitter.setXSpeed 200, -200
      emitter.setYSpeed 500, -500
      emitter.minParticleScale = 0.7
      emitter.maxParticleScale = 1.2
      emitter.minRotation = 0
      emitter.maxRotation = 100
      emitter.width = 69
      emitter.height = 42
      emitter.gravity = 0
      @game.emitter = emitter
    setupScoreText: ->
      @game.scoreLabel = 
        game.add.text 400, 1, "score: 0",
          font: "20px Arial"
          fill: "#ffffff"
      @game.scoreLabel.fixedToCamera = on
    update: ->
      @player.update()
      #@game.camera.focusOnXY @player.x, 0
      @game.scoreLabel.text = "score: " + @game.coinsCollected
    end: ->
      game.state.start "menu"
  return exports
