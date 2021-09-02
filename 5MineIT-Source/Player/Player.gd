extends KinematicBody2D

# * Attributes *
var c4 = preload("res://C4/C4.tscn")

# Audio
var audioPlayer = AudioStreamPlayer.new()

const audio1 = "Billy Sacrifice"
const audio2 = "Parabola"
const audio3 = "Race to Mars"
const audio4 = "Far Away"
const audio5 = "City Stomper"
const audio6 = "Pink Blue loop Loop"

var drillUsed = false;
const tracks = [audio1, audio2, audio3, audio4, audio5, audio6]

# Weapon configuration variables

var has_equipped_weapon = false

export var has_c4 = true
export var c4_number_of_extra_shots = 1
export var c4_shot_delay = 0.01

var jetPackSprite = preload("res://Assets/jetpack.png")
var avatarSprite = preload("res://Player/Player.png")
var shopMenu = preload("res://Menu/Menu.tscn")
export var move_speed := 215
export var jump_force := 500
export var gravity := 900
export var hasJetPack := true
export var hasDoubleBoots := true
export var numberOfJumps := 0
export var maxJumps := 1
# The variable below is user assist for corner climbs.
export var slope_slide_threshold := 50.0
# Item Holder and Consumables
export var bombs := 10
var itemEquipped := 'drill'
var angles = [-PI/6,-PI/12, -PI/9, -PI/24,PI/24, PI/9 ,PI/6,PI/12]

onready var bombCounter = get_node("../CanvasLayer/BombCounter")

var velocity := Vector2()

var bomb = preload("res://entities/bomb.tscn")

var cooldown = false

# * System Callback Methods *
func _ready():
	move_speed = 300
	# Audio Below
	randomize()
	var rand_number = randi() % tracks.size()-1
	self.add_child(audioPlayer)
	audioPlayer.stream = load ('res://Music and Sounds/Background Music/' + tracks[rand_number] + '.ogg')
	audioPlayer.play()

func _physics_process(delta):
	on_move(delta)
	#use_bombs()
	use_item(itemEquipped)
	
func _process(_delta):
	if not cooldown and Input.is_action_pressed("click"):
		$shoot_cooldown.start()
		var waitTime:float = GlobalVariables.upgrades["Gun"] * GlobalVariables.active_gun_rate
		$shoot_cooldown.set_wait_time(1/waitTime)
		cooldown = true;
		if GlobalVariables.currentWeapon == "Gun" || GlobalVariables.currentWeapon == "AssaultRifle":
			var bang = bomb.instance()
			bang.position = $fire_position.global_position
			bang.linear_velocity = get_local_mouse_position().normalized() * 400
			GlobalVariables.world.add_child(bang)
		elif GlobalVariables.currentWeapon == "Shotgun":
			var bang = bomb.instance()
			bang.position = $fire_position.global_position
			bang.linear_velocity = get_local_mouse_position().normalized() * 400
			GlobalVariables.world.add_child(bang)
			
			var bang2 = bomb.instance()
			bang2.position = $fire_position.global_position
			bang2.linear_velocity = (get_local_mouse_position().normalized().rotated(PI/12)).normalized()*400
			GlobalVariables.world.add_child(bang2)
			
			var bang3 = bomb.instance()
			bang3.position = $fire_position.global_position
			bang3.linear_velocity = (get_local_mouse_position().normalized().rotated(-PI/12)).normalized()*400
			GlobalVariables.world.add_child(bang3)
		elif GlobalVariables.currentWeapon == "MachineGun":
			var bang = bomb.instance()
			bang.position = $fire_position.global_position
			var angle = angles[randi()%8]
			bang.linear_velocity = get_local_mouse_position().normalized().rotated(angle) * 400
			GlobalVariables.world.add_child(bang)

# * Custom Methods *
func _on_between_shoot_cooldown_timeout():
	var temp_node = bomb.instance()
	temp_node.position = $fire_position.global_position
	temp_node.linear_velocity = Vector2(0,1) * 400
	temp_node.visible = false

	GlobalVariables.world.add_child(temp_node)

	if $between_shoot_cooldown.number_of_shots > 0:
		$between_shoot_cooldown.number_of_shots -= 1
		$between_shoot_cooldown.start()
	else:
		$between_shoot_cooldown.stop()

