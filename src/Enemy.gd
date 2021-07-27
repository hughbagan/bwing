class_name Enemy extends KinematicBody2D

var hp := 5


func _physics_process(delta):
	move_and_collide(Globals.scroll_vec * Globals.SCROLLSPEED * delta)


func take_damage(damage_taken:int) -> void:
	hp -= damage_taken
	if hp <= 0:
		self.queue_free()
