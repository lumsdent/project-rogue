extends CharacterBody2D
class_name Player

signal toggle_inventory

@onready var head_sprite = $CompositeSprites/Head
@onready var body_sprite = $CompositeSprites/Body
@onready var arm_sprite = $CompositeSprites/Arms
@onready var leg_sprite = $CompositeSprites/Legs

@onready var animation_tree = $CompositeSprites/AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var speed = 100
@export var direction: Vector2 = Vector2.RIGHT
@export var weapon : Weapon
@export var inventory_data: InventoryData

const COMPOSITE_SPRITES = preload("res://Art/Player/CompositeSprites.gd")

var curr_head := 0
var curr_body := 0
var curr_arm := 0
var curr_leg := 0

func _ready():
	animation_tree.set("parameters/Idle/blend_position", direction)
	head_sprite.texture = COMPOSITE_SPRITES.head_spritesheet[curr_head]
	body_sprite.texture = COMPOSITE_SPRITES.body_spritesheet[curr_body]
	arm_sprite.texture = COMPOSITE_SPRITES.arm_spritesheet[curr_arm]
	leg_sprite.texture = COMPOSITE_SPRITES.leg_spritesheet[curr_leg]



func _physics_process(_delta):
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	update_animation_parameters(input_direction)
	pick_new_state()
	move_and_slide()
	

func update_animation_parameters(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_state():
	if(velocity!=Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func _on_change_body_pressed():
	curr_body = (curr_body + 1) % COMPOSITE_SPRITES.body_spritesheet.size()
	body_sprite.texture = COMPOSITE_SPRITES.body_spritesheet[curr_body]

func _unhandled_input(event):
	if event.is_action_pressed("weapon_fire"):
		weapon.fire()
	elif event.is_action_pressed("inventory"):
		toggle_inventory.emit()
		
