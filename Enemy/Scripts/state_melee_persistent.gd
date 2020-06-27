# persistent_state.gd

extends KinematicBody2D

class_name MeleePersistentState

var state
var state_factory
var player_detected
var target

var dir = Vector2.ZERO
var speed = Vector2(175, 175)

var velocity = Vector2()

var hp
var atk = 1

onready var detection = get_node("Detection")
onready var inrange = get_node("InRange")
onready var animation_player = get_node("AnimationPlayer")
onready var hitbox = get_node("Hitbox")

func _initialization():
	player_detected = false


func _ready():
	state_factory = MeleeStateFactory.new()
	change_state("idle")


func _process(_delta):
	pass


func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $AnimationPlayer, self)
	state.name = "current_state"
	add_child(state)
