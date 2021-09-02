extends MarginContainer

# * Attributes *
const world_scene = preload("res://World/World.tscn")
const credits_scene = preload("res://TitleScreen/Credits.tscn")
var options_scene = load("res://Options/Options.tscn")

onready var new_game_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var options_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var credits_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var quit_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector
var current_selection = 0

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
	
func _process(_delta):
	if Input.is_action_just_pressed("down") and current_selection < 3:
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/navigating_selector.ogg')
		buttonAudioPlayer.play()
		
		current_selection += 1
		set_current_selector(current_selection)
		
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/navigating_selector.ogg')
		buttonAudioPlayer.play()
		
		current_selection -= 1
		set_current_selector(current_selection)
		
	elif Input.is_action_just_pressed("ui_accept"):
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
		buttonAudioPlayer.play()
		
		handle_selection(current_selection)

# * Methods *
func set_current_selector(_current_selection):
	new_game_selector.text=""
	options_selector.text=""
	credits_selector.text=""
	quit_selector.text=""
	
	if _current_selection == 0:
		new_game_selector.text=">"
	elif _current_selection == 1:
		options_selector.text =">"
	elif _current_selection == 2:
		credits_selector.text = ">"
	elif _current_selection == 3:
		quit_selector.text=">"
		
func handle_selection(_current_selection):
	
	if _current_selection == 0:
		get_parent().add_child(world_scene.instance())
		queue_free()
	elif _current_selection == 1:
		get_parent().add_child(options_scene.instance())
		queue_free()
	elif _current_selection == 2:
		get_parent().add_child(credits_scene.instance())
		queue_free()
	elif _current_selection == 3:
		get_tree().quit()

func _on_NewGameButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
		
	current_selection = 0
	switchScenes()

func _on_OptionsButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 1
	switchScenes()

func _on_CreditsButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 2
	switchScenes()

func _on_QuitButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 3
	switchScenes()
	
func switchScenes():
	set_current_selector(current_selection)
	handle_selection(current_selection)
	
