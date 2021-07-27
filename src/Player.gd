class_name Player extends KinematicBody2D

var BulletScene := preload("res://src/PlayerBullet.tscn")
onready var GameWorldNode := find_parent("GameWorld")
var move_speed := 300
var damage := 2

func _physics_process(delta):
	# Keyboard controls
	var move_vec := Vector2()
	if Input.is_action_pressed("move_down") and self.global_position.y < Globals.HEIGHT:
		move_vec.y += 1
	if Input.is_action_pressed("move_up") and self.global_position.y > 0:
		move_vec.y -= 1
	if Input.is_action_pressed("move_left") and self.global_position.x > 0:
		move_vec.x -= 1
	if Input.is_action_pressed("move_right") and self.global_position.x < Globals.WIDTH:
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_slide(move_vec * move_speed)
	# Mouse controls
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var mouse = get_global_mouse_position()
		if mouse.y < Globals.HEIGHT and mouse.y > 0 \
		and mouse.x < Globals.WIDTH and mouse.x > 0:
			self.set_position(mouse)
	# Shooting
	if Input.is_action_pressed("shoot"):
		if $ShootTimer.is_stopped():
			instance_bullet()
			$ShootTimer.start()
			$AnimatedSprite.play()
	else:
		$ShootTimer.stop()
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0


func instance_bullet():
	var new_bullet = BulletScene.instance()
	new_bullet.set_position(Vector2(get_global_position().x, get_global_position().y-32))
	new_bullet.damage = self.damage
	GameWorldNode.add_child(new_bullet)


func _on_ShootTimer_timeout():
	instance_bullet()
