extends Node

var current_state setget _switch_state, get_current_state
var prev_state

const MENU = 0
const PLAY = 1
const LOSE = 2

const GROUP_PIPE = "pipe"
const GROUP_GROUND = "ground"
const GROUP_POINT = "point"

func _ready():
	current_state = MENU
	prev_state = null
	
func _switch_state(new_state):
	prev_state = current_state
	current_state = new_state
	
func get_current_state():
	return current_state
