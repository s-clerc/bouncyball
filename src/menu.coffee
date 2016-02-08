"use strict"
define ["Phaser"], (Phaser) -> 
  exports = {}
  exports.MenuState = class MenuState extends Phaser.State
    create: ->
      # Name of the @game
      nameLabel = @game.add.text(@game.world.centerX, 80, "Name",
        font: "50px Arial"
        fill: "#ffffff")
      nameLabel.anchor.setTo 0.5, 0.5
      # How to start the @game
      startLabel = @game.add.text(@game.world.centerX, @game.world.height - 80, "press the up arrow key to start",
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
      @game.state.start "play"
      return
  return exports

