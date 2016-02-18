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
define ["Phaser"], (Phaser) ->
  "use strict"
  exports = class LevelSelect extends Phaser.State
    preload: ->
      # created with http://kvazars.com/littera/
      @initProgressData()
      @holdicons = []
      return
    create: ->
      @game.level = 
        totalCoins : 0
      @game.stage.backgroundColor = 0x80a0ff
      #@game.add.bitmapText 256, 24, "font72", "Select a level!", 48
      @createLevelIcons()
      @animateLevelIcons()
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @end, this
      return
    initProgressData: ->
      # array might be undefined at first time start up
      if !@game.playerData
        # retrieve from local storage (to view in Chrome, Ctrl+Shift+J -> Resources -> Local Storage)
        str = window.localStorage.getItem("progress")
        # error checking, localstorage might not exist yet at first time start up
        try
          @game.playerData = JSON.parse(str)
        catch e
          @game.playerData = []
          #error in the above string(in this case,yes)!
        # error checking just to be sure, if localstorage contains something else then a JSON array (hackers?)
        if Object::toString.call(@game.playerData) != "[object Array]"
          @game.playerData = []
      return
    createLevelIcons: ->
      levelNumber = 0
      y = 0
      while y < 3
        x = 0
        while x < 4
          # next level
          levelNumber = levelNumber + 1
          # check if array not yet initialised
          if typeof @game.playerData[levelNumber - 1] != "number"
            # value is null or undefined, i.e. array not defined or too short between app upgrades with more levels
            if levelNumber == 1
              @game.playerData[levelNumber - 1] = 0
              # level 1 should never be locked
            else
              @game.playerData[levelNumber - 1] = -1
          # player progress info for this level
          playdata = @game.playerData[levelNumber - 1]
          # decide which icon
          isLocked = true
          # locked
          stars = 0
          # no stars
          # check if level is unlocked
          if playdata > -1
            isLocked = false
            # unlocked
            if playdata < 4
              stars = playdata
            # 0..3 stars
          # calculate position on screen
          xpos = 0 + x * 128
          ypos = 0 + y * 128
          # create icon
          @holdicons[levelNumber - 1] = @createLevelIcon(xpos, ypos, levelNumber, isLocked, stars)
          backicon = @holdicons[levelNumber - 1].getAt(0)
          # keep level nr, used in onclick method
          backicon.health = levelNumber
          # input handler
          backicon.inputEnabled = true
          backicon.events.onInputDown.add @onSpriteDown, this
          x++
        y++
      return
    createLevelIcon: (xpos, ypos, levelNumber, isLocked, stars) ->
      # create new group
      IconGroup = @game.add.group()
      IconGroup.x = xpos
      IconGroup.y = ypos
      # keep original position, for restoring after certain tweens
      IconGroup.xOrg = xpos
      IconGroup.yOrg = ypos
      # determine background frame
      frame = 0
      if isLocked == false
        frame = 1
      # add background
      icon1 = @game.add.sprite(0, 0, "levelselecticons", frame)
      IconGroup.add icon1
      # add stars, if needed
      unless isLocked
        txt = @game.add.text(32, 10, levelNumber,
          font: "50px Arial"
          fill: "#ffffff")
        icon2 = @game.add.sprite(0, 0, "levelselecticons", 2 + stars)
        IconGroup.add txt
        IconGroup.add icon2
      IconGroup
    onSpriteDown: (sprite, pointer) ->
      # retrieve the iconlevel
      levelNumber = sprite.health
      if @game.playerData[levelNumber - 1] < 0
        # indicate it"s locked by shaking left/right
        IconGroup = @holdicons[levelNumber - 1]
        xpos = IconGroup.xOrg
        tween = @game.add.tween(IconGroup).to({ x: xpos + 6 }, 20, Phaser.Easing.Linear.None).to({ x: xpos - 5 }, 20, Phaser.Easing.Linear.None).to({ x: xpos + 4 }, 20, Phaser.Easing.Linear.None).to({ x: xpos - 3 }, 20, Phaser.Easing.Linear.None).to({ x: xpos + 2 }, 20, Phaser.Easing.Linear.None).to({ x: xpos }, 20, Phaser.Easing.Linear.None).start()
      else
        # simulate button press animation to indicate selection
        IconGroup = @holdicons[levelNumber - 1]
        tween = @game.add.tween(IconGroup.scale).to({
          x: 0.9
          y: 0.9
        }, 100, Phaser.Easing.Linear.None).to({
          x: 1.0
          y: 1.0
        }, 100, Phaser.Easing.Linear.None).start()
        # it"s a little tricky to pass selected levelNumber to callback function, but this works:
        console.dir tween
        tween.onComplete.add (->
          @onLevelSelected sprite.health
          return
        ), this
      return
    animateLevelIcons: ->
      # slide all icons into screen
      i = 0
      while i < @holdicons.length
        # get variables
        IconGroup = @holdicons[i]
        IconGroup.y = IconGroup.y + 600
        y = IconGroup.y
        # tween animation
        @game.add.tween(IconGroup).to { y: y - 600 }, 500, Phaser.Easing.Back.Out, true, i * 40
        i++
      return
    onLevelSelected: (levelNumber) ->
      # pass levelNumber variable to "Game" state
      @game.level.number = levelNumber
      @state.start "play"
      return
    end: ->
      game.state.start "menu"