class_name Spawner extends Node2D

var TurnEnemyScene = preload("res://src/enemies/TurnEnemy.tscn")
onready var GameWorldNode := find_parent("GameWorld")
var time :float = 0.0
# Spawn points
var spawn_points_top := []
var spawn_points_left := []
var spawn_points_right := []
var step_size :float = 96.0 # size of each spawn point (size of enemies)
# Squadrons
var num_squads_to_spawn := 40
var num_to_spawn := 5
var point :Position2D
var path :Path2D

func _ready():
	randomize()
	# Create the spawn points
	var num_points_x = floor(Globals.WIDTH / step_size)
	for i in range(0, num_points_x):
		var new_point = Position2D.new()
		new_point.set_position(Vector2(i*step_size, -step_size))
		new_point.set_name("spawn"+str(i))
		self.add_child(new_point)
		spawn_points_top.append(new_point)
	# Only do y-axis spawn points for the top half of the screen
	var num_points_y = floor((Globals.HEIGHT/2.0) / step_size)
	for i in range(0, num_points_y):
		var new_left_point = Position2D.new()
		new_left_point.set_position(Vector2(-step_size, i*step_size))
		new_left_point.set_name("spawn"+str(i+num_points_x))
		self.add_child(new_left_point)
		spawn_points_left.append(new_left_point)
		var new_right_point = Position2D.new()
		new_right_point.set_position(Vector2(Globals.WIDTH+step_size, i*step_size))
		new_right_point.set_name("spawn"+str(i+num_points_x+num_points_y))
		self.add_child(new_right_point)
		spawn_points_right.append(new_right_point)
	print(len(spawn_points_top), " top spawns, ", \
		len(spawn_points_left), " left spawns, ", \
		len(spawn_points_right), " right spawns")
	$SpawnTimer.start()


func _process(delta):
	time += delta
	$Label.text = str(time)


func _on_SpawnTimer_timeout():
	if num_squads_to_spawn > 0:
		if num_to_spawn > 0:
			var new_path_follow :PathFollow2D = PathFollow2D.new()
			new_path_follow.loop = false
			new_path_follow.rotate = false
			var new_enemy :TurnEnemy = TurnEnemyScene.instance()
			if num_to_spawn == 5: # The first spawn
				point = spawn_points_left[randi() % len(spawn_points_left)]
				print(point.position)
				path = new_enemy.generate_path_opposite(point.position)
				new_path_follow.position = point.position
				GameWorldNode.add_child(path)
			path.add_child(new_path_follow)
			new_path_follow.add_child(new_enemy)
			new_enemy.PathFollowNode = new_path_follow
			num_to_spawn -= 1
			$SpawnTimer.start()
		else:
			num_squads_to_spawn -= 1
			num_to_spawn = 5
