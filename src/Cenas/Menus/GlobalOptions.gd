extends Node

# Lingua
var isPortuguese = false

# Volume
var masterVolume = 100
var musicVolume = 100
var sfxVolume = 100

# Progresso
var dimensoes = {"vision": true, "roadmap": true}

# Esta pausado
var isPaused = false

# Numero da fase
var fase = 0.1

# Altera o volume SFX
func setSFXSound(a):
	var volume = masterVolume * sfxVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB

# Seta o volume da musica
func setMusicSound(a):
	var volume = masterVolume * musicVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB
