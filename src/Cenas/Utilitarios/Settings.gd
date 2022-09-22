extends Popup

onready var portugues = GlobalOptions.isPortuguese


func _ready():
	SetLanguage()
	
	$Container/RangeMaster.value = GlobalOptions.masterVolume
	$Container/RangeMusic.value = GlobalOptions.musicVolume
	$Container/RangeSFX.value = GlobalOptions.sfxVolume

func SetLanguage():
	if !portugues:
		$Container/Master.text = "Master Volume"
		$Container/Music.text = "Music Volume"
		$Container/SFX.text = "SFX Volume"
		
func _process(delta):
	GlobalOptions.masterVolume = $Container/RangeMaster.value
	GlobalOptions.musicVolume = $Container/RangeMusic.value
	GlobalOptions.sfxVolume = $Container/RangeSFX.value


