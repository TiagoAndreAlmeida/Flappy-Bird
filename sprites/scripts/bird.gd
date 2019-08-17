extends RigidBody2D

onready var anim = get_node("AnimationPlayer")
onready var GUI  = get_tree().get_root().get_child(2).get_node("CanvasLayer").get_child(0)

func _ready():
	#processo para trabalha com physics
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	#se estiver no estado de PLAY faça isso
	if (state_machine.current_state == state_machine.PLAY):
		set_mode( MODE_RIGID )
		#verifica se a rotação em graus é maior que 30 e seta pra 30 como limite
		#godot trabalha com radianos por isso a função rad2deg/deg2rad faz conversão
		if rad2deg(get_rot()) > 30 :
			set_rot(deg2rad(30))
			set_angular_velocity(0)
			
		if rad2deg(get_rot()) <= -75:
			set_rot(deg2rad(-75))
		
		#verifica se esta caindo, e seta rotacao no sentido horario
		if get_linear_velocity().y > 1.0:
			set_angular_velocity(3)
	
	if (state_machine.current_state == state_machine.MENU):
		set_mode( MODE_STATIC )
		if anim.get_current_animation() != "idle":
			anim.play("idle")

func flap():
	#seta a velocidade em y
	set_linear_velocity(Vector2(get_linear_velocity().x, -150))
	#seta a velocidade angular pra -3 || sentido anti-horário
	set_angular_velocity(-6)
	anim.play("flap")
	samplePlayer.play("sfx_wing")

func _input(event):
	#se estiver no estado de PLAY faça isso
	if (state_machine.current_state == state_machine.PLAY):
		if event.is_action_pressed("jump"):
			flap()


func _on_bird_body_enter( hit ):
	#print(hit.is_in_group(state_machine.GROUP_PIPE))
	if (hit.is_in_group(state_machine.GROUP_POINT) and state_machine.current_state == state_machine.PLAY):
		GUI.emit_signal("point_changed")
		samplePlayer.play("sfx_point")
		hit.queue_free()
	if (hit.is_in_group(state_machine.GROUP_PIPE) or hit.is_in_group(state_machine.GROUP_GROUND) ):
		if(state_machine.current_state != state_machine.LOSE):
			state_machine.current_state = state_machine.LOSE
			samplePlayer.play("sfx_hit")