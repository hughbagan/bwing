class_name TurnEnemy extends Enemy
# Travels to the other side of the window, then turns sharply and goes back.

var speed :float = 300.0
var turn_point :Vector2
var destination :Vector2
var target :Vector2
var reached_turn := false


func _physics_process(delta):
	# Go to the specified point
	var diff := self.target - self.position
	if abs(diff.x) < 2 and abs(diff.y) < 2:
		if not self.reached_turn:
			self.target = self.destination
			self.reached_turn = true
			return
		else:
			self.queue_free() # Reached the destination
	var dir := diff.normalized()
	move_and_collide(dir*speed*delta) # or move_and_slide(move_amount / delta)


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
	print(turn_point, destination)
	return [turn_point, destination]
