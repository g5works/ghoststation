extends RigidBody2D

@onready var line := get_parent().get_node("indicator") as Line2D
@onready var striker := get_parent().get_node("striker") as RayCast2D;
@onready var sprite := get_node("PlayerSprite") as Sprite2D;
@onready var linestart := sprite.get_node("Grab Point") as Node2D;
var button_force = Vector2(0,0);
var physics_force = Vector2(0,0);
var forcable = false
var castresult: Object = null;

func _init():
	pass

func _process(delta):
	

	var mouse_position = line.get_local_mouse_position();
	
	line.points[0] = linestart.global_position;

	
	striker.position = global_position;
	striker.target_position = striker.get_local_mouse_position();
	striker.add_exception(self)
	
	
	if forcable: 
		line.default_color = Color(0, 1, 1, 0.25);
	else:
		line.default_color = Color(1,1,1, 0.25);
	
	if Input.is_action_pressed("RCS Fire Down"):
		button_force.y = 30000;
	elif Input.is_action_pressed("RCS Fire Up"):
		button_force.y = -30000;	
	elif Input.is_action_pressed("RCS Fire Left"):
		button_force.x = -30000;
	elif Input.is_action_pressed("RCS Fire Right"):
		button_force.x = 30000;
	else:
		button_force = Vector2(0,0);
		
	if castresult != null:
		line.points[1] = castresult.global_position;

	else:
		line.points[1] = line.get_local_mouse_position();

	#
	#var dir2mouse: Vector2 = global_position.direction_to(get_local_mouse_position())
	#var perp_dir2mouse: Vector2 = Vector2(-dir2mouse.y, dir2mouse.x);
	#var t: Transform2D = Transform2D();
	#t.y = dir2mouse;
	#t.x = perp_dir2mouse;
	
	

func _physics_process(delta):
	
	apply_force(physics_force+button_force, Vector2(0,0));
	
	castresult = striker.get_collider();	
	
	if castresult != null:
		forcable = true;
		var direction: Vector2 = global_position.direction_to(castresult.global_position);
		if Input.is_action_pressed("Pull"):
			physics_force = direction*10000;
			castresult.apply_force(-direction*10000);
		else: 
			physics_force = Vector2(0,0);
		
	else:
		forcable = false;

func _input(event):
	pass
