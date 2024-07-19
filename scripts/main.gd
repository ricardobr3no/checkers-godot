extends Node2D

@onready var board := $board
@onready var pieces := $board/pieces

var selected_piece = []
var valid_moves = []


func _ready() -> void:
	_reset()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var pos = board.get_row_col_from_mouse_pos()
		var row = pos['row']
		var col = pos['col']
		
		select(row, col)
	
	
func _reset() -> void:
	selected_piece = []
	valid_moves = []
	Global.TurnColor = Color.BLUE
	_set_piece_colors()
	
	print(selected_piece)
	print(valid_moves)


func _set_piece_colors():
	for piece in pieces.get_children():
		if piece.col < 3:
			piece.set_colorPiece(Color.BLUE)
		
		elif piece.col > 4:
			piece.set_colorPiece(Color.RED)


func _move(row, col):
	var place_selected = board.get_piece(row, col)
	
	if selected_piece and not (place_selected is Object) and [row, col] in valid_moves:
		board.mover_pieces(selected_piece[0], row, col)
		selected_piece[0].row = col
		selected_piece[0].col = row
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
			
			change_turn()
			
		
		
	else:
		var piece = board.get_piece(row, col)
		if piece is Object and piece.color == Global.TurnColor:
			selected_piece = [piece]
			valid_moves = board.get_valid_moves(piece)
			
			selected_piece[0].is_selected = true
			print("valid moves: ",valid_moves)
			return true
	
	return false


func change_turn():
	if Global.TurnColor == Color.RED:
		Global.TurnColor = Color.BLUE
		print('turno blue')
	else:
		Global.TurnColor = Color.RED
		print('turno red')
