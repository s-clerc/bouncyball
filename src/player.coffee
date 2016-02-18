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
define ["Phaser", "Actor"], (Phaser, Actor) ->
  "use strict"
  exports = class Player extends Actor 
    defaultBounceSpeed: 300
    defaultMovementSpeed: 200
    coinsCollected: 0
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
      unless a
        @game.sounds.bounce.play()
        return
      tile = @game.map.getTileWorldXY a.x, a.y if a
      if tile
        if tile.properties.damage > 0
          @die()
        else 
          @game.sounds.bounce.play()
      # not tile
      else
        if a.sprite.tileType == "foe"
          @die()
        else if a.sprite.tileType == "coin"
          @coinsCollected += 1
          a.sprite.kill()
          @game.sounds.coin.play()
        else if a.sprite.tileType == "end"
          game.state.states.play.nextLevel()
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
      else if k.isDown m.UP and off
        @body.velocity.y = 0
      else if (k.isDown m.SPACEBAR) and @game.global.spacebarReset
        @body.velocity.x = 0
      else if @game.global.autoReset
        @body.velocity.x = 0
    die: ->
      @game.emitter.x = @x 
      @game.emitter.y = @y;
      @game.emitter.start true, 600, null, 15
      @game.sounds.die.play()
      @kill()
      @game.time.events.add 10, @restart, this
    restart: ->
      @game.state.states.play.music.stop()
      @game.state.start "play"