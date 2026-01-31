class_name MaskProperties
extends Node

enum PropType {EMPTY, EYES, EARS, NOSE, MOUTH, HORNS, HAT, HAIR}
enum PropColor {NO, RED, BLUE, GREEN}

const EYE_SPRITES : Array = ["res://MaskData/Sprites/Eyes.png"]

const EAR_SPRITES : Array = ["res://MaskData/Sprites/Ears.png"]

const NOSE_SPRITES : Array = ["res://MaskData/Sprites/Nose.png"]

const MOUTH_SPRITES : Array = ["res://MaskData/Sprites/Mouth1.png"]

const HORN_SPRITES : Array = ["res://MaskData/Sprites/Horns.png"]

const HAT_SPRITES : Array = ["res://MaskData/Sprites/Hat.png"]

const HAIR_SPRITES : Array = ["res://MaskData/Sprites/Hair.png"]

const PROP_COLOR_DICT: Dictionary = {
PropColor.RED : Color.RED,
PropColor.BLUE : Color.BLUE,
PropColor.GREEN : Color.GREEN}
