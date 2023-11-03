extends Node2D
class_name Weapon

enum STATES { READY, FIRING, RELOADING }

@export var BULLET_SCENE: PackedScene


@onready var reload_timer = $ReloadTimer

var state: STATES = STATES.READY

func change_state(new_state: STATES):
	state = new_state
	
func fire():
	if state == STATES.FIRING || state == STATES.RELOADING:
		return
		
	change_state(STATES.FIRING)
	#make a bullet and move it 
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	get_tree().root.add_child(bullet)
	change_state(STATES.RELOADING)
	reload_timer.start()

func _on_reload_timer_timeout():
	change_state(STATES.READY)
