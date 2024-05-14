extends Node3D
@onready var beans = preload("res://beans.tscn")
@onready var tmp_mesh = $tmp_mesh
var gee
var spawn_range = 250
var spawned = false


func _ready():
	tmp_mesh.hide()
	gee = get_gee()
	
func get_gee():
	var root_i_hope = get_parent()
	#print(root_i_hope.name)
	while root_i_hope.name != "world":
		root_i_hope = root_i_hope.get_parent()
	return(root_i_hope.find_child("Gee"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.distance_to(gee.global_position) < spawn_range:
		if not spawned:
			add_child(beans.instantiate())
			spawned = true
