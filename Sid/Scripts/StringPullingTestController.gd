extends RigidBody2D

var force:float = 10000.

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("left_mouse_button"):
		var pushvec := global_position.direction_to(get_global_mouse_position())
		apply_central_force(pushvec * force)
