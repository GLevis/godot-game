# state.gd

extends Node2D

class_name MeleeEnemyState

var change_state
var animated_sprite
var persistent_state
var velocity

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	persistent_state.move_and_slide(persistent_state.dir * persistent_state.speed)


func setup(change_state, animated_sprite, persistent_state):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.persistent_state = persistent_state


func moveHandler():
	pass
