extends VScrollBar

@export var scroll_speed := 30.0
@onready var change_icon_dialog: FileDialog = $"../ChangeIconDialog"

func _process(delta):
	if !change_icon_dialog.visible:
		if Input.is_action_just_released("scroll_up"): value -= scroll_speed
		if Input.is_action_just_released("scroll_down"): value += scroll_speed
#	var input = Input.get_axis("scroll_down","scroll_up")
#	print(input)
#	value += input * scroll_speed
