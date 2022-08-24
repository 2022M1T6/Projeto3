extends KinematicBody2D

export(float) var moveSpeed = 10
var canTel = true
var velocity = Vector2.ZERO
var radius = 50
var attacking = false

onready var animation: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox = $Hitbox
onready var sprite = $Sprite

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
	move_and_slide(velocity)
	animate()

# Função que pega eventos
func _input(event):	
	# Verificando se o comando dash foi efetuado e se não está em cooldown
	if event.is_action_pressed("dash") and canTel:
		canTel = false
		self.position = self.position + get_move_direction().normalized()*radius
		yield(get_tree().create_timer(1),"timeout")
		canTel = true

# Função que realiza o movimento de ataque		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if attacking == false:	
			attacking = true
			animation.play("attack")
			yield(get_tree().create_timer(0.4),"timeout")
			attacking = false
			
		
func _on_Hitbox_area_entered(area):
	if area.is_in_group("hurbox"):
		area.take_damage()


func animate() -> void:
	if velocity != Vector2.ZERO:
		if attacking == false:
			animation.play("run")
	else:
		if attacking == false:
			animation.play('idle')
			
func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
