extends Node

# * Attributes *
onready var ingame_scene = load("res://InGame-Menu/InGameMenu.tscn")
onready var shop_scene = load("res://Menu/Menu.tscn")
var inShop = false;

# * System Callback Methods *
func _ready():
	$CanvasLayer/Menu.hide();
	GlobalVariables.world = self
	
func _process(_delta):
	if Input.is_action_just_pressed("shop") && GlobalVariables.inShop:
		$CanvasLayer/Menu.show();

	if Input.is_action_just_pressed("exit"):
		self.get_node("CanvasLayer").get_node("Timer").pause_timer()
		self.get_node("CanvasLayer").add_child(ingame_scene.instance())

# * Methods *
func start_timer():
	self.get_node("CanvasLayer").get_node("Timer").start_timer()

func place_player(player_node):
	if(self.has_node("Player")):
		self.get_node("Player").queue_free()
	self.add_child(player_node.duplicate())

func _on_Area2D_body_entered(_body: Node) -> void:
	self.get_node("CanvasLayer").get_node("Timer").start_timer()
