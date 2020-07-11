import wollok.game.*
import configuracionCampeones.teams.*
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
		return "dice1.png"
	}
}

class Banner {
	const property player
	
	method image() {
		return player.team().name() + player.number().toString() + self.denoteActualTurn() + ".png" 
	}
	
	method denoteActualTurn() {
		return
		if(warSystem.actualTurn().number() == player.number()) {
			"s"
		}
		else { "" }
	}
	
	method position() {
		return player.team().bannerPosition()
	}
}











