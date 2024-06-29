extends Control
signal startGame
signal quitGame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	emit_signal("startGame")
	await get_tree().create_timer(4.0).timeout
	#get_tree().change_scene_to_file("res://Danae/Assets/Scenes/blockout_v1.0.tscn")
	pass
	


func _on_quit_button_pressed():
	emit_signal("quitGame")
	get_tree().quit()
