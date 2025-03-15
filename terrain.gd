@tool
extends TileMap

@export var generateTerrain: bool
@export var clearTerrain: bool

@export var mapWidth: int
@export var mapHeight: int

@export var grassThresold : float
@export var dirtThresold : float
@export var rockThresold : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if generateTerrain:
		generateTerrain = false
		GenerateTerrain()
		
	if clearTerrain:
		clearTerrain = false
		clear()

func GenerateTerrain():
	print("generation du terrain...")
	
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	noise.seed = rng.randf_range(0,999999)
	
	for x in range(mapWidth):
		for y in range(mapHeight):
			if noise.get_noise_2d(x, y) < grassThresold:
				set_cell(0, Vector2i(x, y), 0, Vector2i(1,0))
			elif noise.get_noise_2d(x, y) < dirtThresold:
				set_cell(0, Vector2i(x, y), 0, Vector2i(0,0))
			elif noise.get_noise_2d(x, y) < rockThresold:
				set_cell(0, Vector2i(x, y), 0, Vector2i(2,0))
			else:
				set_cell(0, Vector2i(x,y), 0, Vector2i(0,0))
