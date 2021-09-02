extends MarginContainer

# * Attributes *
var world_scene = load("res://World/World.tscn")
var player_node = GlobalVariables.player_node.duplicate()
onready var continue_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
var current_selection = 0

onready var emeraldsLabel = $CenterContainer/VBoxContainer/CenterContainer4/HBoxContainer/EmeraldLabel
onready var diamondsLabel = $CenterContainer/VBoxContainer/CenterContainer3/HBoxContainer/DiamondLabel
onready var rubysLabel = $CenterContainer/VBoxContainer/CenterContainer5/HBoxContainer/RubyLabel
onready var amethystsLabel = $CenterContainer/VBoxContainer/CenterContainer6/HBoxContainer/AmethystsLabel
onready var sapphiresLabel = $CenterContainer/VBoxContainer/CenterContainer7/HBoxContainer/SapphiresLabel

# Audio
var audioPlayer = AudioStreamPlayer.new()
var buttonAudioPlayer = AudioStreamPlayer.new()

# * System Callback Methods *
func _ready():
	set_current_selector(0)
	self.add_child(audioPlayer)
	self.add_child(buttonAudioPlayer)
	# Background Music
	audioPlayer.stream = load ('res://Music and Sounds/Background Music/02 Space Riddle.ogg')
	audioPlayer.play()
	emeraldsLabel.text = "Emaralds: " + str(GlobalVariables.emeralds)
	diamondsLabel.text = "Diamonds: " + str(GlobalVariables.diamonds)
	rubysLabel.text = "Rubys: " + str(GlobalVariables.rubys)
	amethystsLabel.text = "Amethysts: " + str(GlobalVariables.amethysts)
	sapphiresLabel.text = "Sapphires: " + str(GlobalVariables.sapphires)
	
	GlobalVariables.emeralds = 0
	GlobalVariables.diamonds = 0
	GlobalVariables.rubys = 0
	GlobalVariables.amethysts = 0
	GlobalVariables.sapphires = 0
	
func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
		buttonAudioPlayer.play()
		handle_selection(current_selection)

# * Methods *
func set_current_selector(_current_selection):
	continue_selector.text=""
	
	if _current_selection == 0:
		continue_selector.text=">"
		
func handle_selection(_current_selection):
	
	if _current_selection == 0:
		resetWorld()

func _on_BackButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 1
	switchScenes()
	
func resetWorld():
	var world_node = world_scene.instance()
	get_tree().get_root().call_deferred("add_child",world_node)
	GlobalVariables.world = world_node
	world_node.place_player(player_node)
	self.queue_free()
	
func switchScenes():
	set_current_selector(current_selection)
	handle_selection(current_selection)

func _on_ContinueButton_pressed():
	resetWorld()
