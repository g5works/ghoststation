extends Control

@onready var bar = get_node("ProgressBar") as ProgressBar
@onready var util = get_node("Utilization") as Label
@onready var quant = get_node("Amount") as Label


var current_chg: float = 0;
var total_chg: float = 0;

func _init():
	pass;
	
func _process(delta):
	pass;
	
func _input(delta): 
	pass;




func _on_player_charge_amount(current: float, total: float, utilization: float) -> void:
	bar.max_value = total;
	bar.value = current;
	
	if current > 0:
		util.text = "(" + str(utilization) + ")";
		quant.text = "%-0.2f"%abs(current) + "/" + str(total);

	else:
		util.text = "(0.0)";
		quant.text = "0.00" + "/" + str(total);
