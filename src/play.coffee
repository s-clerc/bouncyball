"use strict"
define ["Phaser", "player", "foe"], (Phaser, Player, Foe) -> 
  "use strict"
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      window.p = @
      @game = game
      @player = new Player(game, 100, 200)
      @createWorld()
      @game.map.setTileIndexCallback 2, @player.whenHitRed
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @end, this
      @game.physics.p2.gravity.y = 500
      @setupCamera()
    createWorld: ->
      map = game.add.tilemap "map"
      map.addTilesetImage "tileset"
      layer = map.createLayer "Tile Layer 1"
      layer.resizeWorld()
      map.setCollisionBetween 1, 2
      @game.physics.p2.convertTilemap map, layer
      @game.map = map
      @game.layer = layer
      @game.foes = @game.add.group()
      map.createFromTiles 3, null, "foe", layer, @game.foes
      Foe.makeFoes @game, @game.foes, @game.map, @game.layer
    setupCamera: ->
      width = @game.global.width
      height = @game.global.height
      w = width / 8
      h = height / 3
      @game.camera.follow @player
      @game.camera.deadzone = 
        new Phaser.Rectangle((500 - (500/8)) / 2, 0 + 30, 40, height - 50)
    update: ->
      @player.update()
      #@game.camera.focusOnXY @player.x, 0
    end: ->
      game.state.start "menu"
  return exports
