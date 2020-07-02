import wollok.game.*
import fightingSystem.*
import champions.*

object cursor {
	
var property position = game.origin()
var property image = "cursor1.png"	
var property initialPosition = 0
var property attackStage = false
	
	method image() {
		return if(!attackStage) {
				  "cursor1.png"
			   }
		  else if(attackStage and allChampions.isFromTeam(self.collider(), warSystem.actualTurn().team())) {
			   	  "cursor2.png"
			   }
		  else { "cursor3.png" }
	}
	
	method nextChar(list) {
		if (initialPosition < list.size() - 1) {
			initialPosition += 1
			//self.position(list.get(initialPosition).position())
			position = list.get(initialPosition).position()
		}
		else {
			initialPosition = 0
			//self.position(list.head().position())
			position = list.head().position()
		}
	}
	
	method previousChar(list) {
		if (initialPosition > 0) {
			initialPosition -= 1 
			//self.position(list.get(initialPosition).position())
			position = list.get(initialPosition).position()
		}
		else {
			initialPosition = list.size() - 1
			//self.position(list.last().position())
			position = list.last().position()
		}
	}
	
	method adjustAfterSelection(list) {
		initialPosition = 0
		//self.position(list.head().position())
		position = list.head().position()
	}
	
	method adjustAfterSelectionBattle(team) {
		initialPosition = 0
		position = team.nextTeam().champions().head().position()
	}
	
	method removeActual(list) {
		list.remove(game.uniqueCollider(self))
	}
	
	method collider() {
		return game.uniqueCollider(self)
	}

}


object index {

var index = 0


	
}
