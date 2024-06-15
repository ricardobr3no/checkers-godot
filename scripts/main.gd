extends Node2D

const ROWS := 8
const COLS := 8
const SQUARE_SIZE := 100

var board := []
var red_kings := 8
var blue_kings := 8

@onready var red_piece = preload("res://scenes/red_piece.tscn")
@onready var blue_piece = preload("res://scenes/blue_piece.tscn")


func _ready() -> void:
	draw_pieces()
	
	var p = get_piece(5, 0) # piece escolhida
	mover_pieces(p, 4, 1)
	
	

func _input(event):
	if event.is_action_pressed("click"):
		mover_piece_with_mouse()


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
				

# MOVER PIECES

func get_piece(row, col):
	return board[row][col]


func get_row_col_from_mouse_pos():
	var pos = get_global_mouse_position()
	var col = int(pos.x / SQUARE_SIZE)
	var row = int(pos.y / SQUARE_SIZE)
	return [row, col]


func mover_piece_with_mouse():
	var pos = get_row_col_from_mouse_pos()
	var row = pos[0]
	var col = pos[1]
	
	var selected_piece = get_piece(row, col)
	
	print("selected piece: {} (row: {}, col: {})".format([selected_piece, row, col], "{}"))
	
	var aux = board[selected_piece.row][selected_piece.col]  # variavel para auxiliar na troca
	board[selected_piece.row][selected_piece.col] = board[row][col]
	board[row][col] = aux
	
	# mover piece atualizando o position 
	selected_piece.position =  Vector2(row*SQUARE_SIZE + SQUARE_SIZE / 2, col*SQUARE_SIZE + SQUARE_SIZE / 2)



func mover_pieces(piece, col, row):
	# nao funcionando, nao sao sei pq
	var aux = board[piece.row][piece.col]  # variavel para auxiliar na troca
	board[piece.row][piece.col] = board[row][col]
	board[row][col] = aux
	
	# mover piece atualizando o position 
	piece.position =  Vector2(row*SQUARE_SIZE + SQUARE_SIZE / 2, col*SQUARE_SIZE + SQUARE_SIZE / 2)
	
	# condição para promoção da piece
	if row == ROWS or row == 0:
		piece.is_king = true
		
		if piece.is_in_group("red_pieces"):
			red_kings += 1
		else:
			blue_kings += 1

