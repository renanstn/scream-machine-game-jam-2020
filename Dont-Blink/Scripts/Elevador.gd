extends KinematicBody2D

const SPEED = 18
export(int) var MAX_FLOOR

onready var timer = $Timer
onready var light = $Light2D
onready var sound = $ElevatorSound
onready var arrive_sound = $ArriveSound
onready var animation = $AnimationPlayer
onready var interactive_area = $InteractiveArea
onready var collision_interactive = $InteractiveArea/CollisionInteractive

var actual_floor : int = 0
var desired_floor : int
var going_up : bool
var going_down : bool
var working : bool = false
var floor_positions = {}

func _ready():
	# Salvar as posições globais dos andares
	var floor_markers = get_tree().get_nodes_in_group("floor")
	for marker in floor_markers:
		floor_positions[marker.floor_number] = marker.global_position

func _physics_process(delta):
	# Subindo
	if desired_floor > actual_floor:
		var itens = interactive_area.get_overlapping_bodies()
		for item in itens:
			if item.name == "Player":
				item.can_control = false
				item.animation_player.play("idle")
				item.motion = Vector2(0, -SPEED)
		var vetor = Vector2(0, -SPEED)
		move_and_slide(vetor)
	# Descendo
	elif desired_floor < actual_floor:
		var itens = interactive_area.get_overlapping_bodies()
		for item in itens:
			if item.name == "Player":
				item.can_control = false
				item.animation_player.play("idle")
				item.motion = Vector2(0, SPEED)
		var vetor = Vector2(0, SPEED)
		move_and_slide(vetor)

	# Verificar se já chegou no andar desejado
	if going_up:
		if global_position.y <= floor_positions[desired_floor].y:
			actual_floor = desired_floor
			arrive()
	if going_down:
		if global_position.y >= floor_positions[desired_floor].y:
			actual_floor = desired_floor
			arrive()

func change_floor(floor_number):
	if floor_number >= 0 and floor_number < MAX_FLOOR:
		desired_floor = floor_number
		if desired_floor > actual_floor:
			going_up = true
		if desired_floor < actual_floor:
			going_down = true
		var elevator_doors = get_tree().get_nodes_in_group("elevator_door")
		for door in elevator_doors:
			if door.level == actual_floor:
				door.close_door()
		if not sound.playing:
			sound.play()
		animation.play("working")
		working = true

func arrive():
	going_up = false
	going_down = false
	working = false
	arrive_sound.play()
	var elevator_doors = get_tree().get_nodes_in_group("elevator_door")
	for door in elevator_doors:
		if door.level == actual_floor:
			door.open_door()
	animation.play("stop")
	# Devolve o controle ao player
	var itens = interactive_area.get_overlapping_bodies()
	for item in itens:
		if item.name == "Player":
			item.can_control = true

func _on_Timer_timeout():
	"""
	Efeito de fazer a luz dar pequenas piscadas
	"""
	var next_wait_time : float
	if light.enabled:
		next_wait_time = rand_range(1, 3)
	else:
		next_wait_time = rand_range(0.05, 1.0)
	light.enabled = !light.enabled
	timer.wait_time = next_wait_time
