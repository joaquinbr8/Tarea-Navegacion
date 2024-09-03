extends Marker2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		position = event.position
