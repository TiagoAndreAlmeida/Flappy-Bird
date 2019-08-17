extends Control

var tapped = false
var points = 0
var best = 0

var gold_medal   = load("res://sprites/medal_gold.png")
var bronze_medal = load("res://sprites/medal_bronze.png")
var silver_medal = load("res://sprites/medal_silver.png")

signal point_changed

onready var state_machine = get_tree().get_root().get_node("/root/state_machine")
onready var bird = get_tree().get_root().get_node("root").get_node("bird")

func _ready():
	set_process(true)
	connect("point_changed", self, "_increment_point")
	get_node("Container").hide()
	
func _process(delta):
	if(state_machine.current_state == state_machine.MENU):
		show()
	
	if(state_machine.current_state == state_machine.PLAY):
		var tx = get_children()
		#print(tx)
		for i in tx: 
			if(i.get_name() != "score"):
				i.hide()
	
	if(state_machine.current_state == state_machine.LOSE):
		if(points > best):
			best = points
		set_scores()

func _input_event(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and state_machine.current_state == state_machine.MENU) :
		state_machine.current_state = state_machine.PLAY
		bird.set_mode( RigidBody2D.MODE_RIGID)
		bird.flap()

func _increment_point():
	points += 1
	get_node("score").set_text(str(points))
	
func set_scores():
	get_node("Container/_score").set_text(str(points))
	get_node("Container/_best").set_text(str(best))
	if (points > best):
		get_node("Container/medal").set_texture(gold_medal)
	elif (points == best):
		get_node("Container/medal").set_texture(silver_medal)
	else:
		get_node("Container/medal").set_texture(bronze_medal)
	get_node("Container").show()

func _on_Button_pressed():
	get_tree().reload_current_scene()
	state_machine.current_state = state_machine.MENU
