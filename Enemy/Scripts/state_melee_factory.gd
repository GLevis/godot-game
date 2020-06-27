# state_factory.gd

class_name MeleeStateFactory

var states

func _init():
	states = {
		"idle": MeleeIdleState,
		"chase": MeleeChaseState
}


func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
