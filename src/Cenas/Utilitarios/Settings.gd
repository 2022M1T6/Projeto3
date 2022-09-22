extends Popup

onready var portugues = GlobalOptions.isPortuguese


func _ready():
	SetLanguage()
	
	$TextureRect/Container/RangeMaster.value = GlobalOptions.masterVolume
	$TextureRect/Container/RangeMusic.value = GlobalOptions.musicVolume
	$TextureRect/Container/RangeSFX.value = GlobalOptions.sfxVolume

func SetLanguage():
	if !portugues:
		$TextureRect/Container/Master.text = "Master Volume"
		$TextureRect/Container/Music.text = "Music Volume"
		$TextureRect/Container/SFX.text = "SFX Volume"
		$TextureRect/Back/Label.text = "Save and Continue"
		
func _process(delta):
	GlobalOptions.masterVolume = $TextureRect/Container/RangeMaster.value
	GlobalOptions.musicVolume = $TextureRect/Container/RangeMusic.value
	GlobalOptions.sfxVolume = $TextureRect/Container/RangeSFX.value


