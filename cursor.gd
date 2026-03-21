extends TextureRect

var snapped = false;
@onready var massindicator = get_node("Mass Indicator") as Label;

func _init():
	
	pass

func _process(delta):
	
	massindicator.visible = snapped;
	
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
	massindicator.text = "Mass: " + str(mass);
	
	if mass >= 500:
		massindicator.label_settings.font_color = Color("#FF9100")
	else:
		massindicator.label_settings.font_color = Color("#006FFF")

	pass # Replace with function body.
