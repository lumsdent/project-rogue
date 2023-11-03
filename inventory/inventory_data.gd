extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interacted(inventory_data: InventoryData, index: int, button_clicked: int)

@export var slot_datas : Array[SlotData]

func on_slot_clicked(index: int, button_clicked: int):
	inventory_interacted.emit(self, index, button_clicked)

func pick_slot_data(index: int):
	var slot_data = slot_datas[index]
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

func place_slot_data(grabbed_slot_data: SlotData, index: int):
	var clicked_slot_data = slot_datas[index]
	
	var item_grabbed_when_done: SlotData
	if clicked_slot_data and clicked_slot_data.can_fully_merge_with(grabbed_slot_data):
		clicked_slot_data.fully_merge_with(grabbed_slot_data)	
	else:
		slot_datas[index] = grabbed_slot_data
		item_grabbed_when_done = clicked_slot_data
	inventory_updated.emit(self)
	return item_grabbed_when_done
