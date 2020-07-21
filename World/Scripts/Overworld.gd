extends Node2D


func _ready():
	var cam = get_node("Player").get_node("Camera2D")
	cam.limit_left = 0
	cam.limit_top = 0
	cam.limit_bottom = 600
	cam.limit_right = 700

