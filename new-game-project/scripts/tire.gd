extends StaticBody3D

func interact():
	GlobalInventory.tire += 1
	queue_free()
