class_name MaskProp
extends Node2D

@export var prop_type : MaskProperties.PropType
@export var prop_color : MaskProperties.PropColor
@export var chance_for_empty : float = 0.1

var prop_sprite : Sprite2D

func _ready() -> void:
	prop_sprite = get_node("Sprite")
	set_random_color()
	set_sprite(prop_type)

func set_prop_type(type : MaskProperties.PropType) -> void :
	prop_type = type
	set_sprite(type)

func set_color(color_key: MaskProperties.PropColor) -> void:
	var col = MaskProperties.PROP_COLOR_DICT.get(color_key)
	if col is Color :
		prop_color = color_key
		prop_sprite.modulate = col

func set_random_color() -> void:
	# Skip index 0 so that color is not set to empty
	var index : int = randi_range(1, MaskProperties.PropColor.size() - 1)
	var color_key = MaskProperties.PropColor.values()[index]
	var col = MaskProperties.PROP_COLOR_DICT.get(color_key)
	if col is Color :
		prop_color = color_key
		prop_sprite.modulate = col


func set_sprite(prop_key : MaskProperties.PropType) -> void:
	var sprite_path: String = ""
	var index : int = 0
	match prop_key :
		MaskProperties.PropType.EMPTY:
			pass
		MaskProperties.PropType.EYES:
			index = randi_range(0, MaskProperties.EYE_SPRITES.size() - 1)
			sprite_path = MaskProperties.EYE_SPRITES[index]
		MaskProperties.PropType.EARS :
			index = randi_range(0, MaskProperties.EAR_SPRITES.size() - 1)
			sprite_path = MaskProperties.EAR_SPRITES[index]
		MaskProperties.PropType.MOUTH:
			index = randi_range(0, MaskProperties.MOUTH_SPRITES.size() - 1)
			sprite_path = MaskProperties.MOUTH_SPRITES[index]
		MaskProperties.PropType.HORNS:
			index = randi_range(0, MaskProperties.HORN_SPRITES.size() - 1)
			sprite_path = MaskProperties.HORN_SPRITES[index]

		MaskProperties.PropType.NOSE:
			pass
		MaskProperties.PropType.HAT:
			pass
		MaskProperties.PropType.HAIR :
			pass
	if sprite_path != "" :
		prop_sprite.texture = load(sprite_path)
	else :
		prop_sprite.texture = null
