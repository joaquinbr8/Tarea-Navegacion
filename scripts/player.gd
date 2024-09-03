extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

var input_vector: Vector2
var egg_scene: PackedScene

func _ready() -> void:
	# Precargar la escena del huevo
	egg_scene = preload("res://scenes/egg.tscn") # Asegúrate de que la ruta es correcta

func set_blend_position(vector: Vector2) -> void:
	anim_tree.set("parameters/Idle/blend_position", vector)
	anim_tree.set("parameters/Run/blend_position", vector)
	anim_tree.set("parameters/Axe/blend_position", vector)
	anim_tree.set("parameters/Pick/blend_position", vector)

func _on_player_control_do_move(incoming_input_vector: Vector2) -> void:
	input_vector = incoming_input_vector
	set_blend_position(input_vector)
	state_machine.travel("Run")

func _on_player_control_do_attack() -> void:
	print(input_vector)
	set_blend_position(input_vector)
	state_machine.travel("Axe")

func _on_player_control_do_put_egg() -> void:
	# Instanciar la escena del huevo
	var egg_instance = egg_scene.instantiate()
	egg_instance.position = global_position + input_vector * 16 # Ajuste para poner el huevo justo enfrente del personaje
	get_parent().add_child(egg_instance)
