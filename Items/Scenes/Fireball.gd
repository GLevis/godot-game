extends RigidBody2D

class_name Fireball

var projectile_speed = 200

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	$Despawn.connect("timeout", self, "despawn")


func despawn():
	queue_free()


func _process(_delta):
	pass


func _on_Fireball_body_shape_entered(body_id, body, body_shape, local_shape):
	print(body.name)
	if body.name != "TileMap" && body.name != "Player":
		body.hp -= 10
	queue_free()
