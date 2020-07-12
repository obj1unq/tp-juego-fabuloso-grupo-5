import wollok.game.*

class Dice {
	
var property image = "dice1"
const numbers = (1..6)
var property number = 1
var property position = game.origin()

	
	method roll() {
		number = numbers.anyOne()
		image = "dice" + number.toString() + ".png"
	}
	
	method isGreater(dice) {
		return number > dice.number()
	}
	
}