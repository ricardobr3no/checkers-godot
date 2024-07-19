extends Area2D

const SCALE_SIZE := 1.05

#@onready var board := get_node("/root/main/board")
@onready var sprite := $MeshInstance2D
@onready var crown := $crown

var row : int
var col : int

var color : Color
var is_selected := false
var is_king := false


func _ready() -> void:
	crown.visible = false
	set_colorPiece(Color.GRAY)
	set_colorPiece(Color.BLUE)


func set_colorPiece(colorPiece: Color) -> void:
	sprite.self_modulate = colorPiece
	color = colorPiece

func make_king():
	is_king = true
	if is_king:
		crown.visible = true


func reset_size():
	scale = Vector2(1, 1)

func _mouse_enter() -> void:
	if color == Global.TurnColor:
		sprite.scale *= SCALE_SIZE
	else:
		scale = Vector2(SCALE_SIZE, SCALE_SIZE)
		
func _mouse_exit() -> void:
	if color == Global.TurnColor:
		sprite.scale /= SCALE_SIZE
	else:
		reset_size()
