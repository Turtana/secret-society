extends Node2D

@export var guest_template: PackedScene = preload("res://guest_placeholder.tscn")

var guests: Array[Node2D] = []

### CONTROL PANEL ###
var number_of_guests := 20
var spy_percentage = 0.50
var time = 90
#####################

var guest_distance := 200

var number_of_rules: int
var rules = []
var fails := 0

func _ready() -> void:
	$Pass.pressed.connect(pass_pressed)
	$Reject.pressed.connect(reject_pressed)
	$Info.hide()
	$Tutorial.hide()
	$GameOver.hide()
	fails = 0
	
	$Clock/Timer.start(time)
	number_of_rules = Global.difficulty
	
	generate_rules()
	
	# generate guests
	for i in range(number_of_guests):
		var guest_number = number_of_guests - i - 1
		var new_guest = guest_template.instantiate()
		
		if randf() < spy_percentage:
			new_guest.is_member = false
		
		$GuestLine.add_child(new_guest)
		
		var colorlist = MaskProperties.PropColor.keys()
		#var proplist = MaskProperties.PropType.keys()
		
		var mask: Mask = new_guest.get_node("Visual/Mask")
		if new_guest.is_member:
			# make the guest follow all rules
			#print("this is a member")
			for rule in rules:
				if rule.size() == 1:
					# set this prop at any color, except number 0 (empty)
					# e.g. must have horns
					
					var color = (randi() % (colorlist.size() - 1)) + 1
					mask.set_mask_prop(rule[0], color)
					#print("set " + proplist[rule[0]] + " to " + colorlist[color])
				if rule.size() == 2:
					# set color to a specific prop
					mask.set_mask_prop(rule[0], rule[1])
					#print("set " + proplist[rule[0]] + " to " + colorlist[rule[1]])
		else:
			#print("this is a spy")
			# make the guest break a random rule, if by some miracle their mask was correct
			var broken = rules.pick_random()
			if broken.size() == 1:
				# must have horns -> set to "no horns"
				mask.set_mask_prop(broken[0], MaskProperties.PropColor.NO)
			if broken.size() == 2:
				# must have blue eyes -> set to "some other color eyes"
				var color = broken[1]
				# avoid overflow error
				if color == MaskProperties.PropColor.keys().size() - 1:
					color -= 1
				else:
					color += 1
				mask.set_mask_prop(broken[1], color)
		
		# drawn in reverse order to make the z-order work. Looks ugly. Hopefully this won't backfire later...
		#new_guest.position = $JudgePosition.position + Vector2(number_of_guests * guest_distance - i * guest_distance - guest_distance, -.2 * guest_distance)
		new_guest.position = $JudgePosition.position + Vector2(guest_number * guest_distance, 0)
		#new_guest.scale *= 1 - guest_number * .1
		# this has to be scaled, otherwise the line looks much thinner farther back
		guest_distance += 10
		guests.append(new_guest)
	guests.reverse() # NOW the first guy on the line is at the table. All's well in the world.
	

func _process(_delta: float) -> void:
	$Clock/Time.text = str(int($Clock/Timer.time_left))

func pass_pressed() -> void:
	if guests.is_empty():
		return
	
	$Reject.can_press = false
	$Pass.can_press = false
	
	var tween = create_tween()
	var guest = guests.pop_front()
	
	advance_line()
	
	guest.get_node("Pass").play()
	
	if not guest.is_member:
		info_player("THAT WAS A SPY!")
		add_fail()
	
	# guest leaves for Grey Docks
	tween.tween_property(guest, "position", guest.position + Vector2(-1200, 0), 1.0)
	guest.walking = true
	await tween.finished
	guest.queue_free()
	
	$Reject.can_press = true
	$Pass.can_press = true
	
	if guests.size() == 0:
		you_win()

func reject_pressed() -> void:
	if guests.is_empty():
		return
	
	$Reject.can_press = false
	$Pass.can_press = false
	
	var tween = create_tween()
	var guest = guests.pop_front()
	
	guest.get_node("Death").play()

	advance_line()
	
	if guest.is_member:
		info_player("THAT WAS A REAL MEMBER!")
		add_fail()

	# guest drops out of the picture
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(guest, "position", guest.position + Vector2(0, 2000), .6)
	await tween.finished
	guest.queue_free()
	
	$Reject.can_press = true
	$Pass.can_press = true
	
	if guests.size() == 0:
		you_win()

func advance_line() -> void:
	var goto_scale = Vector2.ONE
	var goto_place = $JudgePosition.position
	$Line.play()
	for guest in guests:
		create_tween().tween_property(guest, "position", goto_place, 1.0)
		create_tween().tween_property(guest, "scale", goto_scale, 1.0)
		goto_place = guest.position
		goto_scale = guest.scale
		guest.start_walking()
	await get_tree().create_timer(1.0).timeout
	for guest in guests:
		guest.walking = false

func generate_rules():
	var prop_types_string = MaskProperties.PropType.keys()
	var colors_string = MaskProperties.PropColor.keys()
	
	# hardcoded the amount of props. Bad, but shall do
	var prop_numbers = [1,2,3,4,5,6,7]
	prop_numbers.shuffle()
	var take_rule_nr = 0
	
	var rules_text = "[color=cyan]TODAY'S RULES[/color]\n\n"
	for i in range(number_of_rules):
		var care_about_color = randf() < .8
		
		var color_number = randi() % colors_string.size()
		var color_text = colors_string[color_number].to_lower()
		var prop_number = prop_numbers[take_rule_nr]
		var prop_text = prop_types_string[prop_number].to_lower()
		take_rule_nr += 1
		
		# save rules
		if care_about_color:
			rules.append([prop_number, color_number])
		else:
			rules.append([prop_number])
		
		# can't have multiple rules concerning the same prop type, to avoid contradictions
		#prop_types_string.pop_at(prop_number)
		
		# print rules
		var prop_color = color_text + " " if care_about_color else ""
		var rule = "- must have " + prop_color + prop_text + "\n"
		rules_text += rule
	$Rules/Text.text = rules_text

func info_player(text: String):
	$Info.text = text
	$Info.show()
	await get_tree().create_timer(1.0).timeout
	$Info.hide()

func add_fail():
	fails += 1
	$Rules/Fails.text = "Mistakes: " + str(fails) + "/3"
	
	if fails == 3:
		await get_tree().create_timer(1.0).timeout
		game_over("You misidentified too many guests")

func game_over(text: String) -> void:
	$Reject.can_press = false
	$Pass.can_press = false
	$Clock/Timer.paused = true
	$TutorialButton.disabled = true
	
	$Music.pitch_scale = .8
	
	$GameOver/Text.text = text
	$GameOver.show()

func you_win() -> void:
	$Reject.can_press = false
	$Pass.can_press = false
	$Clock/Timer.paused = true
	$TutorialButton.disabled = true
	
	$Music.pitch_scale = 1.1
	
	$GameOver/Over.modulate = Color.GREEN
	$GameOver/Text.modulate = Color.GREEN
	$GameOver/Over.text = "FINISHED"
	$GameOver/Text.text = "Time left: " + str(snapped($Clock/Timer.time_left, 0.01))
	$GameOver.show()

func show_tutorial() -> void:
	$Tutorial.show()
	$Clock/Timer.paused = true

func close_tutorial() -> void:
	$Tutorial.hide()
	$Clock/Timer.paused = false

func restart() -> void:
	get_tree().reload_current_scene()


func difficulty_changed(value: float) -> void:
	var diff = int(value)
	Global.difficulty = diff
	$GameOver/DiffLabel.text = "Difficulty: " + str(diff) + " rules"
