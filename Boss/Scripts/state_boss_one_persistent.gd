# persistent_state.gd

extends KinematicBody2D

class_name BossOnePersistentState

var state
var state_factory
var player_detected
var target

var dir = Vector2.ZERO
var knockdir = Vector2.ZERO
var idle_speed = Vector2(30, 30)
var speed = Vector2(40, 40)

var velocity = Vector2()

var hp = 50
var atk = 2
var prevHp = hp
var hitstun = false

onready var detection = get_node("Detection")
onready var animation_player = get_node("AnimationPlayer")
onready var hitbox = get_node("Hitbox")
onready var direction_timer = get_node("DirectionTimer")

func _initialization():
	player_detected = false


func _ready():
	state_factory = BossOneStateFactory.new()
	change_state("idle")


func _process(_delta):
	if prevHp > hp:
		print(hp)
		prevHp = hp
	if hp <= 0:
		die()


func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $AnimationPlayer, self)
	state.name = "current_state"
	call_deferred("add_child", state)


func die():
	queue_free()


func receiveKnockback(from):
	knockdir = -(from.get_parent().position - self.position) * Vector2(35,35)
	var timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(false)
	timer.set_wait_time(.5)
	timer.connect("timeout", self, "remove_knockback")
	timer.start()
	change_state("hitstun")
	print(knockdir)


func remove_knockback():
	knockdir = Vector2.ZERO
