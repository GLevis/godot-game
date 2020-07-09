# state_melee.gd

extends State

class_name MeleeState

func _ready():
	change_state.call_func("run")

func _process(_delta):
	pass
