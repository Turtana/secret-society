class_name MaskProperties
extends Node

enum PropType {EYE, EAR, NOSE, MOUTH, HORN, HAT}
enum PropColor {RED, BLUE, GREEN}

const EYE_SPRITES : Array = [
"res://MaskData/Sprites/Eye1.png",
"res://MaskData/Sprites/Eye2.png"
]

const EAR_SPRITES : Array = [
]

const MOUTH_SPRITES : Array = [
"res://MaskData/Sprites/Mouth1.png"
]

const HORN_SPRITES : Array = [
"res://MaskData/Sprites/Horn1.png",
"res://MaskData/Sprites/Horn2.png"]

const PROP_COLOR_DICT: Dictionary = {
PropColor.RED : Color.RED,
PropColor.BLUE : Color.BLUE,
PropColor.GREEN : Color.GREEN}
