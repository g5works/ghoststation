extends RigidBody2D

@onready var line := get_owner().get_node("indicator") as Line2D
@onready var striker := get_owner().get_node("striker") as RayCast2D;
var button_force = Vector2(0,0);
var physics_force = Vector2(0,0);
var forcable = false

func _init():
	pass

func _process(delta):
		
	var mouse_position = line.get_local_mouse_position();
	
	line.points[0] = global_position;
	line.points[1] = line.get_local_mouse_position();

	
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

func _physics_process(delta):
	
	apply_force(physics_force+button_force, Vector2(0,0));
	
	var result: Object = striker.get_collider();	
	
	if result != null:
		forcable = true;
		var direction: Vector2 = global_position.direction_to(result.global_position);
		if Input.is_action_pressed("Pull"):
			physics_force = direction*10000;
			result.apply_force(-direction*10000);
		else: 
			physics_force = Vector2(0,0);
		
	else:
		forcable = false;
		

		
		
	print(result)
	
	
func _input(event):
	pass
