extends RigidBody2D

signal object_selected(position: Vector2, mass: float, locked: bool);
signal charge_amount(current: float, total: float, utilization: float);

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

var charge: float = initial_charge;

var utilization = passive_util;

func _init():
	pass

func _process(delta):
	

	var mouse_position = line.get_local_mouse_position();
	
	line.points[0] = linestart.global_position;

	
	striker.position = global_position;
	striker.target_position = striker.get_local_mouse_position();
	striker.add_exception(self)
	
	
	if forcable: 
		if castresult.mass >= 500:
			line.default_color = Color("#FF9100", 0.25);
		else:
			line.default_color = Color("#006FFF", 0.25);
	else:
		line.default_color = Color(1,1,1, 0.25);

		
	if castresult != null:
		line.points[1] = castresult.global_position;
		object_selected.emit(castresult.global_position, castresult.mass, castresult.freeze);

	else:
		line.points[1] = line.get_local_mouse_position();
		
	if charge > 0:
		charge -= delta*utilization;
		charge_amount.emit(charge, initial_charge, utilization)


	
	

func _physics_process(delta):
	
	#apply_force(physics_force+button_force, Vector2(0,0));
	
	if Input.is_action_just_pressed("RCS Fire"):
		apply_impulse(delta*1000000*global_position.direction_to(get_global_mouse_position()), Vector2(0,0));
		
	
	castresult = striker.get_collider();	
	
	if castresult != null:
		forcable = true;
		var direction: Vector2 = global_position.direction_to(castresult.global_position);
		if Input.is_action_pressed("Pull") and charge > 0:
				apply_force(direction*strength*10000*delta);
				castresult.apply_force(-direction*strength*delta*10000);
				utilization = passive_util + gun_util;
		else:
			utilization = passive_util;
			
			
		if Input.is_action_just_pressed("Eject") and charge > 0:
			apply_impulse(-direction*10000)
			castresult.apply_impulse(delta*shoot*direction*10000)
		
	else:
		forcable = false;

func _input(event):
	pass
