extends Node2D
class_name PlacedObject


var item: ItemData


func setup(new_item: ItemData):
	item = new_item

	update_visual()



func update_visual():
	if item:
		$Sprite2D.texture = item.icon
