extends Area2D

signal pressed
var can_press = true

@export var visuals: SpriteFrames

func _ready() -> void:
	$Sprite.sprite_frames = visuals
	$Sprite.frame = 0

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed && can_press):
		pressed.emit()
		$Sprite.frame = 1
		await get_tree().create_timer(0.1).timeout
		$Sprite.frame = 0
