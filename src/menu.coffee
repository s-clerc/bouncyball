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
define ["Phaser"], (Phaser) -> 
  "use strict"
  exports = {}
  exports.MenuState = class MenuState extends Phaser.State
    create: ->
      # Name of the @game
      @game.lang = "fr"
      @game.text = @game.l10n[@game.lang]
      nameLabel = @game.add.text(@game.world.centerX, 80, @game.text.name,
        font: "50px Arial"
        fill: "#ffffff")
      nameLabel.anchor.setTo 0.5, 0.5
      nameLabel.z = 10000000
      # How to start the @game
      startLabel = @game.add.text(@game.world.centerX, @game.world.height - 80, @game.text.upstart,
        font: "25px Arial"
        fill: "#ffffff")
      startLabel.anchor.setTo 0.5, 0.5
      @game.add.tween(startLabel).to({ angle: -2 }, 500).to({ angle: 2 }, 500).loop().start()
      # Add a mute button
      @muteButton = @game.add.button 20, 20, "mute", @toggleSound, this
      @muteButton.input.useHandCursor = true
      if @game.sound.mute
        @muteButton.frame = 1
      # Start the @game when the up arrow key is pressed
      upKey = @game.input.keyboard.addKey Phaser.Keyboard.UP
      upKey.onDown.addOnce @start, this
      return
    toggleSound: ->
      @game.sound.mute = !@game.sound.mute
      @muteButton.frame = if @game.sound.mute then 1 else 0
      return
    start: ->
      @game.state.start "levelSelect"
      return
  return exports

