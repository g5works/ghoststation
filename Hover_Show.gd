extends Node

@onready var Missionbox: TextureRect = $TextureRect
var isHovering = false
var opacit = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Missionbox.modulate.a = 0.0# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while (opacit >= 0 and !isHovering):
		opacit -= 0.01
		await get_tree().create_timer(0.01).timeout
		Missionbox.modulate.a = opacit
		
	while (opacit <= 0.5 and isHovering):
		opacit += 0.01
		await get_tree().create_timer(0.01).timeout
		Missionbox.modulate.a = opacit


func _on_mouse_entered() -> void:
	isHovering = true # Replace with function body.


func _on_mouse_exited() -> void:
	isHovering = false# Replace with function body.
