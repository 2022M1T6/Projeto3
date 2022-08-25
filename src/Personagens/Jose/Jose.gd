extends KinematicBody2D

export(float) var moveSpeed = 10
var isDashing = false
var canDash = true
var dashDir = Vector2.ZERO
var velocity = Vector2.ZERO
var dashSpeed = 600
var dashLenght= 0.3
var attacking = false


onready var animation: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox = $Hitbox
onready var sprite = $Sprite
onready var timer = $dash
onready var particles = $Particles2D

#A função foi chamada para conectar o timer com a função "timer_timeout"
func _ready():
	timer.connect("timeout",self,"timer_timeout")
	
#Função que determina o que acontece quando o tempo do timer esgota
func timer_timeout():
	isDashing = false
	$Area2D.collision_layer = 1
	yield(get_tree().create_timer(1),"timeout")
	canDash = true

#Função que faz todo o processamento do dash/esquiva
func dash():
	if Input.is_action_just_pressed("dash") and canDash:
		isDashing = true
		canDash = false
		dashDir = get_move_direction().normalized() * dashSpeed
		$Area2D.collision_layer = 2
		timer.start(dashLenght)
		
	if isDashing:
		particles.emitting = true
	else:
		particles.emitting = false
		
	
# Retorna em um Vetor com X e Y positivo ou negativo, dependendo dos botões clicados
func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
		int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	)
	
# Função que executa o movimento do personagem
func _physics_process(delta):
	velocity = get_move_direction().normalized() * moveSpeed * delta * 1000
	verify_direction()
	animate()
	dash()
	if isDashing:
		move_and_slide(dashDir)
	else:
		move_and_slide(velocity)


# Função que realiza o movimento de ataque
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") and attacking == false:
		attacking = true
		animation.play("attack")
		yield(get_tree().create_timer(0.4),"timeout")
		attacking = false
			
# Função que rege a hurtbox do personagem
func _on_Hitbox_area_entered(area):
	if area.is_in_group("hurbox"):
		area.take_damage()

# Função que determina qual animação aparecer
func animate() -> void:
	if velocity != Vector2.ZERO:
		if attacking == false:
			animation.play("run")
	else:
		if attacking == false:
			animation.play('idle')
			
			
# Função que inverte o sprite ao mudar a direção
func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
