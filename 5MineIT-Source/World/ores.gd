extends TileMap

# * Attributes *
var block = load("res://entities/block.tscn")
var diamond = load("res://Minerals/diamond.tscn")
var bullets = []
var tileHealths ={}

# * Methods *
func replace_tile(tile, bullet, pos):

	if not bullets.has(bullet):
		if not tileHealths.has(tile):
			tileHealths[tile] = 5
		else:
			tileHealths[tile] = tileHealths[tile]-1
		
		bullets.append(bullet)
		
		if(len(bullets) > 100):
			bullets = []
			
		if(tileHealths[tile]<=0):
			set_cellv(tile, -1)
			var dia = diamond.instance()
			dia.position = pos
			GlobalVariables.world.call_deferred("add_child", dia)			
