# state_boss_one_idle.gd

extends State

class_name BossOneIdleState

var direction = RandomNumberGenerator.new()
 
func _ready():
	persistent_state.detection.connect("body_entered", self, "detected")
	persistent_state.animation_player.play("idle")
	persistent_state.player_detected = false
	persistent_state.hitstun = false
	
	# clears attacks:
	for i in persistent_state.attackArray.size() / 2:
		yield(get_tree().create_timer(1.6), "timeout")
		persistent_state.attackArray[0].queue_free()
		persistent_state.attackArray[1].queue_free()
		persistent_state.attackArray.remove(0)
		persistent_state.attackArray.remove(0)

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

