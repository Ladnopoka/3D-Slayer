## Code written by Minoqi @2024 under the MIT license
## Documentation: https://github.com/Minoqi/minos-damage-numbers-for-godot

extends Node

## Variables
enum DamageType{
	NORMAL,
	CRITICAL_HIT,
	BURN,
	POISON,
	STUN
}

# Labels
var damageNumbersLabelPrefab3D : PackedScene = preload("res://addons/minos_damage_numbers/DamageNumbersLabel3D.tscn")
var usedLabels : Array[Label3D] = []
var unusedLabels : Array[Label3D] = []

# Colors
var normalColor : Color = Color(248 / 255.0, 248 / 255.0, 242 / 255.0, 1.0)#255)
var criticalColor : Color = Color(255 / 255.0, 85 / 255.0, 85 / 255.0, 1.0)#255)

# Tween
var upTweenAmount : float = 1
var upTweenLength : float = 2.0
var downTweenLength : float = 1.0

const DIABLO_HEAVY = preload("res://globals/Diablo Heavy.ttf")
const BILDAD = preload("res://globals/Bildad.ttf")

func _get_label() -> Label3D:
	var newLabel : Label3D
	
	if unusedLabels.size() != 0:
		newLabel = unusedLabels.pop_back()
		usedLabels.append(newLabel)
		newLabel.visible = true
	else:
		newLabel = damageNumbersLabelPrefab3D.instantiate()
		add_child(newLabel)
	
	usedLabels.append(newLabel)
	return newLabel


func display_number(_value : int, _position : Vector3, _damageType : DamageType = DamageType.NORMAL) -> void:
	var numberLabel : Label3D = _get_label()
	numberLabel.global_position = _position
	numberLabel.text = str(_value)
	numberLabel.font_size = 200
	numberLabel.outline_size = 50
	numberLabel.font = DIABLO_HEAVY
	
	match _damageType:
		DamageType.NORMAL:
			numberLabel.modulate = normalColor
		DamageType.CRITICAL_HIT:
			numberLabel.modulate = criticalColor
		_:
			numberLabel.modulate = normalColor
	
	#label_targets[numberLabel] = _position
	_animate_display(numberLabel)


func _animate_display(_currentDisplay : Label3D) -> void:
	var originalYPos : float = _currentDisplay.global_position.y
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(_currentDisplay, "position:y", originalYPos + upTweenAmount, upTweenLength).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(_currentDisplay, "position:y", originalYPos, downTweenLength).set_ease(Tween.EASE_IN).set_delay(upTweenLength)
	tween.parallel().tween_property(_currentDisplay, "modulate:a", 0, downTweenLength).set_ease(Tween.EASE_IN).set_delay(upTweenLength)
	
	await tween.finished
	
	_currentDisplay.visible = false
	usedLabels.erase(_currentDisplay)
	unusedLabels.append(_currentDisplay)


func disable_numbers() -> void:
	for number in usedLabels:
		number.visible = false
