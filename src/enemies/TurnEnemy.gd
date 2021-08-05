class_name TurnEnemy extends Enemy
# Travels to the other side of the window, then turns sharply and goes back.

var PathFollowNode :PathFollow2D

var size :Vector2 = Vector2(64, 64)
var speed :float = 300.0

var turn_point :Vector2
var destination :Vector2
var target :Vector2
var reached_turn := false


func _physics_process(delta:float):
	if PathFollowNode.unit_offset >= 0.99:
		var PathNode:Path2D = PathFollowNode.get_parent()
		if PathNode.get_child_count() <= 1: # if this is the last enemy
			PathNode.queue_free() # free the squadron parent node
		else:
			PathFollowNode.queue_free() # just free this node
	PathFollowNode.offset += speed*delta


func generate_path_opposite(start_pos:Vector2) -> Path2D:
	# Generates a path that goes to the opposite side of the window and back.
	# Angle of the path is never reflexive (ie. never go up on the y-axis)
	var new_path := Path2D.new()
	var turn := Vector2(
		round(rand_range(Globals.WIDTH/2.0, Globals.WIDTH-96.0)),
		round(rand_range(max(start_pos.y, Globals.HEIGHT/4.0), Globals.HEIGHT-(Globals.HEIGHT/3.0)))
	)
	# Then a point to exit at once the turn point is reached
	var dest = Vector2(
		start_pos.x, # Leave on the same side of the screen we spawn on
		turn.y + abs(turn.y - start_pos.y) # Leave with symmetry
	)
	new_path.curve.add_point(start_pos) # Recommended to init with origin
	new_path.curve.add_point(turn)
	new_path.curve.add_point(dest)
	print(turn, dest)
	return new_path
