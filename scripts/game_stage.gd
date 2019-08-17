extends Node

onready var bg = get_node("background")
onready var GUI = get_node("CanvasLayer").get_child(0)
export var parallax_speed = 0
var time = 0
onready var state_machine = get_tree().get_root().get_node("/root/state_machine")

func _ready():
	set_process(true)

func _process(delta):
	if(state_machine.current_state == state_machine.MENU):
		#GUI.show()
		time += parallax_speed * delta
		bg.set_region_rect(Rect2(Vector2(time, bg.get_region_rect().pos.y), bg.get_region_rect().size))
	elif(state_machine.current_state == state_machine.PLAY):
		#GUI.hide()
		time += parallax_speed * delta
		bg.set_region_rect(Rect2(Vector2(time, bg.get_region_rect().pos.y), bg.get_region_rect().size))