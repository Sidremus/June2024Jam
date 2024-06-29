extends Node2D
@onready var main_menu = $"Main menu"

var group1_nodes
# Called when the node enters the scene tree for the first time.
func _ready():
	group1_nodes = get_tree().get_nodes_in_group("Walls")
	_hideGroupNodes(group1_nodes)
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _hideGroupNodes (group):
	for member in group:
		member.visible=false

func _revealGroupNodes (group):
	for member in group:
		member.visible=true

func _on_play_button_pressed():
	main_menu.queue_free()
	_revealGroupNodes(group1_nodes)
	pass # Replace with function body.
