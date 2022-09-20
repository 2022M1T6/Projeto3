extends Node

var isPortuguese = true
var masterVolume = 100
var musicVolume = 100
var sfxVolume = 100


func setSFXSound(a):
	var b = 80 + a
	b = b * masterVolume * sfxVolume / 10000
	a = b - 80
	return a

func setMusicSound(a):
	var b = 80 + a
	b = b * masterVolume * musicVolume / 10000
	a = b - 80
	return a
