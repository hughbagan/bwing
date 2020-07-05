class_name Player extends KinematicBody2D


var BulletScene := preload("res://src/PlayerBullet.tscn")
onready var GameWorldNode := find_parent("GameWorld")
var move_speed := 300

var x := 0.0 # in radians
var radius := Vector2(100.0, 100.0)
var anchor = null # Vector2
# What the fuck is this?
var red_default_pos := Vector2(self.get_position().x, self.get_position().y)
var blue_default_pos := Vector2(self.get_position().x, self.get_position().y)

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
		
		var mouse = get_global_mouse_position()
		var m_centered = mouse.x - Globals.WIDTH/2
		m_centered = clamp(m_centered, -Globals.WIDTH/2, Globals.WIDTH/2)
		x += m_centered * (PI/Globals.WIDTH)
		print(mouse, "\t\t", m_centered, "\t\t", x, "\t\t", Vector2(cos(x), sin(x)))
		
		var red_pos = Vector2(red_default_pos.x - (cos(x) * radius.x), red_default_pos.y - (sin(x) * radius.y))
		$Red.set_position(red_pos)
		var blue_pos = Vector2(blue_default_pos.x + (cos(x) * radius.x), blue_default_pos.y + (sin(x) * radius.y))
		$Blue.set_position(blue_pos)
		#$Red.set_position(Vector2(m_centered, $Red.get_position().y))
		
		
		#var default_pos := get_position() -  # in radians
		
		# The anchor is set; move Red and Blue around the anchor w/ the mouse
		#var anchor_diff = get_global_mouse_position() - anchor
		#print(min(abs(anchor_diff.x), abs(anchor_diff.y)))
		
		#var dist_anchor_to_diff = sqrt(pow(anchor_diff.x, 2.0) + pow(anchor_diff.y, 2.0))
		#print(dist_anchor_to_mouse)
		
		#var a_y = sin(PI/4) * r # assuming we have equilateral triangles...
		#var a_x = cos(PI/4) * r
		#print(Vector2(a_x, a_y))
		
		#$Red.set_position(Vector2(min(-r, -16.0), 0))
		#$Blue.set_position(Vector2(max(r, 16.0), 0))
	
	
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
