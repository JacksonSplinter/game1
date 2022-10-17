extends CanvasLayer

signal menu
signal replay

# Called when the node enters the scene tree for the first time.
func _ready():
	$Header.hide()
	$Label.hide()
	$Menu.hide()
	$PlayAgain.hide()
	

func _on_Menu_pressed():
	$Header.hide()
	$Label.hide()
	$Menu.hide()
	$PlayAgain.hide()
	emit_signal("menu")

func _on_PlayAgain_pressed():
	$Header.hide()
	$Label.hide()
	$Menu.hide()
	$PlayAgain.hide()
	emit_signal("replay")

func _on_HUD_highscore():
	$Header.show()
	$Label.show()
	$Menu.show()
	$PlayAgain.show() 
