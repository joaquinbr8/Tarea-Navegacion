extends Node2D

class_name Health

# signals
signal health_depleted
signal health_changed(old_value, new_value)

@export var max_health: int
var health: int

func _ready() -> void:
	health = max_health
	
func take_damage(hit: HitBox):
	print("ouch")
	var old_health = health
	health -= hit.damage
	health_changed.emit(old_health, health)
	if health <= 0:
		health_depleted.emit()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	take_damage(area)
