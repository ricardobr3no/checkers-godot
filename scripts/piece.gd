extends Area2D

@onready var tabuleiro = get_node("/root/main/Tab")

@onready var sprite := $MeshInstance2D
@onready var crown := $crown
@onready var is_king := false

var row : int
var col : int

func _ready():
	scale = tabuleiro.scale
	
	crown.visible = false
	is_king = true
	
func _process(_delta):
	if is_king:
		crown.visible = true
	
	
func _input_event(_viewport, _event, _shape_idx):
	pass
		
func _mouse_enter():
	sprite.scale *= 1.1
	
func _mouse_exit():
	sprite.scale /= 1.1
