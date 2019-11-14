extends KinematicBody2D

onready var arm = $Arm

var laser: Node2D = null
var move_dir: Vector2 = Vector2.ZERO

func _unhandled_input(event):
	if event.is_action_pressed("laser_toggle"):
		laser.toggle()
		get_tree().set_input_as_handled()


func _ready():
	set_process_unhandled_input(true)
	laser = load("res://Laser/Laser.tscn").instance()
	laser.initialize_laser(weakref($Arm/Position2D), [self])
	$Arm/Position2D.add_child(laser)
	laser.connect("LASER_HIT", self, "on_laser_hit")

func _physics_process(delta):
	move_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_dir += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		move_dir += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		move_dir += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_dir += Vector2.RIGHT
	
	move_and_collide(move_dir * 100 * delta)
	arm.look_at(get_global_mouse_position())

func on_laser_hit(collider: Node2D):
	print("Laser hit: ", collider)