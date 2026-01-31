extends AnimationPlayer

var timer : Timer
var animations: Array[Variant] = [
"idle",
"face_screen",
"face_away"]

func _ready() -> void:
	timer = get_node("Timer")
	timer.wait_time = randf_range(0.5, 3)
	timer.timeout.connect(_on_timer_timeout)
	animation_finished.connect(_on_animation_finished)
	timer.start()

func _on_timer_timeout() -> void:
	play_next_animation()
	timer.stop()


func play_next_animation() -> void:
	play(animations.pick_random())

func _on_animation_finished(animation : String) -> void:
	timer.start()
