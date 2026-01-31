class_name MaskProperties
extends Node

enum PropType {EMPTY, EYES, EARS, NOSE, MOUTH, HORNS, HAT, HAIR}
enum PropColor {NO, RED, BLUE, WHITE}

const MASK_SPRITES : Array = [
"res://MaskData/Sprites/Props/maskbase1.png",
"res://MaskData/Sprites/Props/maskbase2.png",
"res://MaskData/Sprites/Props/maskbase3.png",
"res://MaskData/Sprites/Props/maskbase4.png"]

const EYE_SPRITES : Array = [
"res://MaskData/Sprites/Props/eyes1.png",
"res://MaskData/Sprites/Props/eyes2.png",
"res://MaskData/Sprites/Props/eyes3.png",
"res://MaskData/Sprites/Props/eyes4.png",
"res://MaskData/Sprites/Props/eyes5.png"
]

const EAR_SPRITES : Array = [
"res://MaskData/Sprites/Ears.png"]

const NOSE_SPRITES : Array = [
"res://MaskData/Sprites/Props/nose1.png",
"res://MaskData/Sprites/Props/nose2.png",
"res://MaskData/Sprites/Props/nose3.png",
"res://MaskData/Sprites/Props/nose4.png",
"res://MaskData/Sprites/Props/nose5.png",
"res://MaskData/Sprites/Props/nose6.png"]

const MOUTH_SPRITES : Array = [
"res://MaskData/Sprites/Props/mouth1.png",
"res://MaskData/Sprites/Props/mouth2.png",
"res://MaskData/Sprites/Props/mouth3.png",
"res://MaskData/Sprites/Props/mouth4.png",
"res://MaskData/Sprites/Props/mouth5.png"]

const HORN_SPRITES : Array = [
"res://MaskData/Sprites/Props/horns1.png",
"res://MaskData/Sprites/Props/horns2.png",
"res://MaskData/Sprites/Props/horns3.png",
"res://MaskData/Sprites/Props/horns4.png",
"res://MaskData/Sprites/Props/horns5.png"]

const HAT_SPRITES : Array = ["res://MaskData/Sprites/Hat.png"]

const HAIR_SPRITES : Array = ["res://MaskData/Sprites/Hair.png"]

const PROP_COLOR_DICT: Dictionary = {
PropColor.RED : Color.DARK_RED,
PropColor.BLUE : Color.MIDNIGHT_BLUE,
PropColor.WHITE : Color.WHITE}
