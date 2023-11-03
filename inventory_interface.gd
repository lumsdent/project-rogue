extends Control

@onready var player_inventory = $PlayerInventory
@onready var external_inventory = $ExternalInventory
@onready var grabbed_slot = $GrabbedSlot

var external_inventory_owner
var grabbed_slot_data : SlotData

func _physics_process(_delta: float):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(2, 2)

func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interacted.connect(on_inventory_interacted)
	player_inventory.set_inventory_data(inventory_data)

func set_external_inventory(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	inventory_data.inventory_interacted.connect(on_inventory_interacted)
	external_inventory.set_inventory_data(inventory_data)
	
	external_inventory.show()

func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		external_inventory.clear_inventory_data(inventory_data)
	
		external_inventory.hide()
		external_inventory_owner = null

func on_inventory_interacted(inventory_data: InventoryData, index: int, button_clicked: int):
	match [grabbed_slot_data, button_clicked]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.pick_slot_data(index)
		[_,MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.place_slot_data(grabbed_slot_data, index)
		
	update_grabbed_slot()
	
func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.find_child("SlotTexture").visible = false
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
