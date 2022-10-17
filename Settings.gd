extends CanvasLayer

signal back_clicked
signal new_bg
signal easy
signal medium
signal hard


# Called when the node enters the scene tree for the first time.
# Hides all nodes
func _ready():
	$BackButton.hide()
	$ColorPickerButton.hide()
	$BGColor.hide()
	$Easy.hide()
	$Medium.hide()
	$Hard.hide()
	$VolumeText.hide()
	$Volume.hide()
	$VolNum.hide()
	$VolSample.hide()
	$Mute.hide()

# When settings signal is received from main scene
# all the nodes show themselves
func _on_settings():
	$BackButton.show()
	$ColorPickerButton.show()
	$BGColor.show()
	$Easy.show()
	$Medium.show()
	$Hard.show()
	$VolumeText.show()
	$Volume.show()
	$VolNum.show()
	$VolSample.show()
	$Mute.show()

# When the back button is pressed all the nodes hide themselves
# If music is playing it is stopped
# Emits a signal to the main scene
func _on_BackButton_pressed():
	$BackButton.hide()
	$ColorPickerButton.hide()
	$BGColor.hide()
	$Easy.hide()
	$Medium.hide()
	$Hard.hide() 
	$VolumeText.hide()
	$Volume.hide()
	$VolNum.hide()
	$VolSample.hide()
	$Mute.hide()
	$VolSample/SampleMusic.stop()
	emit_signal("back_clicked") 

# When hard mode is enabled makes sure that both options are disabled
func _on_Hard_toggled(_button_pressed):
	if $Easy.pressed == false && $Medium.pressed == false:
		$Hard.pressed = true

	if $Hard.pressed == true:
		$Medium.pressed = false
		$Easy.pressed = false
	
	emit_signal("hard")

# When medium mode is enabled makes sure that both options are disabled
func _on_Medium_toggled(_button_pressed):
	if $Easy.pressed == false && $Hard.pressed == false:
		$Medium.pressed = true

	if $Medium.pressed == true:
		$Hard.pressed = false
		$Easy.pressed = false
	
	emit_signal("medium")

# When easy mode is enabled makes sure that both options are disabled
func _on_Easy_toggled(_button_pressed):
	if $Medium.pressed == false && $Hard.pressed == false:
		$Easy.pressed = true

	if $Easy.pressed == true:
		$Hard.pressed = false
		$Medium.pressed = false
	
	emit_signal("easy")

# When the color picker window is closed it emits a signal to the main scene
func _on_ColorPickerButton_popup_closed():
	emit_signal("new_bg")

# When the voluke slider is changed the display number is changed accordingly
func _on_Volume_value_changed(value):
	$VolNum.text = str(value*100)+"%"

# When the sample music button is pressed it plays a clip of
# a song at the new volume level
func _on_VolSample_pressed():
	$VolSample/SampleMusic.play()
	$VolSample/SampleMusic.volume_db = linear2db($Volume.value)
	$VolSample/Timer.start()

# When the timer is ended the sample music stops
func _on_Timer_timeout():
	$VolSample/SampleMusic.stop()

# mutes audio upon being pressed
func _on_Mute_pressed():
	if $Mute.pressed == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),true)
	elif $Mute.pressed == false:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)
