import wollok.game.*
import teams.*
import fightingSystem.*

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

object flag {
	const property position = game.at(14,12)
	
	method image() {
		return warSystem.actualTurn().toString() + "flag.png"
	}
}

class Banner {
	const property player
	
	method image() {
		return warSystem.actualTurn().toString() + player.toString() + "banner.png"
	}
	
	method position() {
		return player.team().bannerPosition()
	}
}











