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
define ["Phaser", "Foe", "coin", "actor", "player"], (Phaser, Foe, Coin, Actor, Player) ->
  "use strict"
  exports = {}
  exports.load = (game) ->
    # does level exist
    level = "level" + game.level.number
    return no unless game.cache.checkTilemapKey level
    map = game.add.tilemap level
    map.addTilesetImage "tileset"
    layer = map.createLayer "layer"
    layer.resizeWorld()
    map.setCollisionBetween 1, 2
    game.physics.p2.convertTilemap map, layer
    game.map = map
    game.layer = layer
    makeObjects game, game.map, game.layer
    yes
  #loops through objects layer
  makeObjects = (game, map, layer) ->
    objects = map.objects.objects
    for object in objects
      type = object.type
      switch (object.type)
        when "text"
          makeText game, object, map, layer
        when "coin"
          makeCoin game, object, map, layer
        when "endMarker"
          makeEndMarker game, object, map, layer
        when "foe"
          makeFoe game, object, map, layer
        when "spawn"
          game.state.states.play.player = new Player(game, object.x, object.y)
        else
          console.warn "Undefined object type: " + object.type
  makeFoe = (game, object) ->
    x = object.x + 5
    y = object.y + 5
    new Foe(game, x, y)
  makeText = (game, object) ->
    game.add.text object.x, object.y, object.properties[game.lang],
        font: "30px Arial"
        fill: "#ffffff"
  makeCoin = (game, object) ->
    game.level.totalCoins +=1
    new Coin(game, object.x, object.y)
  makeEndMarker = (game, object) ->
    x = object.x + (object.width/2)
    # correct Y; tiled has the Y on the bottom-left
    y = object.y + (object.height/2)
    rect = game.make.bitmapData object.width, object.height
    rect.ctx.fillRect 0, 0, object.width, object.length
    marker = new Actor(game, x, y, rect)
    marker.body.data.gravityScale = 0
    marker.body.static = yes
    marker.tileType = "end"
    #animate
    yt = object.y
    xt = object.x
    ye = object.y + object.height
    animates = game.add.group()
    game.add.sprite xt, yt, "green", 0, animates

  exports