extends Node

var player_speed: int = 125
var player_strength: int = 25
var enemy_speed: int = 100
var enemy_strength: int = 10 + wave_multiplier
var kills: int = 0
var euro: int = 0
var wave_multiplier: float = (1 + (0.02 * wave))
var wave: int = 0

func reset() -> void:
	player_speed = 100
	player_strength = 25
	enemy_speed = 100
	enemy_strength = 10
	kills = 0
	euro = 0
	wave_multiplier = 1.0
	wave = 0
