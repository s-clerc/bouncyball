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
"use strict";
define ["Phaser"], (Phaser) -> 
  "use strict"
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(@game.world.centerX, 150, "loading...",
        font: "30px Arial"
        fill: "#ffffff")
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, 200, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      @game.load.spritesheet "mute", "assets/muteButton.png", 28, 22
      @game.load.image "circle", "assets/circle.png"
      @game.load.image "foe", "assets/foe.png"
      @game.load.spritesheet "levelselecticons", "assets/levelselecticons.png", 96, 96
      @game.load.image "tileset", "assets/tileset.png"
      @game.load.image "pixel1", "assets/pixel.png"
      @game.load.image "pixel2", "assets/cPixel.png"
      @game.load.image "pixel3", "assets/tPixel.png"
      @game.load.image "coin", "assets/coin.png"
      @game.load.image "green", "assets/green.png"
      @game.load.json "l10n", "l10n.json"
      @game.load.image "swiss", "assets/swiss.png"
      @game.sounds = {}
      sounds = [
        "coin",
        "die",
        "bounce"
      ]
      for sound in sounds
        @game.load.audio sound + "Sound", "assets/"+sound+".wav"
      @game.load.audio "music",  "assets/music.ogg"
      #levels
      numberOfLevels = 12
      i = 1
      while i <= numberOfLevels
        @game.load.tilemap "level" + i, "levels/" + i + ".json", null, Phaser.Tilemap.TILED_JSON
        i++
      # ...
      return
    create: ->
      @game.l10n = game.cache.getJSON "l10n"
      @game.state.start "menu"
      return
  return exports
