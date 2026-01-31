extends Node2D

var test_mask : Mask

func _ready() -> void:
	test_mask = get_node("Mask")
	if test_mask.has_prop_combo(MaskProperties.PropType.EYE, MaskProperties.PropColor.GREEN):
		print ("has green eye")
