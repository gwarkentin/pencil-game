extends Node

func play_random_sound(container_name):
	var container = self.get_node(container_name)
	var sound = container.get_children()[rand_range(0,container.get_child_count())]
	sound.play()

	
