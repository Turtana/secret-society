extends Node2D

var jump_height = 50
var jumping = false
var walking = false

func _ready() -> void:
	$Visual/Mask.modulate = Color(randf(), randf(), randf())
	$Visual/Mask.rotation_degrees += 15 * (randf() * 2 - 1)

func _process(_delta: float) -> void:
	if not jumping and not walking:
		if randf() < .003:
			jump()
	if walking:
		jump()

func start_walking():
	# the point of this function is to add a little randomness to the start of walking
	# so that the guest don't all march in sync.
	# between 0 - 0.2 sec
	await get_tree().create_timer(randf() * .35).timeout
	walking = true

func jump():
	if jumping:
		return
	jumping = true
	var up = create_tween()
	up.set_ease(Tween.EASE_OUT)
	up.set_trans(Tween.TRANS_CUBIC)
	up.tween_property($Visual, "position", $Visual.position - Vector2(0, jump_height), .25)
	up.set_ease(Tween.EASE_IN)
	up.tween_property($Visual, "position", Vector2.ZERO, .25)
	await up.finished
	jumping = false
