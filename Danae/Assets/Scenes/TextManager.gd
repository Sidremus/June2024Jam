extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("init")
	_textAnimation()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _fadeTextIn():
	$AnimationPlayer.play("fade_to_normal")
	
func _textAnimation():
	await get_tree().create_timer(2.).timeout
	_fadeTextIn()
