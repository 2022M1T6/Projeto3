extends Node

var isPortuguese = true
var masterVolume = 100
var musicVolume = 100
var sfxVolume = 100
var dimensoes = {"vision": true, "roadmap": true}
var isPaused = false

func setSFXSound(a : float):
	var volume = masterVolume * sfxVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB

func setMusicSound(a):
	var volume = masterVolume * musicVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB
