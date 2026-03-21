extends TextureRect

var snapped = false;

func _init():
	
	pass

func _process(delta):
	if !snapped:
		position = Vector2(get_global_mouse_position().x-16, get_global_mouse_position().y-16);
	snapped = false;
	pass;
	
func _input(event):
	
	pass;


func _on_player_object_selected(position: Vector2, mass: float) -> void:
	snapped = true;
	self.position.x = position.x-16;
	self.position.y = position.y-16;

	pass # Replace with function body.
