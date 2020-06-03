import wollok.game.*
import teams2.*
import fightingSystem.*

object cursor {
	
	var property position
	var property stage = "attacker"
	var property teamTurn = warSystem.teamTurn()
	
	method image() { return self.cursorType("cursor1.png", "cursor2.png", "cursor3.png") }
	
	method nextStage() {
		if (stage == "attacker") {
			stage = "enemy"
		} else {
			stage = "attacker"
		}
	}
	
	method cursorType(img1, img2, img3) {
		return if (stage == "attacker") { img2 } 
			   else if(stage == "enemy" && warSystem.teamTurn().isFromTeam(self.champInActualPosition())) { img3 } 
			   else { img1 }
	}
	
	method champInActualPosition() {
		return game.uniqueCollider(self)
	}
	
	method changeTeam(team) {
		if (not team.champions().isEmpty())
		self.position(team.champions().head().position())
	}
	
}