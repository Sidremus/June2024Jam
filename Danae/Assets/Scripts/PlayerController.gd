extends Node
var isGrounded: bool = true
signal hurt
@onready var jump_sfx = $"../AudioManager/JumpSFX"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_just_pressed("jump") and isGrounded:
		#print("jumping")
		#jump_sfx.play()
		#emit_signal("hurt")
		#isGrounded=false
		#await get_tree().create_timer(2.).timeout
		#isGrounded=true
	
