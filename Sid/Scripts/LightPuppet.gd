extends RigidBody2D
class_name LightPuppet

var is_selected:bool = false
var is_moving:bool = false
var has_mouse_over_it:bool = false
var target_pos:Vector2
var stopping_distance:float = 15.
var move_force:float = 45.
var player:PlayerController
@onready var selection_highlight: Polygon2D = $PuppetLight/SelectionHighlight
@onready var puppet_light: PointLight2D = $PuppetLight


func _physics_process(delta: float) -> void:
	if global_position.distance_to(target_pos) <= stopping_distance:
		is_moving = false
	if is_moving:
		apply_central_force(global_position.direction_to(target_pos) * move_force)
	
	puppet_light.texture_scale = lerpf(puppet_light.texture_scale, 10., delta) if is_selected else lerpf(puppet_light.texture_scale, 3., delta*.5)

func _ready() -> void:
	target_pos = global_position
	deselect_puppet()
	player = get_tree().get_first_node_in_group("PLAYER")
	puppet_light.texture_scale = 3.

func _on_mouse_entered() -> void:
	has_mouse_over_it = true
	if !is_selected: 
		selection_highlight.show()
		selection_highlight.color = Color.WHITE

func _on_mouse_exited() -> void:
	has_mouse_over_it = false
	if !is_selected: 
		selection_highlight.hide()

func _input(event: InputEvent) -> void:
	if !is_selected:
		if event.is_action_pressed("left_mouse_button") && has_mouse_over_it:
			select_puppet()

func order_movement():
	if is_selected:
		target_pos = get_global_mouse_position()
		is_moving = true

func select_puppet():
	if player.currently_selected_puppet != null: (player.currently_selected_puppet as LightPuppet).deselect_puppet()
	player.currently_selected_puppet = self
	is_selected = true
	selection_highlight.show()
	selection_highlight.color = Color(Color.WHITE, .3)

func deselect_puppet():
	is_selected = false
	selection_highlight.hide()
