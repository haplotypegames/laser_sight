extends Node2D

signal LASER_HIT

const MAX_LENGTH: float = 800.0 

onready var left = $Left
onready var center = $Center
onready var right = $Right

var line_length: float = 0.0
var line_end_width: Vector2 = Vector2.ZERO

var weapon_end: WeakRef = null setget, get_weapon_end #Position2D
var target_point: Vector2 = Vector2.ZERO

var ray_exclusions = []
var initialized: bool = false
var toggled: bool = false setget , get_toggled

func _ready():
	line_end_width.x = left.get_rect().size.x
	set_physics_process(true)
	print(line_end_width)

func _physics_process(delta):
	if !initialized:
		return
	else:
		if !toggled:
			return
		else:
			position = Vector2.ZERO
			var wpn_trans: Transform2D = weapon_end.get_ref().get_global_transform()
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(wpn_trans.origin, wpn_trans.origin + wpn_trans.x * MAX_LENGTH, ray_exclusions)
			if result:
				target_point = result.position
				emit_signal("LASER_HIT", result.collider)
			else:
				target_point = wpn_trans.origin + wpn_trans.x * MAX_LENGTH
			update_line(wpn_trans)

func update_line(wpn_trans: Transform2D):
	line_length = (target_point - wpn_trans.origin).length()
	position = Vector2(line_length * 0.5, 0.0)
	center.scale.x = (line_length - 2 * line_end_width.x) #If you use larger textures and need to scale down, you would want to scale down here
	left.position = Vector2(-(line_length * 0.5) + line_end_width.x * 0.5, 0.0)
	right.position = Vector2(line_length * 0.5 - (line_end_width.x * 0.5), 0.0)


func initialize_laser(weapon_end: WeakRef, exclusions: Array = []):
	set_weapon_end(weapon_end)
	if exclusions.size() > 0:
		for i in range(exclusions.size()):
			ray_exclusions.append(exclusions[i])

func set_weapon_end(w: WeakRef):
	weapon_end = w
	initialized = true

func get_weapon_end():
	return weapon_end.get_ref()

func set_toggled(flag: bool):
	toggled = flag
	if toggled:
		visible = true
	else:
		visible = false
	
func get_toggled():
	return toggled

func toggle():
	set_toggled(!toggled)

