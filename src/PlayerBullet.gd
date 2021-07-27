class_name PlayerBullet extends KinematicBody2D


const MOVE_SPEED := 500
var move_vec := Vector2(0, -1)
var damage # initialized when instanced


func _physics_process(delta):
	var collision = move_and_collide(move_vec * MOVE_SPEED * delta)
	if collision:
		if collision.collider.is_in_group("Enemy"):
			collision.collider.take_damage(damage)
			self.queue_free()
	if get_position().y < -64:
		self.queue_free()