# Private walk function, left to right only; sidescroller optimised.
func _on_walk():
	var direction_x := Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction_x * move_speed
	
# Private jump function, takes delta from system callback for system lag control.
func _on_jump(delta):
	# Check if the jump button is pressed and if the function is instantiated when the character is on collidable ground.
	
	if Input.is_action_just_pressed("jump") and GlobalVariables.purchases["SpecialBoots"] and numberOfJumps < maxJumps:
		numberOfJumps += 1
		velocity.y = -jump_force
	elif Input.is_action_pressed("jetpack") and GlobalVariables.purchases["Jetpack"]:
		#$Sprite.set_texture(jetPackSprite)
		velocity.y -= lerp(velocity.y, 200, 0.5)
	elif Input.is_action_just_pressed("jump") and is_on_floor() and not GlobalVariables.purchases["SpecialBoots"]:
		velocity.y = -jump_force
		
	if is_on_floor():
		numberOfJumps = 0
		
	velocity.y += gravity * delta
	
	if is_on_floor():
		$Sprite.set_texture(avatarSprite)

# The character movement system, all method related with character movement should run and be contained here.
func on_move(delta):
	_on_walk()
	_on_jump(delta)
	var msModifier = 1+(0.2*GlobalVariables.upgrades["Boots"])
	move_speed = 250*msModifier
	velocity = move_and_slide(velocity, Vector2.UP, slope_slide_threshold, 4, deg2rad(46), false)
	if is_on_floor() and (Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left")):
		velocity.y = 0

#these methods seem redundant for now but every gem will have different values, if you can optimize it do it
func add_emerald():
	GlobalVariables.emeralds += 1
	GlobalVariables.money +=750
	
	GlobalVariables.world.get_node("CanvasLayer").get_node("MoneyCounter").get_node("CounterNumber").text = str(GlobalVariables.money)
	
func add_diamond():
	GlobalVariables.diamonds += 1
	GlobalVariables.money  += 1000
	GlobalVariables.world.get_node("CanvasLayer").get_node("MoneyCounter").get_node("CounterNumber").text = str(GlobalVariables.money)
	
func add_ruby():
	GlobalVariables.rubys += 1
	GlobalVariables.money  += 600
	GlobalVariables.world.get_node("CanvasLayer").get_node("MoneyCounter").get_node("CounterNumber").text = str(GlobalVariables.money)
	
func add_sapphire():
	GlobalVariables.sapphires += 1
	GlobalVariables.money  += 400
	GlobalVariables.world.get_node("CanvasLayer").get_node("MoneyCounter").get_node("CounterNumber").text = str(GlobalVariables.money)
	
func add_amethyst():
	GlobalVariables.amethysts += 1
	GlobalVariables.money  += 300
	GlobalVariables.world.get_node("CanvasLayer").get_node("MoneyCounter").get_node("CounterNumber").text = str(GlobalVariables.money)

# Uses consumable bombs.
func use_bombs():
	if Input.is_action_just_pressed("bomb") and bombs >= 1:
		bombs -= 1
		bombCounter.updateCounter(bombs)
		
# Uses active item.
func use_item(_item):
	if Input.is_action_just_pressed("active-item") && GlobalVariables.purchases["Drill"] && not drillUsed:
		var bang = bomb.instance()
		bang.position = $fire_position.global_position
		bang.linear_velocity = get_local_mouse_position().normalized() * 400
		GlobalVariables.world.add_child(bang)
		
		$between_shoot_cooldown.bang = bang.duplicate()
		$between_shoot_cooldown.number_of_shots = 1000
		$between_shoot_cooldown.wait_time = c4_shot_delay
		$between_shoot_cooldown.bang.position = $fire_position.global_position
		$between_shoot_cooldown.bang.linear_velocity = Vector2(0,1) * 2000
		$between_shoot_cooldown.start()
		
		GlobalVariables.world.add_child($between_shoot_cooldown.bang)
		drillUsed = true;		

func _on_Timer2_timeout() -> void:
	cooldown = false

func _on_shoot_cooldown_timeout():
	cooldown = false
