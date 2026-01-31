extends Area2D

signal pressed
var orig_pos: Vector2
var can_press = true

func _ready() -> void:
	orig_pos = $Sprite.position

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed && can_press):
		pressed.emit()
		$Sprite.position.y += 20
		await get_tree().create_timer(0.1).timeout
		$Sprite.position = orig_pos
