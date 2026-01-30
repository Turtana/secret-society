extends Area2D

signal pressed
var orig_scale: Vector2
var can_press = true

func _ready() -> void:
	orig_scale = $Sprite.scale

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed && can_press):
		can_press = false
		pressed.emit()
		$Sprite.scale = .9 * orig_scale
		await get_tree().create_timer(0.1).timeout
		$Sprite.scale = orig_scale
