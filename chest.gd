extends RigidBody2D
class_name Chest

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

@onready var interaction_area := $InteractionArea
@onready var sprite_2d = $Sprite2D

func _ready():
	interaction_area.interact = Callable(self, "_open_chest")

func _open_chest():
	print("Opened Chest")
# build inventory
	toggle_inventory.emit(self)
#build loot from table
#open inventory gui displaying loot result
#take loot button moves loot to inventory 



#what happens when I do?


#4 different loot tables common, uncommon, rare, epic, plus unique
# Creature has resource to hold percentage drop from each table plus a dictionary of unique drops 
