###
  "Better than skype" a silly game
  Copyright (C) 2016 Swissnetizen

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
###
"use strict"
define ["Phaser", "player", "foe", "loadLevel", "../stats.min"], (Phaser, Player, Foe, ll, stats) -> 
  "use strict"
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      window.p = @
      @game = game
      @player = new Player(game, 100, 200)
        # level doesnt exist
      unless ll.load game
        alert "Level cannot be loaded"
        @error = yes
        return @end()
      @game.map.setTileIndexCallback 2, @player.whenHitRed
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @end, this
      @game.physics.p2.gravity.y = 500
      @game.coinsCollected = 0
      @setupCamera()
      @setupEmitter()
      @setupScoreText()
      @setupStats() if @game.global.debug
      @setupSounds()
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
    setupStats: ->
      stats = new Stats()
      stats.setMode(0) # 0: fps, 1: ms
      # Align top-left
      stats.domElement.style.position = 'absolute'
      stats.domElement.style.left = '0px'
      stats.domElement.style.top = '0px'
      document
        .getElementById("gameDiv")
        .appendChild stats.domElement
      @stats = stats
    setupSounds: ->
                                        # key, volume, loop?, connect
      @game.sounds.coin = game.add.audio "coinSound", 375/1000
      @game.sounds.die = game.add.audio "dieSound", 500/1000
      @game.sounds.bounce = game.add.audio "bounceSound", 300/1000
      @music = game.add.audio "music", 250/1000, on
      @music.play()
    update: ->
      return if @error
      @stats.begin() if @game.global.debug
      @player.update() 
      #@game.camera.focusOnXY @player.x, 0
      @game.scoreLabel.text = "score: " + @player.coinsCollected
      @stats.end() if @game.global.debug
    nextLevel: ->
      randstars = Math.round ((@player.coinsCollected / @game.level.totalCoins) * 3)
      console.log randstars
      # set nr of stars for this level
      @game.playerData[@game.level.number - 1] = randstars
      # unlock next level
      console.log @game.playerData
      if @game.level.number < @game.playerData.length
        if @game.playerData[@game.level.number] < 0
          # currently locked (=-1)
          @game.playerData[@game.level.number] = 0
          # set unlocked, 0 stars
      # and write to local storage
      window.localStorage.setItem 'progress', JSON.stringify(@game.playerData)
      @game.level.number += 1
      @music.stop() if @music
      game.state.start "play"
    end: ->
      @music.stop() if @music
      game.state.start "levelSelect"

  return exports
