extends RigidBody2D

func _init():
	pass

func _process(delta):
	apply_force(Vector2(0, 100), Vector2(0,0));
	pass
