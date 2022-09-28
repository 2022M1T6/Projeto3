extends Popup
# Pega se o jogo já estava pausado
onready var alreadyPaused = get_tree().paused
# Pega as dimensões da global
var dimensoes = GlobalOptions.dimensoes

# Texto das dimensões 
var textos = {"vision": "Nessa dimensão, a equipe deve descobrir qual problema vão abordar e quem são os clientes impactados pelo problema. Nesse momento o objetivo é saber o que é necessário para extinguir, ou ao menos reduzir o problema, quem utilizará essa invenção e o porquê é importante essa invenção/acabar com o problema. O importante é que a equipe deve pesquisar muito, pois tudo deve se basear em dados.",
"roadmap": "Roadmap é a dimensão de organização, nessa “fase” a equipe deve traçar um roteiro/guia, que servirá para ajudar na orientação e na organização do “projeto”. Esse guia deve ser extremamente detalhado, uma vez que ele é a base para organização do produto. As etapas do planejamento são específicas e devem estar presentes no guia, no Roadmap é definida as etapas de antes, durante e para depois da criação do produto.",
"stakeholders": "Essa dimensão corresponde a etapa de mensurar o nível de interesse de pessoas, grupos ou empresas no produto. A equipe deve aprender/estudar o que pode-se melhorar, a partir dos feedbacks dos interessados no produto, dessa forma mudar estratégias e abordagens é parte dessa dimensão. Além de tudo, nessa dimensão é necessário validar a eficácia da “criação”."}
var text = {"vision": "In this dimension, the team needs to discover which problem they are going to approach and which clients are impacted by it. Now the objective is knowing what is necessary to extinguish, or at least minimize the problem, who will use this invention and why it is important. The focus is that the team needs to research plenty of data to base on it.",
"roadmap": "Roadmap is the organization dimension. In this step the team needs to map a script/guide that will help in the orientation and organization of the “project”. This guide has to be extremely detailed, once it is the base for the product’s organization. The planning steps are specific and must be present on the guide. All steps must be present in the Roadmap (before, during and after the creation of the product).",
"stakeholders": "This dimension corresponds to the step of measuring people’s, group’s or company’s interest level on the product. The team must learn/study what can be improved from client’s feedback, thus changing strategies and approaches are part of this dimension. Besides that, in this dimension is necessary to validate the “creation’s” efficiency."}

# Pausa o game e mostra o menu de pausa
func pausar():
	$".".show()
	alreadyPaused = get_tree().paused
	get_tree().paused = true
	GlobalOptions.isPaused = true
	dimensoes = GlobalOptions.dimensoes
	$AnimationPlayer.play("idle")

# Função que sai do menu de pausa e aceita um parametro booleano dizendo se deve remover a pausa ou não
func despausar(removePause:bool = true):
	$".".hide()
	$"Settings".hide()
	
	if removePause:
		get_tree().paused = false
		
	GlobalOptions.isPaused = false
	
	$support.text = ""

# Verifica se a tecla ESC foi precisonada para pausar ou despausar
func _process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		if GlobalOptions.isPaused == true:
			despausar(!alreadyPaused)
		else:
			pausar()

# Instancia todas as dimensões e troca os textos de acordo com a lingua
func _ready():
	for dimensao in dimensoes:
		if !dimensoes[dimensao]:
			get_node(dimensao).hide()
	
	if GlobalOptions.isPortuguese:
		$Label.text = "PAUSADO"
		$Settings/TextureRect/Label.text = 'Configurações'
		$ButtonMenu/Label.text = "Menu Principal"
		$ButtonContinuar/Label.text = "Continuar"
		$ButtonOptions/Label.text = "Configurações"
	else:
		$Label.text = "PAUSED"
		$Settings/TextureRect/Label.text = 'Settings'
		$ButtonMenu/Label.text = "Main Menu"
		$ButtonContinuar/Label.text = "Continue"
		$ButtonOptions/Label.text = "Settings"

# Desapausa o game
func _on_ButtonContinuar_pressed():
	despausar()

# Despausa o game e volta para o menu principal
func _on_ButtonMenu_pressed():
	despausar()
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")

# Mostra o texto de visão
func _on_vision_pressed():
	if GlobalOptions.isPortuguese:
		$support.text = textos["vision"]
	else:
		$support.text = text["vision"]

# Mostra o texto de roadmap
func _on_roadmap_pressed():
	if GlobalOptions.isPortuguese:
		$support.text = textos["roadmap"]
	else:
		$support.text = text["roadmap"]

# Mostra as opções para o usuário
func _on_ButtonOptions_pressed():
	$Settings.show()

# Salva as alterações de som dependendo da fase e volta para o menu de pausa
func _on_Back_pressed():
	$Settings.hide()
	
	
