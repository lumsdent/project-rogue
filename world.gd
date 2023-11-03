extends Node2D


@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)


func toggle_inventory_interface(_external_inventory_owner = null):
	inventory_interface.visible = not inventory_interface.visible
	if _external_inventory_owner:
		inventory_interface.set_external_inventory(_external_inventory_owner)
