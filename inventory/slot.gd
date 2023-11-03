extends PanelContainer

@onready var item_texture = $MarginContainer/ItemTexture
@onready var label = $Label

signal slot_clicked(index :int, button_clicked: int)

func set_slot_data(slot_data:SlotData):
	var item_data = slot_data.item_data
	item_texture.texture = item_data.texture
	
	if slot_data.quantity > 1:
		label.text = "x%s" % slot_data.quantity 
		label.show()
	else:
		label.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
