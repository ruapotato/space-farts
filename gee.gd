extends RigidBody3D
@onready var crap = preload("res://crap.tscn")
@onready var fart_sound = $fart_sound
@onready var crap_hole = $crap_hole
var jump_power = 200
var walk_power = 1200
var fart_power = 40
var mouse_move = [0,0]
var max_rot = PI/2.8
var crap_every = .05
var crap_timer = crap_every
var gass = 100
var gass_use_rate = 5
var beans_found = 0
var rot_speed = 4
var rot_point = PI/4.5
# Called when the n0ode enters the scene tree for the first time.
func _ready():
	fart_sound.play()
	#fart_sound.stream_paused = true
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_move = [event.relative.x, event.relative.y]
	
	if event.is_action_pressed("fart"):
		fart_sound.pitch_scale = randf_range(.8,1.2)
		#if not fart_sound.playing:
		#	fart_sound.stream_paused = false



func _physics_process(delta):
	process_rot(delta)
	#var rot_delta_speed = ((linear_velocity * Vector3(1,0,1)).length() * rot_speed)
	#var rot_delta_speed = rot_speed
	#rot_delta_speed = clampf(rot_delta_speed, 0.0, 1) * delta
	#rotation.y = lerp_angle(rotation.y, atan2(-linear_velocity.x,-linear_velocity.z), rot_delta_speed)
	#angular_velocity = Vector3(0,0,0)
	#rotation.slerp()
	if crap_timer < 0:
		bend_over(delta)
		crap_timer = crap_every
	if Input.is_action_pressed("fart") and gass > 0:
		gass -= delta * gass_use_rate
		crap_timer -= delta
		apply_impulse(global_transform.basis.y * fart_power)
	if mouse_move != [0,0]:
		rotate_object_local(Vector3(1,0,0), mouse_move[1] * .5 * delta)
		rotate_object_local(Vector3(0,0,1), mouse_move[0] * -.5 * delta)
		if rotation.x > max_rot:
			rotation.x = max_rot
		elif rotation.x < -max_rot:
			rotation.x = -max_rot
		if rotation.z > max_rot:
			rotation.z = max_rot
		elif rotation.z < -max_rot:
			rotation.z = -max_rot
		#print(mouse_move)
		mouse_move = [0,0]
		#rotation.y = 0


func process_rot(delta):
	#print(rotation)
	#print(rot_point)
	if rotation.z > rot_point:
		print(rotation.z - rot_point)
		rotate_y(delta * (rotation.z - rot_point) * rot_speed)
	elif rotation.z < -rot_point:
		rotate_y(-delta * (-rot_point - rotation.z)* rot_speed)
		print(-rot_point - rotation.z)
		#rotation.x = max_rot
	#elif rotation.x < -rot_point:
	#	rotation.x = -max_rot
	#if rotation.z > rot_point:
	#	rotation.z = max_rot
	#elif rotation.z < -rot_point:
	#	rotation.z = -max_rot

func _process(delta):
	
	#rotation.y = atan2(linear_velocity.x,linear_velocity.z)
	#gass = 100
	#print(Engine.get_frames_per_second())
	if not Input.is_action_pressed("fart") or gass < 0:
		fart_sound.volume_db = lerp(fart_sound.volume_db, -200.0,delta * 5)
		#if not fart_sound.stream_paused:
		#	fart_sound.stream_paused = true
	if Input.is_action_pressed("fart"):
		fart_sound.volume_db = lerp(fart_sound.volume_db, 0.0, delta * 20)

func bend_over(delta):
	#print("lol")
	var big_fart = false
	#Stop falling
	if linear_velocity.y < 0:
		linear_velocity.y = 0
		big_fart = true
	
	#stop swinging right
	if global_transform.basis.y.x < 0:
		if linear_velocity.x > 0:
			linear_velocity.x = 0
			big_fart = true
	
	#stop swinging left
	if global_transform.basis.y.x > 0:
		if linear_velocity.x < 0:
			print("left")
			linear_velocity.x = 0
			big_fart = true
	
	#stop swinging back?
	if global_transform.basis.y.z < 0:
		if linear_velocity.z > 0:
			linear_velocity.z = 0
			big_fart = true
			
	if global_transform.basis.y.z > 0:
		if linear_velocity.z < 0:
			linear_velocity.z = 0
			big_fart = true
	
	var shit = crap.instantiate()
	shit.add_collision_exception_with(self)
	get_parent().add_child(shit)
	if big_fart:
		shit.scale = 3.0 * Vector3(1,1,1)
	#shit.linear_velocity = linear_velocity
	shit.apply_impulse(linear_velocity - global_transform.basis.y)
	shit.global_position = crap_hole.global_position



func _on_fart_sound_finished():
	#fart_sound.seek(0.0)
	fart_sound.play()
