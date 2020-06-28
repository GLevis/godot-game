extends TileMap

class_name Playable

var player_instance = preload("res://Player/Scenes/player.tscn")
var treasure_instance = preload("res://Items/Treasure.tscn")
var enemy_instance = preload("res://Enemy/Scenes/melee_enemy.tscn")

var map_w = 80
var map_h = 50
var min_room_size = 8
var min_room_factor = .4

enum Tiles { GROUND, BG, DOOR }

var tree = {}
var leaves = []
var leaf_id = 0
var rooms = []

var start_room = null
var end_room = null

var player
var enemy1
var enemy2

func _ready():
	generate()
	player = player_instance.instance()
	player.position.x = start_room.center.x * 32
	player.position.y = start_room.center.y	* 32
	add_child(player)
	enemy1 = enemy_instance.instance()
	enemy1.position.x = end_room.center.x * 32
	enemy1.position.y = end_room.center.y * 32
	add_child(enemy1)
	enemy2 = enemy_instance.instance()
	enemy2.position.x = start_room.center.x * 32
	enemy2.position.y = start_room.center.y * 32
	add_child(enemy2)

func _process(_delta):
	pass


func generate():
	clear()
	fill_bg()
	start_tree()
	create_leaf(0)
	create_rooms()
	join_rooms()
	clear_deadends()
	find_start_room()
	find_end_room()
	place_treasure()
	place_doors()
	purge_doors()

func fill_bg():
	for x in range(0, map_w):
		for y in range(0, map_h):
			set_cell(x, y, Tiles.BG)


func start_tree():
	rooms = []
	tree = {}
	leaves = []
	leaf_id = 0
	
	tree[leaf_id] = { "x": 1, "y": 1, "w": map_w - 2, "h": map_h - 2}
	leaf_id += 1


func create_leaf(parent_id):
	var x = tree[parent_id].x
	var y = tree[parent_id].y
	var w = tree[parent_id].w
	var h = tree[parent_id].h
	
	tree[parent_id].center = { x = floor(x + w / 2), y = floor(y + h / 2) }
	
	var can_split = false
	
	var split_type = choose(["h", "v"])
	
	if min_room_factor * w < min_room_size:
		split_type = "h"
	elif min_room_factor * h < min_room_size:
		split_type = "v"
	
	var leaf1 = {}
	var leaf2 = {}
	
	if split_type == "v":
		var room_size = min_room_factor * w
		if room_size >= min_room_size:
			var w1 = randi_range(room_size, (w - room_size))
			var w2 = w - w1
			leaf1 = { x = x, y = y, w = w1, h = h, split = 'v'}
			leaf2 = { x = x + w1, y = y, w = w2, h = h, split = 'v'}
			can_split = true
	else:
		var room_size = min_room_factor * h
		if room_size >= min_room_size:
			var h1 = randi_range(room_size, (h - room_size))
			var h2 = h - h1
			leaf1 = { x = x, y = y, w = w, h = h1, split = 'h'}
			leaf2 = { x = x, y = y + h1, w = w, h = h2, split = 'h'}
			can_split = true
	
	if can_split:
		leaf1.parent_id = parent_id
		tree[leaf_id] = leaf1
		tree[parent_id].l = leaf_id
		leaf_id += 1
		
		leaf2.parent_id = parent_id
		tree[leaf_id] = leaf2
		tree[parent_id].r = leaf_id
		leaf_id += 1
		
		leaves.append([tree[parent_id].l, tree[parent_id].r])
		
		create_leaf(tree[parent_id].l)
		create_leaf(tree[parent_id].r)


func create_rooms():
	for leaf_id in tree:
		var leaf = tree[leaf_id]
		if leaf.has("l"): continue
		
		if chance(75):
			var room = {}
			room.id = leaf_id
			room.w = randi_range(min_room_size, leaf.w) - 1
			room.h = randi_range(min_room_size, leaf.h) - 1
			room.x = leaf.x + floor((leaf.w - room.w) / 2) + 1
			room.y = leaf.y + floor((leaf.h - room.h) / 2) + 1
			room.split = leaf.split
			
			room.center = Vector2()
			room.center.x = floor(room.x + room.w / 2)
			room.center.y = floor(room.y + room.h / 2)
			rooms.append(room)
	
	for i in range(rooms.size()):
		var r = rooms[i]
		for x in range(r.x, r.x + r.w):
			for y in range(r.y, r.y + r.h):
				set_cell(x, y, Tiles.GROUND)


func join_rooms():
	for sister in leaves:
		var a = sister[0]
		var b = sister[1]
		connect_leaves(tree[a], tree[b])


