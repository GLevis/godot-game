# state_melee.gd

extends State

class_name MeleeState

func _ready():
	#persistent_state.weapon.attack1()
	change_state.call_func("run")

func _process(_delta):
	pass
