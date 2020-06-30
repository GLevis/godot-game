# idle_state.gd

extends MeleeEnemyState

class_name MeleeHitstunState

func _ready():
	change_state.call_func("chase")

func _process(_delta):
	moveHandler()

func moveHandler():
	pass
