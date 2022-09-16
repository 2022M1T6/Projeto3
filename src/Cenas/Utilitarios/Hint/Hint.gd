extends TextureRect

# Variável que guarda o texto da hint
var text

# Função que muda a variável de texto
func setText(newText):
	text = str(newText)
	showText()
	
# Função que altera o texto com base na variável texto
func showText():
	$HintText.text = text
	
# Função que mostra a hint e altera o texto dela caso algo for passado por parâmetro
func sendHint(newText = ''):
	if newText:
		setText(newText)
	
	show()

# Função que esconde a hint
func hideHint():
	hide()
	
