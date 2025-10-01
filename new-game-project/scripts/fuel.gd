extends StaticBody3D


func interact():
	GlobalInventory.fuel += 1
	queue_free()
