extends Node

onready var WIDTH := 720.0 #OS.window_size.x #get_viewport().size.x
onready var HEIGHT := 1080.0 #OS.window_size.y #get_viewport().size.y

var SCROLLSPEED := 50
var scroll_vec := Vector2(0, 1)
