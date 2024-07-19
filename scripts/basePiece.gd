extends Area2D

#@onready var board := get_node("/root/main/board")
@onready var sprite := $MeshInstance2D
@onready var crown := $crown

var row : int
var col : int

var color : Color

var is_king := false

func _ready() -> void:
	crown.visible = false
	set_colorPiece(Color.GRAY)

func set_colorPiece(colorPiece: Color) -> void:
	sprite.modulate = colorPiece
	color = colorPiece

func make_king():
	is_king = true
	if is_king:
		crown.visible = true
