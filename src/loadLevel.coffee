define ["Phaser", "Foe", "coin"], (Phaser, Foe, Coin) ->
  "use strict"
  exports = {}
  exports.load = (game) ->
    map = game.add.tilemap "map"
    map.addTilesetImage "tileset"
    layer = map.createLayer "layer"
    layer.resizeWorld()
    map.setCollisionBetween 1, 2
    game.physics.p2.convertTilemap map, layer
    game.map = map
    game.layer = layer
    makeFoes game, game.map, game.layer
    makeObjects game, game.map, game.layer
  makeFoes = (game, map, layer) ->
    group = game.add.group()
    map.createFromTiles 3, null, "foe", layer, group
    for child in group.children
      x = child.x 
      y = child.y
      w = child.width
      h = child.height
      new Foe(game, x+5, y+5)
      child.pendingDestroy = on
      map.removeTileWorldXY x, y, w, h, layer
  #loops through objects layer
  makeObjects = (game, map, layer) ->
    objects = map.objects.objects
    for object in objects
      type = object.type
      if type == "text"
        makeText game, object, map, layer
      else if type == "coin"
        makeCoin game, object, map, layer
      else
        console.warn "Undefined object type: " + type
  makeText = (game, object) ->
    console.log object.properties.en
    game.add.text object.x, object.y, object.properties.en,
        font: "30px Arial"
        fill: "#ffffff"
  makeCoin = (game, object) ->
    new Coin(game, object.x, object.y)
  exports