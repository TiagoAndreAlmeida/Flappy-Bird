extends StaticBody2D

var speed =100
onready var state_machine = get_tree().get_root().get_node("/root/state_machine")

func _ready():
	set_process(true)
	add_to_group(state_machine.GROUP_PIPE)
	get_child(4).add_to_group(state_machine.GROUP_POINT)

func _process(delta):
	if (state_machine.current_state == state_machine.PLAY):
		set_pos(Vector2(get_pos().x + (-speed * delta), get_pos().y))
		if get_pos().x < -14 :
			queue_free()