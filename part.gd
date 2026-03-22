class_name StationPart
extends RigidBody2D

@onready var sprite = get_node("sprite") as Sprite2D;

@export var active = false;

func _process(delta) -> void:
	
	if active:
		(sprite.material as ShaderMaterial).set_shader_parameter("width", 2);
	
	else:
		(sprite.material as ShaderMaterial).set_shader_parameter("width", 0);

	
