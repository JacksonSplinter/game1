extends CanvasLayer

signal back_clicked
signal new_bg
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
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
	$VolSample/SampleMusic.stop()
	emit_signal("back_clicked") 


func _on_Hard_toggled(button_pressed):
	if $Easy.pressed == false && $Medium.pressed == false:
		$Hard.pressed = true
		
	if $Hard.pressed == true:
		$Medium.pressed = false
		$Easy.pressed = false


func _on_Medium_toggled(button_pressed):
	if $Easy.pressed == false && $Hard.pressed == false:
		$Medium.pressed = true
		
	if $Medium.pressed == true:
		$Hard.pressed = false
		$Easy.pressed = false


func _on_Easy_toggled(button_pressed):
	if $Medium.pressed == false && $Hard.pressed == false:
		$Easy.pressed = true
		
	if $Easy.pressed == true:
		$Hard.pressed = false
		$Medium.pressed = false


func _on_ColorPickerButton_popup_closed():
	emit_signal("new_bg")


func _on_Volume_value_changed(value):
	$VolNum.text = str(value)+"%"


func _on_VolSample_pressed():
	$VolSample/SampleMusic.play()
	$VolSample/SampleMusic.volume_db = 0-(100-$Volume.value)
	$VolSample/Timer.start()


func _on_Timer_timeout():
	$VolSample/SampleMusic.stop()
