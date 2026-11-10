extends Node2D

@export var cell_size: int = 32
@export var grid_width: int = 1200
@export var grid_height: int = 320

@export var grave_scene: PackedScene

var available_cells: Array[Vector2i] = []
var occupied_cells: Array[Vector2i] = []

func _ready():
	for x in range(grid_width):
		for y in range(grid_height):
			available_cells.append(Vector2i(x, y))

func spawn_grave():
	if available_cells.is_empty():
		print("Graveyard is full")
		return
	
	var index = randi_range(0, available_cells.size() - 1)
	var cell = available_cells[index]
	
	available_cells.remove_at(index)
	occupied_cells.append(cell)
	
	var grave = grave_scene.instantiate()
	add_child(grave)
	
	grave.position = Vector2(
		cell.x * cell_size,
		cell.y * cell_size
		)
	
