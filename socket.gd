class_name StationSocket
extends Area2D

@onready var block: Sprite2D = get_node("ConnectionArea") as Sprite2D;
@onready var blockmaterial: ShaderMaterial = block.material as ShaderMaterial;

@export var target: StationPart;
@export var detecting: bool = false;

signal part_in_range;
signal part_out_of_range;


	
func _process(delta):
	
	if detecting:
		blockmaterial.set_shader_parameter("alpha", 0.1);
	else:
		blockmaterial.set_shader_parameter("alpha", 0.0);
	
	if detecting and target in get_overlapping_bodies():
		blockmaterial.set_shader_parameter("tint_color", Vector3(0.0,1.0,0.0))
		part_in_range.emit();
	else:
		blockmaterial.set_shader_parameter("tint_color", Vector3(1.0,0.0,0.0))
		part_out_of_range.emit();
		
		
		
