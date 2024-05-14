extends Node3D

@onready var gee = $".."
@onready var cam_goal = $"../cam_goal"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x = cam_goal.global_position.x
	global_position.z = cam_goal.global_position.z
	#global_position.y = cam_goal.global_position.y
	global_position.y = gee.global_position.y
	look_at(gee.global_position)
