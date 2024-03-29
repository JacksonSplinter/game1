extends CanvasLayer

signal start_game
signal settings
signal highscore

# a function that takes a text input and displays it and starts a timer
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# game over function
# shows gameover message then waits until timer is over
# in order to display main test again.
# then creates a one second timer, after the timer the menu buttons are diaplyed
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1).timeout
	
	$StartButton.show()
	$SettingsButton.show()
	$Highscore.show()

# function that takes the input of score and displays it
func update_score(score):
	$ScoreLabel.text = str(score)

# when the start button is pressed the menu buttons are hidden
# then the start game signal is emitted to the main scene
func _on_StartButton_pressed():
	$StartButton.hide()
	$SettingsButton.hide()
	$Highscore.hide()
	emit_signal("start_game")

# when the message timer is timedout the message is hidden
func _on_MessageTimer_timeout():
	$Message.hide()

# when the settings button is pressed the HUD is hidden
# then the settings signal is emitted to the main scene
func _on_SettingsButton_pressed():
	$StartButton.hide()
	$SettingsButton.hide()
	$Message.hide()
	$ScoreLabel.hide()
	$Highscore.hide()
	emit_signal("settings")

# When the signal of the back button is received the HUD is displayed again
func _on_Settings_back_clicked():
	$StartButton.show()
	$SettingsButton.show()
	$Message.show()
	$ScoreLabel.show()
	$Highscore.show()

func _on_Scoreboard_pressed():
	$StartButton.hide()
	$SettingsButton.hide()
	$Message.hide()
	$ScoreLabel.hide()
	$Highscore.hide()
	emit_signal("highscore")

func _on_ScoreBoard_menu():
	$StartButton.show()
	$SettingsButton.show()
	$Message.show()
	$ScoreLabel.show()
	$Highscore.show()

func _on_ScoreBoard_replay():
	emit_signal("start_game")
