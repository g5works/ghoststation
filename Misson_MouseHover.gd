extends Node
@onready var popup = $TextPopup
var isHovering = false;
var opacit = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup.modulate.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	if (isHovering):
#		popup.modulate.a = 0.5
#	else:
#		popup.modulate.a = 0.0
		
	while (opacit >= 0 and !isHovering):
		opacit -= 0.01
		await get_tree().create_timer(0.01).timeout
		popup.modulate.a = opacit
		
	while (opacit <= 0.5 and isHovering):
		opacit += 0.01
		await get_tree().create_timer(0.01).timeout
		popup.modulate.a = opacit


func _on_mouse_entered() -> void:
	isHovering = true
	


func _on_mouse_exited() -> void:
	isHovering = false
	
