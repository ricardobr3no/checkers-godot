extends Node2D

const ROWS := 8
const COLS := 8

@onready var SQUARE_SIZE = $Tab.get_custom_minimum_size().x / ROWS

var board := []
var red_kings := 0
var blue_kings := 0

@onready var red_piece = preload("res://scenes/red_piece.tscn")
@onready var blue_piece = preload("res://scenes/blue_piece.tscn")


func _ready() -> void:
	draw_pieces()
	
	var p = get_piece(5, 0) # piece escolhida
	mover_pieces(p, 4, 1)
	
	
func _input(event):
	if event.is_action_pressed("click"):
		var row = get_row_col_from_mouse_pos()['row']
		var col = get_row_col_from_mouse_pos()['col']
		print('selecionou {}'.format([get_piece(row, col)], "{}"))
		print("row: {}  col: {}".format([row, col], "{}"))
		# mover_piece_with_mouse()


func create_board():
	# create board
	for row in range(ROWS):
		board.append([])
		for col in range(COLS):
			# se tiver nas primeiras rows, colocar as peças brancas
			if row < 3:
				if col % 2 == (row + 1) % 2:
					board[row].append(1) # time 1
				else:
					board[row].append(0)
			# se tiver nas primeiras rows, colocar as peças vermelhas
			elif row > 4:
				if col % 2 == (row + 1) % 2:
					board[row].append(2) # time 2
				else:
					board[row].append(0)
			# se tiver nas linhas do meio, colocar ZEROS simplesmente
			else:
				board[row].append(0)
		
	# imprimir representenção do tabuleiro
	print("\nTabuleiro criado:")
	for row in range(ROWS):
			print(board[row])
	

func instaciar_piece(piece: Object, row: int, col: int) -> Object:
	var new_piece = piece.instantiate()
	new_piece.row = row
	new_piece.col = col
	
	$Tab/pieces.add_child(new_piece)
	new_piece.position = Vector2(row*SQUARE_SIZE + SQUARE_SIZE / 2, col*SQUARE_SIZE + SQUARE_SIZE / 2)
	return new_piece


func draw_pieces():
	create_board()
	for row in range(ROWS):
		for col in range(COLS):
			# instanciar peça
			if board[row][col] == 1:
				board[row][col] = instaciar_piece(blue_piece, col, row)
			
			elif board[row][col] == 2:
				board[row][col] = instaciar_piece(red_piece, col, row)
	
	



func get_piece(row, col):
	return board[row][col]


func get_row_col_from_mouse_pos():
	var pos = get_global_mouse_position()
	var col = int(pos.x / SQUARE_SIZE)
	var row = int(pos.y / SQUARE_SIZE)
	return {'row': row, 'col': col}


func mover_piece_with_mouse():
	pass



func mover_pieces(piece, col, row):
	# nao funcionando, nao sao sei pq
	var aux = board[col][row]
	board[col][row] = piece
	board[piece.col][piece.row] = aux 
	
	piece.row = col
	piece.col = row
	
	# mover piece atualizando o position 
	piece.position =  Vector2(row*SQUARE_SIZE + SQUARE_SIZE / 2, col*SQUARE_SIZE + SQUARE_SIZE / 2)
	
	# condição para promoção da piece
	if row == ROWS or row == 0:
		piece.is_king = true
		
		if piece.is_in_group("red_pieces"):
			red_kings += 1
		else:
			blue_kings += 1

	
