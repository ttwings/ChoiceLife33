extends Node


enum 季节{春}
enum SEASON{SPRING,SUMMER,AUTUMN,WINTER}
var turn_number := 0
var second := 0
var minute := 0
var hour := 0
var day := 0
var season = SEASON.SPRING
var year := 0

func increment():
	turn_number = turn_number + 1
