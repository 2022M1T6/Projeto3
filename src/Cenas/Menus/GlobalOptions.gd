extends Node

var isPortuguese = true
var masterVolume = 100
var musicVolume = 100
var sfxVolume = 100


func setSFXSound(a):
	var volume = masterVolume * sfxVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB

func setMusicSound(a):
	var volume = masterVolume * musicVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB
