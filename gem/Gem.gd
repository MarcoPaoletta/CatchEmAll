extends Area2D

func _ready():
	$Tween.interpolate_property(
		$AnimatedSprite,
		"scale",
		$AnimatedSprite.scale, 
		$AnimatedSprite.scale * 5,
		0.3,Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$AnimatedSprite,
		"modulate",
		Color(1,1,1,1), 
		Color(1,1,1,0),
		0.3,Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	
func pickup():
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	call_deferred("queue_free")

func _on_Gem_area_entered(area):
	if area.is_in_group("enemy"):
		self.position.x = rand_range(25,470)
		self.position.y = rand_range(25,700)
