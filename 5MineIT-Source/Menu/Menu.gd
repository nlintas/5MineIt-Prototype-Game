extends Node

# * Attributes *
onready var root = $ItemContainers
onready var shop = get_node("../../CanvasLayer/Menu")
onready var label = get_node("../../CanvasLayer/Money")

# * System Callback Methods *
func _ready():
	for itemName in GlobalVariables.purchases:
		if(GlobalVariables.purchases[itemName] == true):
			if(itemName == "MachineGun" || itemName == "Shotgun" || itemName == "AssaultRifle"):
				root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = "Swap weapon!"
			else:
				root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Button").disabled = true
				root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = "Purchased!"
	for item in GlobalVariables.upgrades:
		if(GlobalVariables.upgrades[item]>=500):
			root.get_node(str(item)+"Node").get_node(str(item)+"Button").disabled = true
			root.get_node(str(item)+"Node").get_node(str(item)+"Label").text = "Maxed!"
		else:
			get_node("ItemContainers/"+item+"Node/"+item+"Label").text = str(GlobalVariables.upgrades[item]*100)

func _process(_delta):
	if Input.is_action_just_pressed("close_shop"):
		$".".hide()

# * Methods *
func _purchase(itemName):
	var price = int(root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text)
	if(GlobalVariables.money >= price):
		GlobalVariables.money = GlobalVariables.money - price
		GlobalVariables.purchases[itemName] = true
		get_node("../MoneyCounter/CounterNumber").text = str(GlobalVariables.money)
		if(itemName == "MachineGun" || itemName == "Shotgun" || itemName == "AssaultRifle"):
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = "Swap weapon!"
		else:
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Button").disabled = true
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = "Purchased!"
	if(price == 0):
		GlobalVariables.currentWeapon = str(itemName)
		if(itemName == "MachineGun"):
			GlobalVariables.active_gun_rate = 20
		elif(itemName == "AssaultRifle"):
			GlobalVariables.active_gun_rate = 15
		elif(itemName == "Shotgun"):
			GlobalVariables.active_gun_rate = 5
			
func _upgrade(itemName):
	label = root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text
	if(GlobalVariables.money >= int(label)):
		GlobalVariables.money = GlobalVariables.money - GlobalVariables.upgrades[itemName]*100
		GlobalVariables.upgrades[itemName] = GlobalVariables.upgrades[itemName] + 1
		if(GlobalVariables.upgrades[itemName]>=5):
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Button").disabled = true
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = "Maxed!"
		else:
			root.get_node(str(itemName)+"Node").get_node(str(itemName)+"Label").text = str(int(label)+100)
		get_node("../MoneyCounter/CounterNumber").text = str(GlobalVariables.money)
