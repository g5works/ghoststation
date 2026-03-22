class_name Player
extends RigidBody2D

signal object_selected(position: Vector2, mass: float, locked: bool);
signal charge_amount(current: float, total: float, utilization: float);
signal power_scale(pscale: float);
signal mission_end();
signal power_out();

@onready var line := get_parent().get_node("indicator") as Line2D
@onready var striker := get_parent().get_node("striker") as RayCast2D;
@onready var sprite := get_node("PlayerSprite") as Sprite2D;
@onready var linestart := sprite.get_node("Grab Point") as Node2D;

@export var initial_charge: float = 100.0;
@export var strength: float = 0;
@export var shoot: float = 0;

@export var passive_util: float = 0.01;
@export var gun_util: float = 0.1;
@export var impulse_drain: float = 2;

var button_force: Vector2 = Vector2(0,0);
var physics_force: Vector2 = Vector2(0,0);
var forcable: bool = false
var castresult: RigidBody2D = null;

var mission_complete: bool = false;

var powerscale: float = 1.0

@onready var charge: float = initial_charge;
@onready var utilization = passive_util;

func _init():
	pass

func _process(delta):
	

	var mouse_position = line.get_local_mouse_position();
	
	line.points[0] = linestart.global_position;

	
	striker.position = global_position;
	striker.target_position = striker.get_local_mouse_position();
	striker.add_exception(self)
	

	if forcable: 
		if powerscale >= 0:
			line.default_color = Color("#006FFF", powerscale);

		else:
			line.default_color = Color("#FF9100", -powerscale);
				
	else:
		line.default_color = Color(1,1,1, 0.25);

		
	if castresult != null:
		line.points[1] = castresult.global_position;
		object_selected.emit(castresult.global_position, castresult.mass, castresult.freeze);

	else:
		line.points[1] = line.get_local_mouse_position();
		
	if charge > 0:	
		charge -= delta*utilization;
	else:
		power_out.emit();
	charge_amount.emit(charge, initial_charge, utilization)


	if powerscale > -1 and Input.is_action_just_pressed("Eject Power Down"): 
		powerscale -= 0.2;
		power_scale.emit(powerscale);
	
	if powerscale < 1 and Input.is_action_just_pressed("Eject Power Up"):
		powerscale += 0.2;
		power_scale.emit(powerscale);
		
	if mission_complete:
		mission_end.emit();
	
func _physics_process(delta):
	
	#apply_force(physics_force+button_force, Vector2(0,0));
	
	if Input.is_action_just_pressed("RCS Fire"):
		apply_impulse(delta*1000000*global_position.direction_to(get_global_mouse_position()), Vector2(0,0));
		
	
	castresult = striker.get_collider();	
	
	if castresult != null:
		forcable = true;
		var direction: Vector2 = global_position.direction_to(castresult.global_position);
		if Input.is_action_pressed("Pull") and charge > 0:
				apply_force(direction*strength*powerscale*10000*delta);
				castresult.apply_force(-direction*strength*powerscale*delta*10000);
				utilization = passive_util + (abs(powerscale)*gun_util);
		else:
			utilization = passive_util;
			
			
		if Input.is_action_just_pressed("Eject") and charge > 0:
			apply_impulse(delta*shoot*powerscale*direction*10000)
			castresult.apply_impulse(-delta*shoot*powerscale*direction*10000)
			charge -= 5
		
	else:
		forcable = false;

func _on_socket_area_area_exited(area: Area2D) -> void:
	pass 


func _on_socket_area_part_in_range() -> void:
	mission_complete = true;


func _on_robot_container_area_player_in_area() -> void:
	if mission_complete:
		charge = initial_charge;
		utilization = 0;
		
		
		
