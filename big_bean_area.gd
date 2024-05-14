extends Area3D

@onready var gee = $"../../Gee"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gee in get_overlapping_bodies():
		gee.gass = 100
