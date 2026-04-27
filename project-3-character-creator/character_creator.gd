extends Control

@onready var head_sprite = $CharacterArea/Head
@onready var body_sprite = $CharacterArea/Body
@onready var legs_sprite = $CharacterArea/Legs

@onready var string_label = $StringLabel
@onready var code_input = $CodeInput
@onready var message_label = $MessageLabel

var head_options = [
	preload("res://assets/heads/head_0.png"),
	preload("res://assets/heads/head_1.png"),
	preload("res://assets/heads/head_2.png")
]

var body_options = [
	preload("res://assets/bodies/body_0.png"),
	preload("res://assets/bodies/body_1.png"),
	preload("res://assets/bodies/body_2.png")
]

var legs_options = [
	preload("res://assets/legs/legs_0.png"),
	preload("res://assets/legs/legs_1.png"),
	preload("res://assets/legs/legs_2.png")
]

var head_colors = [
	Color.WHITE,
	Color.SKY_BLUE,
	Color.LIGHT_GREEN,
	Color.PINK
]

var head_number = 0
var body_number = 0
var legs_number = 0
var color_number = 0

var saved_code = ""

func _ready():
	$HeadPrevButton.pressed.connect(head_back)
	$HeadNextButton.pressed.connect(head_forward)

	$BodyPrevButton.pressed.connect(body_back)
	$BodyNextButton.pressed.connect(body_forward)

	$LegsPrevButton.pressed.connect(legs_back)
	$LegsNextButton.pressed.connect(legs_forward)

	$ColorPrevButton.pressed.connect(color_back)
	$ColorNextButton.pressed.connect(color_forward)

	$LoadButton.pressed.connect(load_from_code)

	update_character()


func loop_number(number, max_size):
	if number < 0:
		return max_size - 1

	if number >= max_size:
		return 0

	return number


func update_character():
	head_sprite.texture = head_options[head_number]
	body_sprite.texture = body_options[body_number]
	legs_sprite.texture = legs_options[legs_number]

	head_sprite.modulate = head_colors[color_number]

	saved_code = str(head_number) + "-" + str(body_number) + "-" + str(legs_number) + "-" + str(color_number)

	string_label.text = "Customization Code: " + saved_code
	code_input.text = saved_code


func head_back():
	head_number -= 1
	head_number = loop_number(head_number, head_options.size())
	update_character()


func head_forward():
	head_number += 1
	head_number = loop_number(head_number, head_options.size())
	update_character()


func body_back():
	body_number -= 1
	body_number = loop_number(body_number, body_options.size())
	update_character()


func body_forward():
	body_number += 1
	body_number = loop_number(body_number, body_options.size())
	update_character()


func legs_back():
	legs_number -= 1
	legs_number = loop_number(legs_number, legs_options.size())
	update_character()


func legs_forward():
	legs_number += 1
	legs_number = loop_number(legs_number, legs_options.size())
	update_character()


func color_back():
	color_number -= 1
	color_number = loop_number(color_number, head_colors.size())
	update_character()


func color_forward():
	color_number += 1
	color_number = loop_number(color_number, head_colors.size())
	update_character()


func load_from_code():
	var typed_code = code_input.text.strip_edges()
	var pieces = typed_code.split("-")

	if pieces.size() != 4:
		message_label.text = "Use four numbers like 0-1-2-3"
		return

	for piece in pieces:
		if not piece.is_valid_int():
			message_label.text = "Only numbers are allowed."
			return

	var new_head = int(pieces[0])
	var new_body = int(pieces[1])
	var new_legs = int(pieces[2])
	var new_color = int(pieces[3])

	if new_head < 0 or new_head >= head_options.size():
		message_label.text = "That head number does not exist."
		return

	if new_body < 0 or new_body >= body_options.size():
		message_label.text = "That body number does not exist."
		return

	if new_legs < 0 or new_legs >= legs_options.size():
		message_label.text = "That legs number does not exist."
		return

	if new_color < 0 or new_color >= head_colors.size():
		message_label.text = "That color number does not exist."
		return

	head_number = new_head
	body_number = new_body
	legs_number = new_legs
	color_number = new_color

	message_label.text = "Code loaded."
	update_character()
