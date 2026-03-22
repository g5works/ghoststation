extends Node
@onready var color_sprite: Sprite2D = $'.'
var cycleComplete = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_sprite.self_modulate = Color("red")
	color_sprite.self_modulate.a = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!cycleComplete):
		cycle()
		cycleComplete = true
	else:
		pass
	
func cycle() -> void:
	await get_tree().create_timer(0.5).timeout
	color_sprite.self_modulate.a = 0.0
	await get_tree().create_timer(0.5).timeout
	color_sprite.self_modulate.a = 1.0
	cycleComplete = false
