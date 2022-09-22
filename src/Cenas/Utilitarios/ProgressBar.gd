extends ProgressBar

var transition = 0
# Função executada quando a barra de progresso está carregada
func _ready():
	var progress = 0
	
	# Preenche a barra de progresso com um ponto a cada 0,01s
	while progress < 100:
		progress += 2
		get_node(".").value = progress
		yield(get_tree().create_timer(0.005), "timeout")
	
	# Redireciona para a tela principal
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa1/Calabouco.tscn")

	
