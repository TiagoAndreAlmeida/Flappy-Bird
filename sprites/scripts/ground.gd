extends StaticBody2D

onready var bg = get_node("Sprite")
onready var state_machine = get_tree().get_root().get_node("/root/state_machine")
var parallax_speed = 100
var time = 0

func _ready():
	set_process(true)
	add_to_group(state_machine.GROUP_GROUND)

func _process(delta):
	if (state_machine.current_state == state_machine.PLAY or state_machine.current_state == state_machine.MENU):
		time += parallax_speed * delta
		bg.set_region_rect(Rect2(Vector2(time, bg.get_region_rect().pos.y), bg.get_region_rect().size))