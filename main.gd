extends Node
export(PackedScene) var mob_scene
var score # user score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# When a game over is triggered the timer is stopped, mons stop spawning
# the hud displays the game over message the music stops and the death sound plays
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

# When a new game is triggered the score is set to zero and then
# the player is moved to the starting postions and the timer is started
# The score gets updated and a starting message is diplayed
# the music is set to the volume chosen in the setting menu
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Fucking Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	$Music.volume_db = linear2db($Settings/Volume.value)

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

# when the scoretimer is timedout the player gets one point and then
# the score is upadted in the HUD
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

# When the start timer ends the mobs begin to spawn and the player
# can start earning score
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

# If the player chooses a new bakcgorund color in settings it is changed
func _on_Settings_new_bg():
	$ColorRect.color = $Settings/ColorPickerButton.color

func _on_Settings_easy():
	$MobTimer.wait_time = 1

func _on_Settings_hard():
	$MobTimer.wait_time = .25

func _on_Settings_medium():
	$MobTimer.wait_time = .5
