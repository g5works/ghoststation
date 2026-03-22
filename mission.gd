class_name Mission
extends Node

@export var object: StationPart;
@export var socket: StationSocket;

func activate():
	object.active = true;
	socket.detecting = true;
