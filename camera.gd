extends Camera2D

@export var target: Node2D  # Référence du joueur ou cible
@export var follow_speed: float = 5.0  # Vitesse de suivi
@export var move_speed: float = 200.0  # Vitesse de déplacement manuel

var is_manual_control := false  # Permet de passer du mode auto au mode manuel

func _process(delta):
	var input_vector = Vector2.ZERO

	# Détection des touches ZQSD
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	# Si un mouvement est détecté, activer le mode manuel
	if input_vector != Vector2.ZERO:
		is_manual_control = true

	# Passer en mode automatique si aucune touche n'est pressée
	elif target and is_manual_control and !Input.is_anything_pressed():
		is_manual_control = false

	# Mode manuel : déplacer la caméra avec ZQSD
	if is_manual_control:
		position += input_vector.normalized() * move_speed * delta

	# Mode auto : suivre la cible en douceur
	elif target:
		position = position.lerp(target.position, follow_speed * delta)
