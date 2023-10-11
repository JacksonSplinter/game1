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
	if $Easy.button_pressed == false && $Medium.pressed == false:
		$Hard.button_pressed = true

	if $Hard.button_pressed == true:
		$Medium.button_pressed = false
		$Easy.button_pressed = false
	
	emit_signal("hard")

# When medium mode is enabled makes sure that both options are disabled
func _on_Medium_toggled(_button_pressed):
	if $Easy.button_pressed == false && $Hard.pressed == false:
		$Medium.button_pressed = true

	if $Medium.button_pressed == true:
		$Hard.button_pressed = false
		$Easy.button_pressed = false
	
	emit_signal("medium")

# When easy mode is enabled makes sure that both options are disabled
func _on_Easy_toggled(_button_pressed):
	if $Medium.button_pressed == false && $Hard.pressed == false:
		$Easy.button_pressed = true

	if $Easy.button_pressed == true:
		$Hard.button_pressed = false
		$Medium.button_pressed = false
	
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
	$VolSample/SampleMusic.volume_db = linear_to_db($Volume.value)
	$VolSample/Timer.start()

# When the timer is ended the sample music stops
func _on_Timer_timeout():
	$VolSample/SampleMusic.stop()

# mutes audio upon being pressed
func _on_Mute_pressed():
	if $Mute.button_pressed == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),true)
	elif $Mute.button_pressed == false:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)

#test
