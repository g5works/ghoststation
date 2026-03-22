extends Control
@onready var powerneg = get_node("power+");
@onready var powerpos = get_node("power-");

func _on_player_power_scale(pscale: float) -> void:
	powerneg.value = pscale;
	powerpos.value = -pscale;
	pass # Replace with function body.
