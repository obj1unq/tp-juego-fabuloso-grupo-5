import wollok.game.*
import fightingSystem.*
import configuracionCampeones.champions.*

object cursor {
	
var property position = game.origin()
var property image = "cursor1.png"	 
var property initialPosition = 0
var property attackStage = false
	
	method initializeForBattle() {
		if(!warSystem.actualTurn().team().isDefeated()) {
			attackStage = false
			position = warSystem.actualTurn().team().champions().head().position()
			initialPosition = 0
			self.addVisual()
		}
	}
	
	method image() {
		return if(!attackStage) {
				  "cursor1.png"
			   }
		  else if(attackStage and championsInBattle.isFromTeam(self.collider(), warSystem.actualTurn().team())) {
			   	  "cursor2.png"
			   }
		  else { "cursor3.png" }
	}
	
	method nextChar(list) {
		if (initialPosition < list.size() - 1 && not list.isEmpty()) {
			initialPosition += 1
			position = list.get(initialPosition).position()
		}
		else if (initialPosition >= list.size() - 1 && not list.isEmpty()) { 
			initialPosition = 0
			position = list.head().position()
		}
	}
	
	method previousChar(list) {
		if (initialPosition > 0 && not list.isEmpty()) {
			initialPosition -= 1 
			position = list.get(initialPosition).position()
		}
		else if (initialPosition <= 0 && not list.isEmpty()) {
			initialPosition = list.size() - 1
			position = list.last().position()
		}
	}
	
	method adjustAfterSelection(list) {
		initialPosition = 0
		position = list.head().position()
	}
	
	method adjustAfterSelectionBattle(team) {
		initialPosition = 0
		position = team.nextTeam().listAfterSelection().head().position()
	}
	
	method removeActual(list) {
		list.remove(self.collider())
	}
	
	method collider() {
		return game.uniqueCollider(self)
	}
	
	method nextStage() {
		attackStage = !attackStage
	}
	
	method setAfterSelection() {
		self.nextStage()
        self.adjustAfterSelectionBattle(warSystem.actualTurn().team())
	}
	
	method isInGame() {
		return game.hasVisual(self)
	}
	
	method addVisual() {
		if(!self.isInGame()) {
			game.addVisual(self)
		}
	}
	
	method removeVisual() {
		if(self.isInGame()) {
			game.removeVisual(self)
		}
	}

}
