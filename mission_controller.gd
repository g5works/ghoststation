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
	pass

func _process(delta):
	pass;

func _on_in_range():
	indicator.visible = true;
	
