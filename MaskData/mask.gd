class_name Mask
extends Node2D

var mask_sprite : Sprite2D
var base_color : MaskProperties.PropColor

var all_properties : Array
var all_colors : Array
var propNode : Node2D


func _ready() -> void:
	mask_sprite = get_node("MaskSprite")
	set_random_color()
	propNode = get_node("Props")
	get_all_mask_properties()

func set_random_color() -> void:
	var index : int = randi_range(0, MaskProperties.PropColor.size() - 1)
	var color_key = MaskProperties.PropColor.values()[index]
	var col = MaskProperties.PROP_COLOR_DICT.get(color_key)
	if col is Color :
		mask_sprite.modulate = col
		base_color = color_key


func get_all_mask_properties() -> void:
	for node in propNode.get_children():
		var mask_prop: MaskProp = node as MaskProp
		if mask_prop != null :
			all_properties.append(mask_prop.prop_type)
			all_colors.append(mask_prop.prop_color)

## Return true if mask has the given prop type anywhere.
func has_prop_type(prop_type : MaskProperties.PropType) -> bool :
	for prop in all_properties :
		if prop == prop_type :
			return true
	return false

## Return true if any mask prop has the given color.
func has_prop_color(prop_color : MaskProperties.PropColor) -> bool :
	if base_color == prop_color :
		return true
	for col in all_colors :
		if prop_color == col :
			return true
	return false

## Return true only if the mask contains a prop which has both the given type and color.
func has_prop_combo(prop_type : MaskProperties.PropType, prop_color : MaskProperties.PropColor) -> bool:
	for node in propNode.get_children():
		var mask_prop: MaskProp = node as MaskProp
		if mask_prop != null && mask_prop.prop_color == prop_color && mask_prop.prop_type == prop_type:
			return true
	return false
