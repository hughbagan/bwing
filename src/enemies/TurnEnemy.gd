class_name TurnEnemy extends Enemy
# Travels to the other side of the window, then turns sharply and goes back.

var speed :float = 300.0
var turn_point :Vector2
var destination :Vector2
var target :Vector2
var reached_turn := false


#func _ready():
#	pass


func _physics_process(delta):
	# Go to the specified point
	var diff := self.target - self.position
	if abs(diff.x) < 1 and abs(diff.y) < 1:
		if not self.reached_turn:
			self.target = self.destination
			self.reached_turn = true
			return
		else:
			self.queue_free() # Reached the destination
	var dir := diff.normalized()
#	var move_x := move_toward(position.x, target.x, dir.x*speed*delta)
#	var move_y := move_toward(position.y, target.y, dir.y*speed*delta)
#	var move_amount := Vector2(move_x, move_y)
#	print(position, dir)
	move_and_collide(dir*speed*delta) # or move_and_slide(move_amount / delta)


#func move_toward(orig:float, target:float, amount:float) -> float:
#	# Returns a coordinate either x or y
#	print(amount)
#	var result:float
#	if abs(orig - target) <= amount:
#		# We're nearly right on top of the target
#		result = target
#	elif orig < target:
#		result = min(orig + amount, target)
#	elif orig > target:
#		result = max(orig - amount, target)
#	return result


func set_path(_turn_point:Vector2, _destination:Vector2) -> void:
	self.turn_point = _turn_point
	self.destination = _destination
	self.target = _turn_point


func generate_path_opposite() -> Array:
	# Generates a path that goes to the opposite side of the window and back.
	var turn_point = Vector2(
		round(rand_range(Globals.WIDTH/2, Globals.WIDTH-96)),
		round(rand_range(Globals.HEIGHT-(Globals.HEIGHT/4), Globals.HEIGHT/2))
	)
	# Then a point to exit at once the turn point is reached
	var destination = Vector2(
		self.position.x, # Leave on the same side of the screen we spawn on
		Globals.HEIGHT+self.position.y
	)
	return [turn_point, destination]
