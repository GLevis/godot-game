# state_boss_one_idle.gd

extends State

class_name BossOneIdleState

var direction = RandomNumberGenerator.new()
 
func _ready():
	persistent_state.detection.connect("body_entered", self, "detected")
	persistent_state.animation_player.play("idle")
	persistent_state.player_detected = false
	persistent_state.hitstun = false

func detected(_param):
	for body in persistent_state.detection.get_overlapping_bodies():
			if body.name == "Player":
				persistent_state.target = body
				persistent_state.player_detected = true
				change_state.call_func("attack")


func change_direction():
	pass


func _physics_process(_delta):
	moveHandler()


func moveHandler():
	pass

