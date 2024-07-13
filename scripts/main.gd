extends Node2D

@onready var tabuleiro := $board
@onready var pieces := $board/pieces

var selected_piece = []
var valid_moves = []
var turn_color = "blue"


func _ready() -> void:
	_reset()
	
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var pos = tabuleiro.get_row_col_from_mouse_pos()
		var row = pos['row']
		var col = pos['col']
		
		select(row, col)
	
	
func _reset() -> void:
	selected_piece = []
	valid_moves = []
	turn_color = "blue"
	print("turno %s" % turn_color)
	
	print(selected_piece)
	print(valid_moves)


func _move(row, col):
	var place_selected = tabuleiro.get_piece(row, col)
	
	if selected_piece and not (place_selected is Object) and [row, col] in valid_moves:
		tabuleiro.mover_pieces(selected_piece[0], row, col)
		selected_piece[0].row = col
		selected_piece[0].col = row
		
		#print("moveu a peca de (row:{}, col:{}) para (row:{}, col:{})".format([row-1, col+1, selected_piece[0].row, selected_piece[0].col], "{}"))
	else:
		return false
	
	return true


func select(row, col):
	if selected_piece:
		var result = _move(row, col)
		if not result:
			selected_piece = []
			select(row, col)
	else:
		var piece = tabuleiro.get_piece(row, col)
		if piece is Object and piece.color == turn_color:
			selected_piece = [piece]
			valid_moves = tabuleiro.get_valid_moves(piece)
			
			print(selected_piece)
			print(valid_moves)
			return true
	
	return false


func change_turn():
	if turn_color == 'red':
		turn_color = 'blue'
		print('turno blue')
	else:
		turn_color = 'red'
		print('turno red')
