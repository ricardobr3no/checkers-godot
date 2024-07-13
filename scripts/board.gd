extends Control

# tamanho para as dimensoes do tabuleiro em px
@export_range(0.2, 1) var TAB_SCALE: float = 1.0

const ROWS := 8
const COLS := 8

@onready var SQUARE_SIZE = get_custom_minimum_size().x / ROWS

var board := []
var red_kings := 0
var blue_kings := 0

@onready var red_piece = preload("res://scenes/red_piece.tscn")
@onready var blue_piece = preload("res://scenes/blue_piece.tscn")

var selected_piece  # pode receber Object ou Int



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(TAB_SCALE, TAB_SCALE)
	draw_pieces()
	
	var piece = get_piece(5, 0)
	mover_pieces(piece, 3, 2)

	
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
	

func instaciar_piece(piece: Object, row: int, col: int) -> Object:
	var new_piece = piece.instantiate()
	new_piece.row = row
	new_piece.col = col
	
	$pieces.add_child(new_piece)
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
	
	
func get_valid_moves(piece):
	var valid_moves = []
	
	var left = piece.row - 1
	var right = piece.row + 1
	var row = piece.col
	var step = +1 if piece.color == 'blue' else -1
	
	# algoritmo para pulo simples
	if left >= 0:
		if not (board[row + step][left] is Object):
			valid_moves.append([row + step, left])
	if right <= 7:
		if not (board[row + step][right] is Object):
			valid_moves.append(([row + step, right]))
	
	""""
	falta implementar algoritmo para pular matando ...
	codigo aqui
	"""
	
	return valid_moves
	


func get_piece(row, col):
	# return the contein of board[row][col]
	return board[row][col]


func get_row_col_from_mouse_pos() -> Dictionary:
	var pos = get_global_mouse_position()
	var col = int(pos.x / SQUARE_SIZE)
	var row = int(pos.y / SQUARE_SIZE)
	return {'row': row, 'col': col}


func mover_pieces(piece, col, row):
	
	# ta aqui o motivo de row e col ta trocado
	if not (piece is Object):
		return
	

	# troca as os elementos da matrix tabulerio de lugar
	var aux = board[col][row]
	board[col][row] = piece
	board[piece.col][piece.row] = aux 
	
	# update row col
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
