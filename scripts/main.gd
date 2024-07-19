extends Node2D

@onready var board := $board
@onready var pieces := $board/pieces

var selected_piece = []
var valid_moves = []


func _ready() -> void:
	_reset()
	print(get_all_kill_moves())
	
	
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


func get_all_kill_moves() -> Array:
	var all_kill_moves := []
	
	for piece in pieces.get_children():
		if piece.color == Global.TurnColor:
			# logica
			var moves = board.get_valid_moves(piece)
			if moves.kill:
				all_kill_moves.append(moves.kill[0])
	
	if not all_kill_moves:
		return []
	
	return all_kill_moves
	
	
	


func _move(row, col):
	var place_selected = board.get_piece(row, col)
	
	if get_all_kill_moves():
		# se tiver alguma piece com pulo disponivel		
		if selected_piece and not (place_selected is Object) and [row, col] in valid_moves and [row, col] in get_all_kill_moves():
			board.mover_pieces(selected_piece[0], row, col)
			selected_piece[0].row = col
			selected_piece[0].col = row
			# moveu e atualizou
		else:
			return false
		
		return true
	
	else:
		if selected_piece and not (place_selected is Object) and [row, col] in valid_moves:
			board.mover_pieces(selected_piece[0], row, col)
			selected_piece[0].row = col
			selected_piece[0].col = row
			# moveu e atualizou
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
			
			var moves = board.get_valid_moves(piece) # retorna dictonary
			valid_moves = moves.kill if moves.kill else moves.simple
			
			selected_piece[0].is_selected = true
			return true
	
	return false


func change_turn():
	if Global.TurnColor == Color.RED:
		Global.TurnColor = Color.BLUE
		print('turno blue')
	else:
		Global.TurnColor = Color.RED
		print('turno red')
