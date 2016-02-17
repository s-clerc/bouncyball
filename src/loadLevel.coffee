define ["Phaser", "Foe", "coin", "actor"], (Phaser, Foe, Coin, Actor) ->
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
        else
          console.warn "Undefined object type: " + object.type
  makeFoe = (game, object) ->
    x = object.x + 5
    y = object.y + 5
    new Foe(game, x, y)
  makeText = (game, object) ->
    game.add.text object.x, object.y, object.properties.en,
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
    rect.ctx.fillStyle = "#ff0000"
    rect.ctx.fillRect 0, 0, object.width, object.length
    marker = new Actor(game, x, y, rect)
    marker.body.data.gravityScale = 0
    marker.body.static = yes
    marker.tileType = "end"
  exports