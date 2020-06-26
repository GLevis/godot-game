# persistent_state.gd

extends KinematicBody2D

class_name PersistentState

var state
var state_factory

var velocity = Vector2()

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")


func _process(_delta):
	state.inputHandler()
	

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $AnimatedSprite, self)
	state.name = "current_state"
	add_child(state)
