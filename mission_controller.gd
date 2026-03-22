class_name MissionController
extends Node

@onready var mission: Array = (get_children());
@export var player: Player
@export var indicator: Control;
@export var mission_select: int;


func _ready():
	print(mission)
	mission[mission_select].activate()
	
	
	mission[mission_select].socket.part_in_range.connect(player._on_socket_area_part_in_range)
	mission[mission_select].socket.part_in_range.connect(_on_in_range);
	
	for i in range(mission.size()):
		
		if i < mission_select:
			(mission[i] as Mission).object.freeze = true;
			(mission[i] as Mission).object.transform = (mission[i] as Mission).fixed.transform;
			(mission[i] as Mission).object.collision_layer = 2
	pass

func _process(delta):
	pass;

func _on_in_range():
	indicator.visible = true;
	
