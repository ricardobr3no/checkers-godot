extends Control

# tamanho para as dimensoes do tabuleiro em px
@export_range(0.2, 1) var TAB_SCALE: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(TAB_SCALE, TAB_SCALE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
