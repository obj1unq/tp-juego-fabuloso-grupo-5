import wollok.game.*
import teams.*

object playerSelector {
	
var property turn = 1
var property firstSelector = player1
var property secondSelector = player2
	
}

object player1 {
	
var property team = lightness
const property number = 1
	
	method nextPlayer() {
		return player2
	}

}

object player2 {
	
var property team = darkness
const property number = 2
	
	method nextPlayer() {
		return player1
	}
}
