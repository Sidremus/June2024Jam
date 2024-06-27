extends RigidBody2D
class_name PlayerController

var currently_selected_puppet:RigidBody2D

func _unhandled_input(event: InputEvent) -> void:
	if currently_selected_puppet is LightPuppet:
		if event.is_action_pressed("left_mouse_button"):
			currently_selected_puppet.order_movement()
