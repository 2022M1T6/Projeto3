extends KinematicBody2D

# States
enum STATES {IDLE, WALKING, RUNNING, ATTACKING, DASHING, DIED} # Estado atual do NPC
enum WEAPONS {PUNCH, AXE}
enum TERRAINS {GRASS, CONCRETE}

onready var dash = $dash

# Current States
var state = STATES.IDLE
var weapon = WEAPONS.AXE
var terrain = TERRAINS.CONCRETE

# Sound flags
var isPlayingWalkingOrRunningSound = false

# Animation flags
export (bool) var isPlayingAttackAnimation = false # Muda com a animação

# Atributos
export (Vector2) var moveDirection = Vector2(0,0)
export (int) var moveSpeed = 10

var canDash = true
var isDashing = false

# Função responsável por alterar o estado
func setState(newState: int) -> void:
	if newState != STATES.ATTACKING:
		isPlayingAttackAnimation = false
	state = newState
	
# Função responsável por alterar a arma do jogador
func setWeapon(newWeapon: int) -> void:
	weapon = newWeapon

# Função responsável por alterar o terreno do jogador
func setTerrain(newTerrain: int) -> void:
	terrain = newTerrain

# Função que seta a direção do player com base no teclado
func setMoveDirectionByKeyboard():
	setMoveDirection(Vector2(
		int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
		int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	))

# Função que seta a direção do player
func setMoveDirection(newMoveDirection: Vector2):
	moveDirection = newMoveDirection
	
# Verifica se o botão de ataque está pressionado e seta o estado
func verifyAttackByKeybord():
	if Input.is_action_just_pressed("attack"):
		setState(STATES.ATTACKING)
	
func movePlayer():
	if moveDirection:
		if Input.is_action_pressed("shift"):
			setState(STATES.RUNNING)
		else:
			setState(STATES.WALKING)
		movePlayerByKeyboard()
	elif state == STATES.RUNNING || state == STATES.WALKING:
		setState(STATES.IDLE)
	
# Função que efetivamente move o player
func movePlayerByKeyboard() -> void:
	var nextPosition = moveDirection.normalized() * moveSpeed * 20
	if state == STATES.RUNNING:
		nextPosition *= 1.3
	elif state == STATES.DASHING:
		nextPosition *= 5
		
	var movement = move_and_slide(nextPosition)
	
	# Caso haja alguma barreira impedindo o jogador de mover-se, muda para o estado IDLE
	if !movement.x && !movement.y:
		setState(STATES.IDLE)

# Função que retorna a stream do som de andar ou correr de acordo com o terreno
func getWalkingOrRunningSoundByTerrain():
	match terrain:
		TERRAINS.GRASS:
			return load("res://Public/Sounds-effects/WalkingOnGrass.wav")
		TERRAINS.CONCRETE, _:
			return load("res://Public/Sounds-effects/walkingOnConcrete.wav")

# Função que seta a stream do som de corrida ou caminhada de acordo com o terrenho
func setWalkingAndRunningSoundByTerrain():
	var soundTerrain = getWalkingOrRunningSoundByTerrain()
	$RunningSound.stream = soundTerrain
	$WalkingSound.stream = soundTerrain

# Função que roda ou para o som de caminhada ou corrida
func playOrStopWalkingOrRunningSound():
	match state:
		STATES.WALKING:
			$RunningSound.stop()
			$WalkingSound.play()
			isPlayingWalkingOrRunningSound = true
		STATES.RUNNING:
			$RunningSound.play()
			$WalkingSound.stop()
			isPlayingWalkingOrRunningSound = true
		_:
			$RunningSound.stop()
			$WalkingSound.stop()
			isPlayingWalkingOrRunningSound = false

# Função responsável por executar a animação e de ataque
func animateAttack() -> void:
	if !isPlayingAttackAnimation:
		match weapon:
			WEAPONS.AXE:
				$AnimationPlayer.play("axeAttack")
				if !$AxeAttackSound.playing:
					$AxeAttackSound.play()
			WEAPONS.PUNCH:
				$AnimationPlayer.play("punchAttack")
				if !$PunchSound.playing:
					$PunchSound.play()
		isPlayingAttackAnimation = true
	elif !$AnimationPlayer.is_playing():
		setState(0)

# Função responsável por executar a animação e som de corrida ou caminhada
func animateWalkingOrRunning() -> void:
	setPlayerDirection()
	
	match state:
		STATES.WALKING:
			$AnimationPlayer.play("walk")
		STATES.RUNNING:
			$AnimationPlayer.play("run")
			
	if !isPlayingWalkingOrRunningSound:
		setWalkingAndRunningSoundByTerrain()
		playOrStopWalkingOrRunningSound()
	
# Função responsável por executar a animação idle
func animateIdle() -> void:
	$AnimationPlayer.play("idle")
	playOrStopWalkingOrRunningSound()
	


# Função responsável por dar play na animação e som com base no estado
func animate() -> void:
	match state:
		STATES.IDLE:
			animateIdle()
		STATES.WALKING, STATES.RUNNING:
			animateWalkingOrRunning()
		STATES.ATTACKING:
			animateAttack()
		STATES.DIED:
			$AnimationPlayer.play("die")
	
# Função que seta o sprite e hitbox de acordo com a posição que o player anda
func setPlayerDirection():
	if moveDirection.x > 0:
		$Sprite.flip_h = false
		$Hitbox.position.x = 9
	elif moveDirection.x < 0:
		$Sprite.flip_h = true
		$Hitbox.position.x = -9

# Verifica se o player já montou o machado certo
func _ready():
	if GlobalFase1.AxeOk:
		setWeapon(WEAPONS.AXE)
	else:
		setWeapon(WEAPONS.PUNCH)

# Process de Fisica
func _physics_process(delta) -> void:
	animate()
	movePlayer()
	
	

# Verifica os inputs do teclado
func _unhandled_key_input(event):
	setMoveDirectionByKeyboard()
	verifyAttackByKeybord()

	
	return event
func _process(delta):
	$PunchSound.volume_db = GlobalOptions.setSFXSound(-15)
	$RunningSound.volume_db = GlobalOptions.setSFXSound(0)
	$WalkingSound.volume_db = GlobalOptions.setMusicSound(0)
	$AxeAttackSound.volume_db = GlobalOptions.setSFXSound(-15)









	
