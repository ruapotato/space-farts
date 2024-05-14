extends Node2D
@onready var gassbar = $GassProgressBar
@onready var bean_counter = $bean_counter
@onready var height = $height
@onready var speed = $speed
var gee
var max_height = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	gee = get_gee()


func get_gee():
	var root_i_hope = get_parent()
	while root_i_hope.name != "world":
		root_i_hope = root_i_hope.get_parent()
	return(root_i_hope.find_child("Gee"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bean_counter.text != str(gee.beans_found):
		bean_counter.text = str(gee.beans_found)
	
	if gassbar.value != gee.gass:
		gassbar.value = gee.gass
	
	if max_height < gee.global_position.y:
		max_height = gee.global_position.y
		height.text = "Max height: " + str(int(gee.global_position.y))
	speed.text = "MPH " + str(int(gee.linear_velocity.length() * 2.23693629))
