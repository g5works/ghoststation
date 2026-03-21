extends ProgressBar

var current_chg: float = 0;
var total_chg: float = 0;

func _init():
	max_value = total_chg;
	
func _process(delta):
	pass;
	
func _input(delta): 
	pass;


func _on_player_charge_amount(current: float, total: float) -> void:
	max_value = total;
	value = current;
	print(current);
	
	pass # Replace with function body.
