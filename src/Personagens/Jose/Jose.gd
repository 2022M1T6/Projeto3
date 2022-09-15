extends KinematicBody2D

export(float) var moveSpeed = 10
export(float) var maxHp = 100
export(float) var currentHp = maxHp
export(float) var damage = 20

var isDashing = false
var canDash = true
var dashDir = Vector2.ZERO
var velocity = Vector2.ZERO
var dashSpeed = 600
var dashLenght= 0.3
var attacking = false
var haveAxe


onready var animation: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox = $Hitbox
onready var sprite = $Sprite
onready var timer = $dash
onready var particles = $Particles2D

# A função foi chamada para conectar o timer com a função "timer_timeout"
func _ready():
	timer.connect("timeout",self,"timer_timeout")
	$Hitbox/CollisionShape2D.disabled = true
	
# Função que determina o que acontece quando o tempo do timer esgota
func timer_timeout():
	isDashing = false
	yield(get_tree().create_timer(1),"timeout")
	canDash = true

# Função que faz todo o processamento do dash/esquiva
func dash():
	if Input.is_action_just_pressed("dash") and canDash:
		isDashing = true
		canDash = false
		dashDir = get_move_direction().normalized() * dashSpeed
		timer.start(dashLenght)
		$DashSound.play()
		
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
	if Input.is_action_pressed("shift"): 
		velocity *= 2 
		
	verify_direction()
	animate()
	dash()
	if isDashing:
		move_and_slide(dashDir)
	else:
		move_and_slide(velocity)

func _process(delta):
	if GlobalFase1.axeChoicedParts == []:
		haveAxe = false
	else:
		haveAxe = true


# Função que realiza o movimento de ataque
func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("punch") and attacking == false:
			attacking = true
			if haveAxe == false:
				animation.play("punchAttack")
				$PunchSound.play()
			else:
				animation.play("attack")
			yield(get_tree().create_timer(0.4),"timeout")
			attacking = false
	if event.is_action_pressed("death") and attacking == false:
		attacking = true
		animation.play("death")
		yield(get_tree().create_timer(0.4),"timeout")
		attacking = false

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
		$Hitbox.position.x = 9
	elif velocity.x < 0:
		sprite.flip_h = true
		$Hitbox.position.x = -9