func connect_leaves(leaf1, leaf2):
	var x = min(leaf1.center.x, leaf2.center.x)
	var y = min(leaf1.center.y, leaf2.center.y)
	var w = 1
	var h = 1
	
	if leaf1.split == 'h':
		x -= floor(w / 2) + 1
		h = abs(leaf1.center.y - leaf2.center.y)
	else:
		y -= floor(h / 2) + 1
		w = abs(leaf1.center.x - leaf2.center.x)
		
	x = 0 if x < 0 else x
	y = 0 if y < 0 else y
	
	for i in range(x, x + w):
		for j in range(y, y + h):
			if get_cell(i, j) == Tiles.BG:
				set_cell(i, j, Tiles.GROUND)


func clear_deadends():
	var done = false
	
	while !done:
		done = true
		
		for cell in get_used_cells():
			if get_cellv(cell) != Tiles.GROUND: continue
			
			var bg_count = check_nearby(cell.x, cell.y)
			if bg_count == 3:
				set_cellv(cell, Tiles.BG)
				done = false


func find_start_room():
	var min_x = INF
	for room in rooms:
		if room.center.x < min_x:
			start_room = room
			min_x = room.center.x


func find_end_room():
	var max_x = -INF
	for room in rooms:
		if room.center.x > max_x:
			end_room = room
			max_x = room.center.x


func check_nearby(x, y):
	var count = 0
	if get_cell(x, y - 1) == Tiles.BG: count += 1
	if get_cell(x, y + 1) == Tiles.BG: count += 1
	if get_cell(x - 1, y) == Tiles.BG: count += 1
	if get_cell(x + 1, y) == Tiles.BG: count += 1
	return count


func choose(choices):
	randomize()
	
	var rand_index = randi() % choices.size()
	return choices[rand_index]


func randi_range(low, high):
	return floor(rand_range(low, high))


func chance(num):
	randomize()
	
	if randi() % 100 <= num:
		return true
	else:
		return false


func place_treasure():
	for room in rooms:
		if room != start_room && room != end_room:
			var door_amt = check_perimeter(room.x, room.y, room.w, room.h)
			if door_amt > 1:
				continue
				
			else:
				if chance(33):
					var treasure  = treasure_instance.instance()
					treasure.position.x = room.center.x * 32
					treasure.position.y = room.center.y * 32
					add_child(treasure)


func check_perimeter(room_x, room_y, width, height):
	var room_check_complete = false
	var counter = 0
	var tileOn = Vector2.ZERO
	var cell
	for i in get_used_cells():
		if i.x == room_x - 1 && i.y == room_y - 1:
			cell = i
	
	# checks top of perimeter
	for i in range(cell.x, cell.x + (width + 1)):
		if get_cell(i, cell.y) == Tiles.GROUND: 
			counter += 1
			
			
	# checks left side of perimeter
	for i in range(cell.y, cell.y + (height + 1)):
		if get_cell(cell.x, i) == Tiles.GROUND: 
			counter += 1
			
	
	# checks bottom side of perimeter
	for i in range(cell.x, cell.x + (width + 1)):
		if get_cell(i, cell.y + (height + 1)) == Tiles.GROUND: 
			counter += 1
			
			
	# checks right side of perimeter
	for i in range(cell.y, cell.y + (height + 1)):
		if get_cell(cell.x + (width + 1), i) == Tiles.GROUND: 
			counter += 1
		
			
	return counter


func place_doors():
	var cell
	var potential_doors = []
	for room in rooms:
		for i in get_used_cells():
			if i.x == room.x - 1 && i.y == room.y - 1:
				cell = i
		
		# checks top of perimeter
		for i in range(cell.x, cell.x + (room.w + 1)):
			if get_cell(i, cell.y) == Tiles.GROUND: 
				set_cell(i, cell.y, Tiles.DOOR)
				
		# checks left side of perimeter
		for i in range(cell.y, cell.y + (room.h + 1)):
			if get_cell(cell.x, i) == Tiles.GROUND: 
				set_cell(cell.x, i, Tiles.DOOR)
				
		
		# checks bottom side of perimeter
		for i in range(cell.x, cell.x + (room.w + 1)):
			if get_cell(i, cell.y + (room.h + 1)) == Tiles.GROUND: 
				set_cell(i, cell.y + (room.h + 1), Tiles.DOOR)
				
				
		# checks right side of perimeter
		for i in range(cell.y, cell.y + (room.h + 1)):
			if get_cell(cell.x + (room.w + 1), i) == Tiles.GROUND: 
				set_cell(cell.x + (room.w + 1), i, Tiles.DOOR)


func purge_doors():
	for cell in get_used_cells():
		var bg_count = 0
		if get_cellv(cell) == Tiles.DOOR:
			if get_cellv(Vector2(cell.x, cell.y + 1)) == Tiles.BG && get_cellv(Vector2(cell.x, cell.y - 1)) == Tiles.BG:
				bg_count += 2
			if get_cellv(Vector2(cell.x - 1, cell.y)) == Tiles.BG && get_cellv(Vector2(cell.x + 1, cell.y)) == Tiles.BG:
				bg_count += 2
			if bg_count != 2:
				set_cell(cell.x, cell.y, Tiles.GROUND)
