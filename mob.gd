extends RigidBody2D


# Called when the node enters the scene tree for the first time
# Calls a random mob type when spawned
func _ready():
	$AnimatedSprite2D.playing = true
	var mob_types = $AnimatedSprite2D.frames.get_animation_names()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]

# When a mob exits view it disappears from memory
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
