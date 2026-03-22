class_name Mission
extends Node

@export var object: StationPart;
@export var socket: StationSocket;
@export var fixed: Node2D;

func activate():
	object.active = true;
	socket.detecting = true;
