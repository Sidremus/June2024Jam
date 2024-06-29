@tool
extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		var coll := CollisionPolygon2D.new()
		coll.polygon = $Polygon2D.polygon
		add_child(coll)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
