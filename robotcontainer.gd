extends Area2D

@export var player: RigidBody2D;
signal player_in_area;

func _process(delta) -> void:
	if player in get_overlapping_bodies():
		player_in_area.emit();
