extends Node2D

@export var guest_template: PackedScene = preload("res://guest_placeholder.tscn")

var guests: Array[Node2D] = []
var number_of_guests := 10
var guest_distance = 200

func _ready() -> void:
	$Pass.pressed.connect(pass_pressed)
	$Reject.pressed.connect(reject_pressed)
	
	# TODO a way of generating guests with proper masks
	for i in range(number_of_guests):
		var guest_number = number_of_guests - i - 1
		var new_guest = guest_template.instantiate()
		$GuestLine.add_child(new_guest)
		# drawn in reverse order to make the z-order work. Hopefully this won't backfire later...
		new_guest.position = $JudgePosition.position + Vector2(number_of_guests * guest_distance - i * guest_distance - guest_distance, 0)
		new_guest.scale *= 1 - guest_number * .1
		# this has to be scaled, otherwise the line looks much thinner farther back
		guest_distance += 10
		guests.append(new_guest)
	guests.reverse() # NOW the first guy on the line is at the table

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func pass_pressed() -> void:
	var tween = create_tween()
	var guest = guests.pop_front()
	
	advance_line()
	
	# guest leaves for Grey Docks
	tween.tween_property(guest, "position", guest.position + Vector2(-2000, 0), 2.0)
	await tween.finished
	guest.queue_free()
	
	$Pass.can_press = true

func reject_pressed() -> void:
	var tween = create_tween()
	var guest = guests.pop_front()

	advance_line()

	# guest drops out of the picture
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(guest, "position", guest.position + Vector2(0, 2000), 1.0)
	await tween.finished
	guest.queue_free()
	
	$Reject.can_press = true

func advance_line() -> void:
	for guest in guests:
		pass
