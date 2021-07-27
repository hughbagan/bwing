extends Node

onready var WIDTH := get_viewport().size.x
onready var HEIGHT := get_viewport().size.y
var SCROLLSPEED := 50
var scroll_vec := Vector2(0, 1)
