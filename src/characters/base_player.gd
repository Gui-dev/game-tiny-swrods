extends CharacterBody2D
class_name BasePlayer

var _can_attack: bool = true
var _attack_animation_name: String = ""
@export_category("ACTIONS")
@export var _move_speed: float = 128.0
@export var _left_attack_name: String = ""
@export var _right_attack_name: String = ""
@export_category("OBJECTS")
@export var _animation: AnimationPlayer
@export var _sprite2D: Sprite2D


func _physics_process(delta: float) -> void:
  _move()
  _attack()
  _animate()
  
  
func _move() -> void:
  var _direction: Vector2 = Input.get_vector(
    "move_left", "move_right", "move_up", "move_down"
  )
  velocity = _direction * _move_speed
  move_and_slide()


func _attack() -> void:
  if Input.is_action_just_pressed("left_attack") and _can_attack:
    _can_attack = false
    _attack_animation_name = _left_attack_name
    set_physics_process(false)
    
  if Input.is_action_just_pressed("right_attack") and _can_attack:
    _can_attack = false
    _attack_animation_name = _right_attack_name
    set_physics_process(false)
    

func _animate() -> void:
  if velocity.x > 0:
    _sprite2D.flip_h = false
    
  if velocity.x < 0:
    _sprite2D.flip_h = true
    
  if _can_attack == false:
    _animation.play(_attack_animation_name)
    return
  
  if velocity:
    _animation.play("run")
    return
  
  _animation.play("idle")


func _on_animation_finished(anim_name: StringName) -> void:
  if anim_name == _left_attack_name or anim_name ==_right_attack_name:
    _can_attack = true
    set_physics_process(true)
