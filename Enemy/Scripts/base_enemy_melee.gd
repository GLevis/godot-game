# state.gd

extends Node2D

class_name MeleeEnemyState

var change_state
var animation_player
var persistent_state
var velocity

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	persistent_state.move_and_slide(persistent_state.dir * persistent_state.speed)


func setup(change_state, animation_player, persistent_state):
	self.change_state = change_state
	self.animation_player = animation_player
	self.persistent_state = persistent_state


func moveHandler():
	pass
