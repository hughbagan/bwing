class_name Player extends KinematicBody2D


var BulletScene := preload("res://src/PlayerBullet.tscn")
onready var GameWorldNode := find_parent("GameWorld")
var move_speed := 300

var radius := Vector2(50.0, 50.0)
var anchor = null # Vector2
var damage := 2


func _physics_process(delta):
#	var move_vec := Vector2()
#	if Input.is_action_pressed("move_down") and self.global_position.y < Globals.HEIGHT:
#		move_vec.y += 1
#	if Input.is_action_pressed("move_up") and self.global_position.y > 0:
#		move_vec.y -= 1
#	if Input.is_action_pressed("move_left") and self.global_position.x > 0:
#		move_vec.x -= 1
#	if Input.is_action_pressed("move_right") and self.global_position.x < Globals.WIDTH:
#		move_vec.x += 1
#	move_vec = move_vec.normalized()
#	move_and_slide(move_vec * move_speed)
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		# Mouse is not pressed
		anchor = null
	elif Input.is_mouse_button_pressed(BUTTON_LEFT) and not anchor:
		# Mouse has been pressed; drop the anchor
		anchor = get_global_mouse_position()
		$Sprite.set_global_position(anchor)
	elif Input.is_mouse_button_pressed(BUTTON_LEFT) and anchor:
		# The anchor is set; move Red and Blue around the anchor w/ the mouse
		
		var mouse = get_global_mouse_position() - anchor
		print(mouse)
		var r = sqrt(pow(mouse.x, 2.0) + pow(mouse.y, 2.0))
		
		var a_y = sin(PI/4) * r # assuming we have equilateral triangles...
		var a_x = cos(PI/4) * r
		print(Vector2(a_x, a_y))
		
		$Red.set_position(Vector2(min(-r, -16.0), 0))
		$Blue.set_position(Vector2(max(r, 16.0), 0))
	
	
	if Input.is_action_pressed("shoot"):
		if $Red/ShootTimer.is_stopped():
			instance_bullet()
			$Red/ShootTimer.start()
			$Red/AnimatedSprite.play()
	else:
		$Red/ShootTimer.stop()
		$Red/AnimatedSprite.stop()
		$Red/AnimatedSprite.frame = 0


func circle_x(x:float) -> float:
	return 1.0
	# return cos()...


func circle_y(x:float) -> float:
	return 1.0
	# return sin()...


func circle_to_pos(x:float, y:float, r:float) -> Vector2:
	var pos_x : float = self.get_position().x + x * r
	var pos_y : float = self.get_position().x + y * r
	return Vector2(pos_x, pos_y)


func instance_bullet():
	var new_bullet = BulletScene.instance()
	new_bullet.set_position(Vector2($Red.get_global_position().x, $Red.get_global_position().y-32))
	new_bullet.damage = self.damage
	GameWorldNode.add_child(new_bullet)


func _on_ShootTimer_timeout():
	instance_bullet()
