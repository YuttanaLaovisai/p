extends StaticBody3D

@onready var alert = $"../alert"

#func interact():
	#if GlobalInventory.fuel != 1 and GlobalInventory.tire != 4:
		#alert.visible = true
		#await get_tree().create_timer(2).timeout
		#alert.visible = false
	#else:
		#var fade = get_tree().get_first_node_in_group("FadeGroup")
		#await fade.fade_out(1.5) # 1.5 วิ
		#get_tree().change_scene_to_file("res://scenes/ending.tscn")

func interact():
		SceneTransition.chang_scene("res://scenes/ending.tscn")
