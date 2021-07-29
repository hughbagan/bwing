class_name Enemy extends KinematicBody2D

var hp := 1


func _physics_process(_delta):
	# Overloaded by subclasses
	pass


func take_damage(damage_taken:int) -> void:
	hp -= damage_taken
	if hp <= 0:
		self.queue_free()
