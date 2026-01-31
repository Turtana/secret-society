extends Node2D

var test_mask : Mask

func _ready() -> void:
	test_mask = get_node("Mask")
	test_mask.set_mask_prop(MaskProperties.PropType.EYES, MaskProperties.PropColor.EMPTY)
	if test_mask.has_prop_combo(MaskProperties.PropType.EYES, MaskProperties.PropColor.GREEN):
		print ("has green eye")
