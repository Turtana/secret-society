extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Mask.modulate = Color(randf(), randf(), randf())
	$Mask.rotation_degrees += 15 * (randf() * 2 - 1)
