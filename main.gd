extends Node2D

var playable = preload("res://World/Scenes/playable.tscn")

func _ready():
	get_tree().change_scene_to(playable)
	pass

func _process(_delta):
	pass
