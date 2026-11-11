extends Node2D

@export var cell_size: int = 32
@export var grid_width: int = 1200
@export var grid_height: int = 300
@export var grave_scene: PackedScene

const SECTION_WIDTH = 3
const SECTION_HEIGHT = 2
const SECTION_GAP = 1

var sections = []
var occupied_cells = []

var current_section = 0

func _ready():
	randomize()
	
	create_sections()

func create_sections():
	var columns = grid_width / cell_size
	var rows = grid_height / cell_size
	
	var step_x = SECTION_WIDTH + SECTION_GAP
	var step_y = SECTION_HEIGHT + SECTION_GAP
	
	for sy in range(0, rows - SECTION_HEIGHT + 1, step_y):
		for sx in range(0, columns - SECTION_WIDTH + 1, step_x):
			
			var section = []
			
			for y in range(SECTION_HEIGHT):
				for x in range(SECTION_WIDTH):
					
					var cell = Vector2i(sx + x, sy + y)
					
					section.append(cell)
			
			sections.append(section)
	
func spawn_grave():
	if grave_scene == null:
		return
	
	while current_section < sections.size():
		var section = sections[current_section]
		var available = []
		
		for cell in section:
			if not occupied_cells.has(cell):
				available.append(cell)
		
		if available.is_empty():
			current_section += 1
			continue
		
		var cell = available.pick_random()
		
		occupied_cells.append(cell)
		
		var grave = grave_scene.instantiate()
		add_child(grave)
		
		grave.position = Vector2(
			cell.x * cell_size,
			cell.y * cell_size
		)
		return
