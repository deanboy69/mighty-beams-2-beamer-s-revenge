extends Node2D

const ENEMY1 = preload('res://scenes/enemy1.tscn')

var screenWidth = ProjectSettings.get_setting('display/window/size/width')
var screenHeight = ProjectSettings.get_setting('display/window/size/height')

var direction = Vector2(0, 0)
var spacing = 70

func addAsGrid(size):
    for y in range (size.y):
        var newPos = Vector2(0, y)
        for x in range (size.x):
            newPos.x = x
            createEnemy1(newPos)

func createEnemy1(pos):
    var enemy1 = ENEMY1.instance()
    enemy1.position = pos * spacing
    add_child(enemy1)

func moveFormation(delta):
    position += direction * delta
    if direction.y > 0.0:
        position.y += direction.y
        direction.y -= 1.0

func checkBorderReached():
    for enemy1 in get_children():
        if hitLeftBorder(enemy1) or hitRightBorder(enemy1):
            direction.x = -direction.x
            direction.y = 8.0
            break

func hitLeftBorder(enemy1):
    if direction.x < 0.0:
        if enemy1.global_position.x < 0:
            return true
    return false

func hitRightBorder(enemy1):
    if direction.x > 0.0:
        if enemy1.global_position.x > screenWidth:
            return true
    return false

func _process(delta):
    moveFormation(delta)
    checkBorderReached()