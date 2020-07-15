extends TileMap

var hidden_tiles = []
var shown_tiles = []

var current_pos = Vector2()
var player_pos = Vector2()

var tilemap

func _ready():
	tilemap = get_tree().get_root().get_node("TileMap")
	yield(get_tree(), "idle_frame")
	current_pos = Vector2(tilemap.player.position.x / 32, tilemap.player.position.y  / 32)
	player_pos = current_pos
	set_cellv(current_pos, 1)
	for x in range(0, tilemap.map_w):
		for y in range(0, tilemap.map_h):
			if tilemap.get_cellv(Vector2(x,y)) == tilemap.Tiles.FLOOR:
				hidden_tiles.append(Vector2(x,y))

func _process(_delta):
	position = tilemap.player.position - Vector2(210, 120)
	player_pos = Vector2(tilemap.player.position.x / 32, tilemap.player.position.y / 32)
	if player_pos != current_pos:
		set_cellv(current_pos, 1)
		set_cellv(player_pos, 0)
		current_pos = player_pos
	for cell in hidden_tiles:
		if cell.distance_to(player_pos) <= 4:
			set_cellv(cell, 1)
			hidden_tiles.erase(cell)
			shown_tiles.append(cell)
