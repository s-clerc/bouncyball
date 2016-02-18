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
define ["Phaser" ,"Actor"], (Phaser, Actor) ->
  "use strict"
  exports = {}
  exports = class Foe extends Actor
    speed: 125
    tileType: "foe"
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "foe"
      @body.onBeginContact.add @whenBeginContact
      @body.fixedRotation = yes
      # Negative is towards right
      @speedSet = -200
      @kinematic = yes
      @mass = 99999999999999999999999999999
    whenBeginContact: (a, b, c, d, e) =>
      return unless a
      direction = Math.atan2 a.x-@x, a.y-@y #rad
      if 0.5 < direction < 2.5
        @speedSet = @speed
      else if -0.5 > direction > -2.5
        @speedSet = -@speed
    update: =>
      @body.velocity.x = -@speedSet


  exports
