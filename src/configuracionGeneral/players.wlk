import wollok.game.*
import configuracionCampeones.teams.*
import fightingSystem.*

object playerSelector {
	
var property turn = 1
var property firstSelector = player1
var property secondSelector = player2

	method reset() {
		turn = 1
		firstSelector = player1
		secondSelector = player2
	}
	
}

class Player {
	
var property banner = new Banner(player=self)

	method team()
	method number()
	
	method name() {
		return self.team().name() + self.number()
	}
	
	method nextPlayer()
	method showBanner() {
		game.addVisual(banner)
	}
	
}

object player1 inherits Player {
	
var property team = lightness
const property number = 1

	override method nextPlayer() { return player2 }
	
}

object player2 inherits Player {
	
var property team = darkness
const property number = 2
	
	override method nextPlayer() { return player1 }
	
}


object flag {
	const property position = game.at(13,11)
	
	method image() {
		return "mainFlag.png"
	}
}

class Banner {
	var property player
	
	method image() {
		return player.name() + self.denoteActualTurn() + ".png" 
	}
	
	method denoteActualTurn() {
		return
		if(warSystem.actualTurn().number() == player.number()) {
			"s"
		}
		else { "x" }
	}
	
	method position() {
		return player.team().bannerPosition()
	}
}











