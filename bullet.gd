extends Area2D
class_name Bullet

@export var SPEED = 1

var direction := Vector2()

func _shoot_at_mouse(start_pos):
	self.global_position = start_pos
	direction = (get_global_mouse_position() - start_pos).normalized()

func _physics_process(_delta):
	position += direction * SPEED

