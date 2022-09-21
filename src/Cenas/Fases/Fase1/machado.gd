extends ColorRect

# Função que seta todas as partes do machado
func setSprites(caboPath, laminaPath, cabecotePath):
	setCaboSprite(caboPath)
	setLaminaSprite(laminaPath)
	setCabecoteSprite(cabecotePath)

# Função que seta o cabo da sprite
func setCaboSprite(caboPath):
	if caboPath:
		$Cabo.texture = load(caboPath)

# Função que seta a sprite lamina
func setLaminaSprite(laminaPath):
	if laminaPath:
		$Lamina.texture = load(laminaPath)

# Função que seta a sprite do cabecote
func setCabecoteSprite(cabecotePath):
	if cabecotePath:
		$Cabecote.texture = load(cabecotePath)
