extends Area2D

@onready var sprite := $MeshInstance2D
@onready var crown := $crown
@onready var is_king := false

var row : int
var col : int

func _ready():
	crown.visible = false
	is_king = true
	
func _process(_delta):
	if is_king:
		crown.visible = true
	
	
func _input_event(_viewport, event, _shape_idx):
	#if event.is_action_pressed("click"):
		#print("%s foi selecionado" % self)
	pass
		
func _mouse_enter():
	sprite.scale *= 1.1
	
func _mouse_exit():
	sprite.scale /= 1.1
